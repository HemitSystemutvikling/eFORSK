> **⚠️ DETTE DOKUMENTET BRUKES IKKE AV NETTSIDEN**
>
> README.md er kun for GitHub-visning og er ikke koblet til noen side på nettstedet.
> Teksten her oppdateres ikke automatisk noe sted.
>
> **Vil du redigere innhold på nettsiden? Se tabellen nedenfor.**

---

# Hvor redigerer du innhold?

| Side på nettsiden | Fil du skal redigere |
|---|---|
| Forsiden (seksjonene Hvorfor eFORSK, Funksjoner, Nyheter, Om oss) | Se `_data/`-mappen nedenfor |
| Bruk av eFORSK | [`bruk.md`](bruk.md) |
| Teknisk løsning | [`teknisk.md`](teknisk.md) |
| Om oss | [`om-oss.md`](om-oss.md) |

> **Merk:** [`prosedyrer.md`](prosedyrer.md) er intern dokumentasjon og vises **ikke** på nettsiden.

## Forsidensdata (`_data/`-mappen)

| Innhold | Fil |
|---|---|
| Nyheter / siste oppdateringer | [`_data/news.yml`](_data/news.yml) |
| Funksjonskort (de 7–8 kort) | [`_data/features.yml`](_data/features.yml) |
| «Hvorfor eFORSK»-punkter | [`_data/why.yml`](_data/why.yml) |
| Hero-tekst, seksjonsoverskrifter, CTA | [`_data/tekst.yml`](_data/tekst.yml) |

## Hva skal du IKKE redigere?

- `_layouts/` — HTML-struktur og design (kun for utviklere)
- `_data/om.yml` — brukes minimalt, innholdet er flyttet til `.md`-filene over
- `assets/` — CSS og søkeindeks
- `index.md` — bare teknisk pekeinnhold, selve teksten er i `_data/`

---

# Om eFORSK

eFORSK er en plattformuavhengig IKT-løsning utviklet av Hemit for å bistå kliniske forskere i Helse Midt-Norge med å samle inn data fra studiedeltakere på en effektiv og sikker måte.

Se [eforsk.hemit.org](https://eforsk.hemit.org) for den publiserte nettsiden.