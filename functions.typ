#import emoji: chain
#let main_color = olive
#let accent_color = green

#let SeparationBar(thickness:4pt) = {
  rect(height: thickness, width: 100%, radius: thickness, fill: gradient.linear(main_color,accent_color,white))
}

#let RSeparationBar(thickness:4pt) = {
  rect(height: thickness, width: 100%, radius: thickness, fill: gradient.linear(white,accent_color,main_color))
}

#let Contacts(contacts) = {
  let contactlist = ()
  for x in contacts {
    x.type = align(right, [#x.type:#h(10pt)])
    x.value = x.value
    contactlist.push([#x.type<infotext>])
    contactlist.push([#x.value<infotext>])
  }
    // Links
    grid(columns: (auto, 1fr), rows: 12pt,
      ..contactlist
    )
}

#let Header(info) = {
  grid(rows: (16pt),columns: (auto, 2fr), [= #info.name], pad(x: 10pt)[#info.title <infotext>])
  SeparationBar()
  Contacts(info.contacts)
  SeparationBar()
}


#let Footer(info) = {
  SeparationBar()
  [#info.email <infotext>]
}

#let LinkLinkToURL(section) = {
  let linking = if section.keys().contains("linking") {section.linking} else {"link"}

  for i in range(section.values.len()) {
    if section.values.at(i).keys().contains(linking) {
      if section.values.at(i).keys().contains("url") and section.values.at(i).url != "" { 
        section.values.at(i).at(linking)=[#chain#link(section.values.at(i).url)[#section.values.at(i).at(linking)]]
      } else if section.values.at(i).at(linking) != "" {
        section.values.at(i).at(linking)=[#section.values.at(i).at(linking)]
      }
    }
  }

  section
}

#let Default(v) = {
  v = LinkLinkToURL(v)

  [== #v.name <sectionTitle>]
  for exp in v.values {
    grid(columns: (1fr),rows: (12pt,auto,6pt),
      ..(
        [*#exp.name* #if exp.keys().contains("period") {place(top+right,[#exp.period])}],
        box(width:80%,par(justify:false,linebreaks:"optimized", {
          if exp.keys().contains("link") [#exp.link#linebreak()]
          if exp.keys().contains("description") [#exp.description <infotext>]
        })),
        [] // Used as padding between paragraphs
      )    
    )
  }
}

#let RenderTable(v) = {
[== #v.name <sectionTitle>]
  let titleRow = ()

  let values = ()

  for category in v.values {
    if category.name != "" {titleRow.push[*#category.name:*]}
    if category.values != (none,) {values.push(category.values)}
  }

  // Get max size of array
  let max = calc.max(..(values.map(x=>x.len())))

  // If number of columns does not match the number of values
  while values.len() < v.values.len() {
    titleRow.push([])
    values.push(())
  }

  let contentRow = for i in range(max) {
    for array in values {
      if array.len() > i {
        list(indent: 12pt, array.at(i))
      } else {
        [ ]
      }
    }
  }.children

  let columns = (2fr,) * (v.values.len() - 1)
  columns.push(1fr)

  grid(columns: columns,rows: (12pt),
      ..(..titleRow,
      ..contentRow)
    ) 
}

#let RenderSection(section) = {
  if section.type == "list" {
    Default(section)
  } else {
    RenderTable(section)
  }
}

#let RenderSections(sections) = {

  let last = false
  for section in sections {
    last = if section == sections.last() {true} else {false}
    RenderSection(section)

    if not last {RSeparationBar()}
  }
}