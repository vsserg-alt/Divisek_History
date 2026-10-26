#import "@preview/cmarker:0.1.10"


// #set heading(numbering: "1.")
#set heading(numbering: (..nums) => {
  let list = nums.pos()
  if list.len() == 1 {
    none // Пропускаємо рівень `=`
  } else {
    let sub = list.slice(1).map(str).join(".")
    if list.len() == 2 {
      sub + "." // Для `==` додаємо крапку на кінці (наприклад, "1.")
    } else {
      sub // Для `===` та глибших виводимо без додаткової крапки (наприклад, "1.1")
    }
  }
})

#show link: set text(fill: blue, weight: 700)
#show link: underline


#let centered(attrs, body) = html.elem(
  "center",
  body,
)

#let print(markdown) = cmarker.render(
  markdown,
  scope: (
    // centered: body => centered(body),
    image: (source, alt: none, ..args) => {
      figure(image(source, alt: alt, ..args), caption: alt)
    },
  ),
  smart-punctuation: true,
  math: none,
  task-list-marker: none,
  h1-level: 1,
  set-document-title: true,
  raw-typst: true,
  html: (
    center: (attrs, body) => centered(attrs, body),
    h2: (attrs, body) => html.elem(
      "h2",
      body,
    ),
    img: (
      "void",
      attrs => html.elem(
        "img",
        attrs: attrs,
      ),
    ),
    div: (attrs, body) => html.elem(
      "div",
      body,
      attrs: attrs,
    ),
    b: (attrs, body) => html.elem(
      "b",
      body,
      attrs: attrs,
    ),
  ),
  label-prefix: "",
  prefix-label-uses: true,
  heading-labels: none,
  show-source: false,
  blockquote: none,
)


#let print_by_path(path) = print(read(path))

#let print_by_path_and_remove_links(path) = {
  let markdown = read(path)

  markdown = markdown.replace(
    regex("\\[\\[[^\\]|]+\\|([^\\]]+)\\]\\]"),
    m => m.captures.at(0),
  )

  markdown = markdown.replace(
    regex("\\-\\-\\-[\s\S]+\\-\\-\\-"),
    m => "",
  )

  print(markdown)
}


#print_by_path_and_remove_links("Obsidian_Divisek/Sources/Газета. Ведомости Одесского Градоначальства. 1915 №141.md")

#print_by_path("Obsidian_Divisek/Розділення.md")

#print_by_path_and_remove_links("Obsidian_Divisek/Sources/Газета. Ведомости Одесского Градоначальства. 1915 №168.md")

#print_by_path("Obsidian_Divisek/Розділення.md")

#print_by_path_and_remove_links(
  "Obsidian_Divisek/Sources/Кандуров Д.П. Фабрично-заводские предприятия Российской империи (исключая Финляндию). (1914 рік).md",
)

#print_by_path("Obsidian_Divisek/Розділення.md")

#print_by_path_and_remove_links(
  "Obsidian_Divisek/Sources/Книга. Адрес-календарь Подольской губернии. (1909).md",
)

#print_by_path("Obsidian_Divisek/Розділення.md")

#print_by_path_and_remove_links(
  "Obsidian_Divisek/Sources/Книга. Весь Юго-Западный край. справочная и адресная книга по Киевской, Подольской и Волынской губерниях. (1913).md",
)

#print_by_path("Obsidian_Divisek/Розділення.md")

#print_by_path_and_remove_links(
  "Obsidian_Divisek/Sources/Книга. Вся Россия. Русская книга промышленности, торговли, сельского хозяйства и администрации. торгово-промышленный адрес-календарь Российской империи. (1913).md",
)

#print_by_path("Obsidian_Divisek/Розділення.md")

#print_by_path_and_remove_links(
  "Obsidian_Divisek/Sources/Книга. Дворский Я.Ф.Нетч Ф.Г.Альманах русских пивоваров.том 2. (1908).md",
)

#print_by_path("Obsidian_Divisek/Розділення.md")

#print_by_path_and_remove_links(
  "Obsidian_Divisek/Sources/Книга. Езиоранский Л.К. Фабрично-заводские предприятия Российской империи. (1909).md",
)

#print_by_path("Obsidian_Divisek/Розділення.md")

#print_by_path_and_remove_links(
  "Obsidian_Divisek/Sources/Книга. Список фабрик и заводов России. (1910).md",
)



