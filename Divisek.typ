#import "@preview/cmarker:0.1.10"


// // #set heading(numbering: "1.")
#set heading(numbering: (..nums) => {
  let list = nums.pos()
  if list.len() >= 3 {
    none // Пропускаємо рівень `=`
  } else {
    let sub = list.slice(0).map(str).join(".")
    if list.len() == 1 {
      sub + "." // Для `==` додаємо крапку на кінці (наприклад, "1.")
    } else {
      sub // Для `===` та глибших виводимо без додаткової крапки (наприклад, "1.1")
    }
  }
})

// #set heading(numbering: "1.")


#show link: set text(fill: blue, weight: 700)
#show link: underline

#let centered(attrs, body) = html.elem(
  "center",
  body,
)
// Renders the provided Markdown string using the cmarker package with custom settings
#let render_markdown(markdown) = cmarker.render(
  markdown,
  scope: (
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

// Reads file content from a given path and passes it to render_markdown
#let render_markdown_from_file(path) = render_markdown(read(path))

// Reads a file, removes metadata (frontmatter), and strips Markdown links into plain text before rendering
#let render_clean_markdown_from_file(path) = {
  let markdown = read(path)

  // 1. Replaces wiki-style links [[Page|Display Text]] with plain text
  markdown = markdown.replace(
    regex("\\[\\[[^\\]|]+\\|([^\\]]+)\\]\\]"),
    m => m.captures.at(0),
  )

  // 2. Removes YAML frontmatter blocks delimited by triple dashes (--- ... ---)
  markdown = markdown.replace(
    regex("\\-\\-\\-[\s\S]+\\-\\-\\-"),
    m => "",
  )

  // 3. Replaces relative Markdown links [Text](<../path>) with plain text
  markdown = markdown.replace(
    regex("\\[([^\\]|]+)\\]\\(<../([^\\]]+)>\\)"),
    m => m.captures.at(0),
  )

  // 4. Search for image links with relative paths pointing one directory up (<../...>)
  // and rewrite them to be relative to the specified root Typst file (./Obsidian_Divisek/...)
  markdown = markdown.replace(
    regex("!\\[(.*?)\\]\\(<(\.\.\/)+([^\]]+)>\\)"),

    m => "![" + m.captures.at(0) + "](<./Obsidian_Divisek/" + m.captures.at(2) + ">)",
  )

  render_markdown(markdown)
}

#let notes = (
  "Obsidian_Divisek/Sources/Книга. Весь Юго-Западный край. справочная и адресная книга по Киевской, Подольской и Волынской губерниях. (1913).md",
  "Obsidian_Divisek/Sources/Книга. Фабрики и заводы всей России. Сведения о 31 523 фабриках и заводах. (1913).md",
  "Obsidian_Divisek/Sources/Книга. Дворский Я.Ф.Нетч Ф.Г.Альманах русских пивоваров.том 2. (1908).md",

  "Obsidian_Divisek/Sources/Книга. Орлов П.А., Будагов С.Г. Указатель фабрик и заводов Европейской России. (1894).md",
  "Obsidian_Divisek/Sources/Газета Чехослован 4.17 листопад. 1911.md",
  "Obsidian_Divisek/Sources/Ziarno. pismo ilustrowane poświęcone sprawom społecznym, politycznym, ekonomicznym i literackim 1914, nr 9 (28 lutego).md",

  "Obsidian_Divisek/Sources/Browary w Rzeczypospolitej Polskiej czynne w r. 1930.md",
  "Obsidian_Divisek/Sources/DER BÖHMISCHE BIERBRAUER. Organ für die Interessen des gesamten Brauwesens.Neue Folge. Jahrgang XXX. — Prag, 15. November 1903. — Nr. 22..md",
  "Obsidian_Divisek/Sources/DER BÖHMISCHE BIERBRAUER. Organ für die Interessen des gesamten Brauwesens.Neue Folge. Jahrgang XXXII. — Prag, 1. Juli 1905. — Nr. 13..md",
  "Obsidian_Divisek/Sources/Kongres piwowarów polskich w Łodzi. Ilustrowane wydanie poświęcone sprawom przemysłu piwowarskiego (chemiczno-rolniczego) piwowarom i odbiorcom piwa w Polsce. 9-11 września. (1933).md",
  "Obsidian_Divisek/Sources/Obwieszczenia Publiczne. dodatek do Dziennika Urzędowego Ministerstwa Sprawiedliwości. R.7, № 15 (21 lutego 1923).md",
  "Obsidian_Divisek/Sources/Polski przemysł i handel. Rynek polski. Księga adresowa i informacyjna przedsiębiorstw przemysłowych, handlowych i finansowych w Rzeczypospolitej Polskiej. (1930).md",

  "Obsidian_Divisek/Sources/Варзар В.Е. Список фабрик и заводов Российской империи (1912).md",
  "Obsidian_Divisek/Sources/Газета. Ведомости Одесского Градоначальства. 1915 №141.md",
  "Obsidian_Divisek/Sources/Газета. Ведомости Одесского Градоначальства. 1915 №168.md",
  "Obsidian_Divisek/Sources/Кандуров Д.П. Фабрично-заводские предприятия Российской империи (исключая Финляндию). (1914 рік).md",
  "Obsidian_Divisek/Sources/Книга записів про народження, шлюб, смерть костелу м. Березно, 1912-1913рр..md",
  "Obsidian_Divisek/Sources/Книга. Адрес-календарь Подольской губернии. (1904).md",
  "Obsidian_Divisek/Sources/Книга. Адрес-календарь Подольской губернии. (1909).md",

  "Obsidian_Divisek/Sources/Книга. Вся Россия. Русская книга промышленности, торговли, сельского хозяйства и администрации. Торгово-промышленный адрес-календарь Российской империи. (1902).md",
  "Obsidian_Divisek/Sources/Книга. Вся Россия. Русская книга промышленности, торговли, сельского хозяйства и администрации. торгово-промышленный адрес-календарь Российской империи. (1913).md",
  "Obsidian_Divisek/Sources/Книга. Вся Россия. Русская книга промышленности, торговли, сельского хозяйства и администрации. торгово-промышленный адрес-календарь Российской империи. Том 2. (1895).md",
  "Obsidian_Divisek/Sources/Книга. Дворский Я.Ф.Нетч Ф.Г.Альманах русских пивоваров.том 1. 1894.md",

  "Obsidian_Divisek/Sources/Книга. Езиоранский Л.К. Фабрично-заводские предприятия Российской империи. (1909).md",

  "Obsidian_Divisek/Sources/Книга. Подольский Адрес-календарь. (1900).md",
  "Obsidian_Divisek/Sources/Книга. Список фабрик и заводов России. (1910).md",

  "Obsidian_Divisek/Sources/Книга. Фабрично-заводская промышленность России. Перечень фабрик и заводов. (1897).md",
  "Obsidian_Divisek/Sources/Список фабрик и заводов Европейской России.  В. Киршбаума. (1903).md",
)



#let kbd(it) = context {
  if target() == "html" {
    html.elem("kbd", it)

    render_clean_markdown_from_file("Obsidian_Divisek/Another sources/Карта Березного та околиць (1915).md")

    for note in notes {
      render_markdown_from_file("Obsidian_Divisek/Розділення.md")
      render_clean_markdown_from_file(note)
    }
  } else {
    show quote: it => it.body

    // 1. Page Configuration (US Standard Book 6" x 9")
    set page(
      paper: "a4",
      margin: (
        top: 2.5cm,
        bottom: 2.5cm,
        inside: 1.5cm, // Більший відступ всередині для зшивання (gutter)
        outside: 1.5cm, // Менший відступ ззовні
      ),
      binding: left,
    )

    // 2. Typography & Text Formatting
    set text(
      // font: "Linux Libertine", // Або інший якісний шрифт із засічками (Serif)
      size: 11pt, // Стандартний кегль для А4
      lang: "uk", // Мова документа (для правильних переносів)
      tracking: 0pt,
    )

    // Paragraph formatting for a classic book look
    set par(
      justify: true, // Fully justified text
      leading: 0.75em, // Line spacing
      first-line-indent: 1.5em, // Indent the first line of paragraphs
    )

    // // 3. Headings Style
    // // show heading: set text(font: "Linux Libertine", weight: "bold")
    // show heading.where(level: 1): it => block(width: 100%, below: 2em)[
    //   #set align(center)
    //   #set text(size: 18pt)
    //   #it.body
    // ]
    // show heading.where(level: 2): it => block(below: 1em)[
    //   #set text(size: 14pt)
    //   #it.body
    // ]
    show heading.where(level: 3): it => block(below: 1em, above: 2em)[
      #set align(center)
      // #set text(size: 18pt)
      #it.body
    ]

    show heading.where(level: 1): it => {
      pagebreak(weak: true) // Кожен великий розділ починається з нової сторінки
      // v(2cm)
      it
      // v(1cm)
    }

    // show image: img => {
    //   // Обмежуємо зображення по ширині (наприклад, максимум 100% від контейнера)
    //   // та висоті (наприклад, не вище 300pt)
    //   box(width: 100%, height: 70%, clip: false)[
    //     #set image(width: auto, height: auto)
    //     #img
    //   ]
    // }
    //
    //

    show image: img => context {
      // Вимірюємо природний розмір картинки
      let size = measure(img)

      // Тут можна задати максимальну ширину (наприклад, 100% або 400pt)
      // let max-w = 100% * page.width
      let max-h = 65% * page.height
      // let max-h = 40% * page.height

      // if size.width > max-w {
      // image(img.source, width: max-w, height: size.height)
      // }

      if size.height > max-h {
        image(img.source, height: max-h - 2.5cm - 2.5cm, fit: "contain")
      } else {
        img
      }
    }

    render_clean_markdown_from_file("Obsidian_Divisek/Another sources/Карта Березного та околиць (1915).md")
    pagebreak()

    for note in notes {
      render_clean_markdown_from_file(note)
      pagebreak()
    }

    // Виклик змісту
    outline(
      title: [Зміст],
      indent: 1.5em,
      depth: 2,
    )
  }
}

#kbd("")



