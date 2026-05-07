#import "/helpers/datum.typ": aktuelles_abi, datum_bekommen

#let _validate-deckblatt-inputs(  
  leitfrage,
  name,
  referenzfach,
  bezugsfach,
  pruefer,
  vorgelegt_am,
  abgabetermin_am,
  stadt
  ) = {
    assert(type(leitfrage) == str, message:"Die Leitfrage soll ein string sein")
    assert(type(name) == str, message:"Name soll ein string sein")
    assert(type(referenzfach) == str, message: "Referenzfach soll ein string sein")
    assert(type(bezugsfach) == str, message: "Bezugsfach soll ein string sein")
    // check if pruefer follws this format ((name: "name"), (name: "name"))
    assert(type(pruefer) == array and pruefer.all(p => type(p) == dictionary and "name" in p), message: "Prüfer muss dem Format ((name: \"name\"), ...) entsprechen")
    assert(type(stadt) == str, message: "Stadt muss ein string sein")
    assert(
      type(vorgelegt_am) == datetime, 
      message: "vorgelegt_am soll ein datetime Objekt sein"
    )
    assert(
      type(abgabetermin_am) == datetime,
      message: "abgabetermin_am soll ein datetime Objekt sein"
    )
    assert(
      vorgelegt_am <= abgabetermin_am,
      message: "vorgelegt_am soll vor oder am selben Tag sein wie abgabetermin_am"
    )
  }

#let render-deckblatt(
  leitfrage: "Eine sehr interessante Leitfrage über Heidelbeere und deren Funktion in der Gesellschaft!",
  name: "Max Mustermann",
  referenzfach: "[Geschichte]",
  bezugsfach: "[Politikwissenschaft]",
  pruefer: ((name: "Frau Muster"), (name: "Herr Mann")),
  vorgelegt_am: datetime.today(),
  abgabetermin_am: datetime.today(),
  stadt: "Berlin"
) = {
  _validate-deckblatt-inputs(leitfrage, name, referenzfach, bezugsfach, pruefer, vorgelegt_am, abgabetermin_am, stadt)

  let jahr = aktuelles_abi()

  page(
    //header: lise-header,
    {
      v(5%)

      // Center align the description text in smallcaps
      align(center, smallcaps(text(size: 14pt)[
        #text(size: 24pt)[Schriftliche Ausarbeitung]\
        im Rahmen der 5. Prüfungskomponente des Abiturs\
        #v(1em)
        OSZ-Lise-Meitner \
        #jahr
      ]))

      v(1fr)
      // Name of the student
      align(center, text(size: 18pt, name))
      v(3em)
      // The title of the thesis
      align(center, text(size: 24pt, weight: "bold", leitfrage))
      v(3em)
      // The current date
      align(center, text(
        size: 12pt,
        stadt + ", " + datum_bekommen(),
      ))
      v(1fr)


      grid(
        columns: (1fr, 1fr),
        align: (center, center),
        [
          #text(weight: "bold", "Prüfungsfächer")
          #v(1mm)
          #text("Referenzfach: " + referenzfach) \
          #text("Bezugsfach: " + bezugsfach) \
        ],
        [
          #text(weight: "bold", "Prüfende")
          #v(1mm)
          #for pruefer in pruefer [
            #text(pruefer.name)\
          ]
        ],
      )
      v(3em)
      grid(
        columns: (1fr, 1fr, 1fr),
        align: (center, center),
        [],
        [
          #text(weight: "bold", "Vorgelegt am: ") #vorgelegt_am.display("[day].[month].[year repr:last_two]") \
          #text(weight: "bold", "Abgabetermin: ") #abgabetermin_am.display("[day].[month].[year repr:last_two]")
        ],
        [],
      )
      

      v(3mm)
    },
  )
  pagebreak()
  pagebreak()
}
