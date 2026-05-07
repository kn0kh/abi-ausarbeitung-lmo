#import "elemente/deckblatt.typ": render-deckblatt
#import "elemente/declaration.typ": eig-ung

#let _validate-algemein-inputs(  
  abstand-oben, 
  abstand-unten,
  abstand-links, 
  abstand-rechts, 
  schriftart
  ) = {
    assert(
      type(abstand-links) == length and abstand-links >= 20mm and abstand-links <= 30mm,
      message: "Linker Abstand soll zwischen 20mm und 30mm sein"
    )
    assert(
      type(abstand-rechts) == length and abstand-rechts >= 20mm and abstand-rechts <= 30mm,
      message: "Rechter Abstand soll zwischen 20mm und 30mm sein"
    )
    assert(
      type(abstand-oben) == length and abstand-oben >= 20mm and abstand-oben <= 25mm,
      message: "Obere Abstand soll zwischen 20mm und 25mm sein"
    )
    assert(
      type(abstand-unten) == length and abstand-unten >= 20mm and abstand-unten <= 25mm,
      message: "Untere Abstand soll zwischen 20mm und 30mm sein"
    )

    assert(
      schriftart in ("Arial", "Times New Roman", "Verdana"),
      message: "Die Schriftart kann nur Arial(11pt), Verdana(11pt) oder Times New Roman(12pt) sein"
    )
  }


#let ausarbeitung(
  abstand-oben: 25mm, // zwischen 20mm und 25mm
  abstand-unten: 25mm, // zwischen 20mm und 25mm
  abstand-links: 25mm, // zwischen 20mm und 30mm
  abstand-rechts: 25mm, // zwischen 20mm und 30mm
  schriftart: "Times New Roman", // "Arial" | "Times New Roman" | "Verdana"
  leitfrage: "Eine sehr interessante Leitfrage über Heidelbeere und deren Funktion in der Gesellschaft!", // deine Leitrfage
  name: "Max Mustermann", // dein Name
  referenzfach: "[Referenzfach]", // dein Referenzfach
  bezugsfach: "[Bezungsfach]", // dein Bezugsfach
  pruefer: ((name: "Frau Muster"), (name: "Herr Mann")), // deine Prüfende
  vorgelegt_am: datetime.today(), // Tag der Abgabe
  abgabetermin_am: datetime.today(), // Datum der Frist 
  body, // Hauptteil
  bibliography: none, // Literaturverzeichnis
  gruppenarbeit: false, // true = Gruppearbeit
  stadt: "Berlin", // Stadt in der die Arbeit geschrieben wird (veraussetzlich Berlin)
  ) = {

  // Algemein
  _validate-algemein-inputs(abstand-oben, abstand-unten, abstand-links, abstand-rechts, schriftart)
  //Randabstände
  set page(
    paper: "a4",
    margin: (top: abstand-oben, bottom: abstand-unten, left: abstand-links, right: abstand-rechts),
  )

  //Schriftgröße, Zeilenabstand und Schriftart
  let groesse = if schriftart == "Times New Roman" {12pt} else {11pt}
  set text(size: groesse, lang: "de", font: schriftart)
  set par(justify: true, leading: 0.65em)

  // Einrückung Listelementen
  set list(indent: 1em)

  // Farbe der Links
  show link: set text(fill: blue)

  // Überschriftenstyle
  set heading(numbering: "1.1")
  show heading.where(level: 1): set text(size: 20pt, weight: "bold")
  show heading.where(level: 2): set text(size: 16pt, weight: "bold")
  // Ebene 3: Überschrift — fetter inline-Text gefolgt von Geviertstrich
  show heading.where(level: 3): it => {
    text(weight: "bold", it.body)
    h(1em)
  }
  // Notes für Quellen
  show cite: (it) => footnote(it)

  //Deckblatt
  render-deckblatt(
    leitfrage: leitfrage,
    name: name,
    referenzfach: referenzfach,
    bezugsfach: bezugsfach,
    pruefer: pruefer, 
    vorgelegt_am: vorgelegt_am,
    abgabetermin_am: abgabetermin_am,
    stadt: stadt
  )

  //Inhaltsverzeichnis
  outline()
  pagebreak()


  //Hauptteil
  set page(numbering: "1")
  counter(page).update(1)
  body

  //Literaturverzeichnis
  if bibliography != none {
    pagebreak()
    heading(level: 1, numbering: none)[Literatur- und Medienverzeichnis]
    linebreak()
    bibliography
  }

  //Eigenständigkeitserklärung
  eig-ung(
    gruppenarbeit: gruppenarbeit,
    stadt: stadt,
    name: name
    )

}