#!/usr/bin/env ruby
# encoding: UTF-8
# frozen_string_literal: true

require 'json'
require 'time'
require 'cgi'

ROOT = File.expand_path('..', __dir__)
DOC_EXT = '.md'
OUTPUT_PATH = File.join(ROOT, 'assets', 'search-index.json')
EXCLUDE_DIRS = %w[vendor _site node_modules scripts assets/img assets/images .git].freeze

def strip_markdown(source)
  return '' unless source
  text = source.dup
  if text.start_with?('---')
    parts = text.split(/^---\s*$\n/, 3)
    text = parts[2] || parts[1] || ''
  end
  text.gsub!(/```[\s\S]*?```/m, ' ')
  text.gsub!(/`[^`]*`/, ' ')
  text.gsub!(/!\[([^\]]*)\]\([^)]*\)/, '\1 ')
  text.gsub!(/\[([^\]]+)\]\(([^)]+)\)/, '\1 ')
  text.gsub!(/<[^>]+>/, ' ')
  text.gsub!(/[#>*_~`|]/, ' ')
  text.gsub!(/\s+/, ' ')
  text.strip!
  text
end

Doc = Struct.new(:id, :title, :content, :url, :type) do
  def as_json(*)
    { id: id, title: title, content: content, url: url, type: type }
  end
end

def classify(path)
  return 'release-note' if path.include?('releasenotes/')
  'guide'
end

def anchorize(text)
  text.downcase.gsub(/[^\p{Word}\- ]/u, '').strip.gsub(' ', '-')
end

markdown_files = Dir.glob(File.join(ROOT, '**', '*.md')).reject do |f|
  rel = f.sub(ROOT + File::SEPARATOR, '')
  parts = rel.split(File::SEPARATOR)
  parts.any? { |p| EXCLUDE_DIRS.include?(p) }
end

docs = []
markdown_files.sort.each do |abs|
  rel = abs.sub(ROOT + File::SEPARATOR, '')
  raw = File.read(abs, mode: 'r:BOM|UTF-8', invalid: :replace, undef: :replace, replace: '') rescue ''
  fname = File.basename(abs, DOC_EXT)
  url_base = '/' + rel.sub(DOC_EXT, '.html').gsub(' ', '%20')
  type = classify(rel)

  # Detect front matter presence
  has_front_matter = raw.start_with?('---')

  # Special-case README without front matter: point to index.html (homepage)
  if rel == 'README.md' && !has_front_matter
    url_base = '/index.html'
  end

  sections = []
  current = { title: nil, content: String.new, anchor: nil }

  raw.each_line do |line|
    if line =~ /^(#+)\s+(.*)/
      if current[:title]
        sections << { title: current[:title], content: current[:content].dup, anchor: current[:anchor] }
      end
      current[:title] = $2.strip
      current[:anchor] = anchorize(current[:title])
      current[:content] = String.new
    else
      current[:content] << line
    end
  end
  sections << { title: current[:title], content: current[:content], anchor: current[:anchor] } if current[:title]

  if sections.empty?
    cleaned = strip_markdown(raw)
    docs << Doc.new(rel, fname, cleaned, url_base, type)
  else
    sections.each do |section|
      cleaned = strip_markdown(section[:content])
      next if cleaned.empty?
      id = "#{rel}##{section[:anchor]}"
      url = "#{url_base}##{section[:anchor]}"
      docs << Doc.new(id, section[:title], cleaned, url, type)
    end
  end
end

payload = {
  generated_at: Time.now.utc.iso8601,
  doc_count: docs.size,
  docs: docs.map(&:as_json)
}

File.write(OUTPUT_PATH, JSON.pretty_generate(payload) + "\n")
warn "Wrote #{docs.size} sections to #{OUTPUT_PATH}"