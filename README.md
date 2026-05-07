# Typst-Template für die schriftliche Ausarbeitung der 5. Prüfungskomponente am Lise-Meitner OSZ (Inoffiziell)

Typst-Template für die schriftliche Ausarbeitung zur 5. Prüfungskomponente am OSZ Lise-Meitner in Berlin. Du schreibst den Inhalt, das Template übernimmt Deckblatt, Inhaltsverzeichnis, Quellenangaben und Eigenständigkeitserklärung.

Die Vorlage ist bewusst schlank gehalten, du kannst die gerne clonen und bearbeiten.

Typst template for the written report for the 5th examination component at OSZ Lise-Meitner in Berlin. You write the content; the template takes care of the cover page, table of contents, references, and declaration of originality.
Thought this Template is only intended for German users here is a english version of readme: [README-en.md](README-en.md)

## Voraussetzungen

- Typst 0.14.2 oder neuer
- Eine der unterstützten Schriftarten: Arial, Times New Roman oder Verdana (Times New Roman = 12pt, die anderen 11pt)
- Unter Linux am besten die Microsoft-Core-Fonts oder eine entsprechende Schriftartinstallation

```bash
# Unter Debian/Ubuntu/Linux Mint:
sudo snap install typst
sudo apt install ttf-mscorefonts-installer
# ODER 
sudo apt install cargo
cargo install typst-cli
sudo apt install ttf-mscorefonts-installer

# Unter Arch Linux:
sudo pacman -S typst
yay -S ttf-ms-fonts

# Unter Fedora:
sudo dnf install typst
sudo dnf install curl cabextract xorg-x11-font-utils fontconfig
sudo rpm -i https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm
```

## Schnellstart

Wenn das Paket lokal installiert ist, kannst du damit ein neues Projekt erzeugen:

```bash
typst init @local/abi-ausarbeitung-lmo:0.1.0 meine-ausarbeitung
cd meine-ausarbeitung
typst watch main.typ
```

Wenn du direkt im Repository arbeitest, kompiliere das Beispiel aus dem Template-Ordner:

```bash
typst watch --root . template/main.typ
```

Die zentrale Idee ist ein `#show: ausarbeitung.with(...)`-Block. Alles, was danach in der Datei steht, wird als Hauptteil der Ausarbeitung gesetzt.

```typst
#import "@local/abi-ausarbeitung-lmo:0.1.0": ausarbeitung

#show: ausarbeitung.with(
	leitfrage: "Eine sehr interessante Leitfrage über Heidelbeeren und deren Funktion in der Gesellschaft!",
	name: "Max Mustermann",
	referenzfach: "Geschichte",
	bezugsfach: "Politikwissenschaft",
	pruefer: ((name: "Frau Dr. Muster"), (name: "Herr Beispiel")),
	vorgelegt_am: datetime.today(),
	abgabetermin_am: datetime(year: 2026, month: 3, day: 15),
	bibliography: bibliography("references.bib", style: "handout-5pk-lmo.csl", title: none),
)

= Themenfindung

Hier beginnt deine Ausarbeitung.
```

Du kannst im Hauptteil ganz normal mit Überschriften, Aufzählungen, Zitaten und Quellen arbeiten. Zitate werden durch das Template als Fußnoten ausgegeben.

## Parameter

### Die musst du auf jeden Fall angeben

| Parameter | Bedeutung |
| --- | --- |
| `leitfrage` | Leitfrage bzw. Titel auf dem Deckblatt |
| `name` | Dein Name |
| `referenzfach` | Erstes Fach der 5. PK |
| `bezugsfach` | Zweites Fach der 5. PK |
| `pruefer` | Liste der Prüfenden, z. B. `((name: "Frau Muster"), (name: "Herr Beispiel"))` |
| `vorgelegt_am` | Datum der Abgabe als `datetime` |
| `abgabetermin_am` | Frist als `datetime` |
| `body` | Der restliche Dokumentinhalt nach dem `#show`-Block |

### Optional

| Parameter | Standard | Bedeutung |
| --- | --- | --- |
| `bibliography` | `none` | Literatur- und Medienverzeichnis |
| `gruppenarbeit` | `false` | Erzeugt auf der Erklärungsseite die Wir-Form |
| `stadt` | `Berlin` | Ort in der Eigenständigkeitserklärung |
| `abstand-oben` | `25mm` | Oberer Seitenrand |
| `abstand-unten` | `25mm` | Unterer Seitenrand |
| `abstand-links` | `25mm` | Linker Seitenrand |
| `abstand-rechts` | `25mm` | Rechter Seitenrand |
| `schriftart` | `Times New Roman` | `Arial`, `Times New Roman` oder `Verdana` (Times New Roman = 12pt, die anderen 11pt) |

links/rechts müssen zwischen 20 mm und 30 mm liegen, oben/unten zwischen 20 mm und 25 mm. Bei der Schriftart sind nur die drei oben genannten Werte erlaubt.

`vorgelegt_am` darf nicht nach `abgabetermin_am` liegen. Beide Werte müssen echte `datetime`-Objekte sein, also zum Beispiel `datetime.today()` oder `datetime(year: 2026, month: 3, day: 15)`.

Füge die Quellen in `references.bib` ein und verwende im Text die üblichen Typst-Zitate, zum Beispiel `@mustermann2024` oder `#cite(<mustermann2024>)`


## Wichtige Dateien

- [lib.typ](lib.typ) enthält die öffentliche Funktion `ausarbeitung()`
- [elemente/deckblatt.typ](elemente/deckblatt.typ) rendert das Deckblatt
- [elemente/declaration.typ](elemente/declaration.typ) erzeugt die Eigenständigkeitserklärung
- [helpers/datum.typ](helpers/datum.typ) liefert Datumshilfen
- [helpers/validators.typ](helpers/validators.typ) enthält Funktionen zur Validierung der Parameter
- [template/main.typ](template/main.typ) zeigt ein lauffähiges Beispiel
- [template/references.bib](template/references.bib) ist die Beispiel-Bibliografie
- [template/handout-5pk-lmo.csl](template/handout-5pk-lmo.csl) ist der mitgelieferte Zitierstil

## Lizenz

MIT. Siehe [LICENSE](LICENSE).
