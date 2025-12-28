#let info = yaml("conf.ex.yaml");
#import "functions.typ": Header, RenderSection, SeparationBar, RSeparationBar, Footer, RenderSections, main_color

#set text(font: "DejaVu Sans", size: 10pt)
#set block(spacing: 0.6em)
#set par(leading: 0.5em)

#show <infotext>: set text(size: 8pt)
#show <infotext>: set align(horizon)

#show <sectionTitle>: set text(fill: main_color, size: 14pt)
#show <sectionTitle>: set block(above: 10pt, below: 6pt)

#{ // Example
  Header(info.header)
  RenderSections(info.keys().slice(1).map(x=>info.at(x)))
  place(bottom,Footer(info.header))
}


// #{ // Page 1
//   Header(info.header)
//   RenderSection(info.formation)
//   RSeparationBar()
//   RenderSection(info.skills)
//   RSeparationBar()
//   RenderSection(info.experience)
//   RSeparationBar()
//   RenderSection(info.langague)
//   place(bottom,Footer(info.header))
//   pagebreak()
// }

// #{ // Page 2
//   SeparationBar()
//   RenderSection(info.implications)
//   RSeparationBar()
//   RenderSection(info.competitions)
//   RSeparationBar()
//   RenderSection(info.fun)
//   place(bottom,Footer(info.header))
// }