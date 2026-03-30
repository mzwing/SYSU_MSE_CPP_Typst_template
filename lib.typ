#import "./shared.typ": shared

#let cover-text(body, size, weight: "regular", spacing: 0em, font: none) = {
  if font == none {
    text(size: size, weight: weight, spacing: spacing)[#body]
  } else {
    text(size: size, weight: weight, spacing: spacing, font: font)[#body]
  }
}

#let info-row(key, value, font: none) = {
  let key-content = if font == none {
    text(size: 16pt)[#key]
  } else {
    text(size: 16pt, font: font)[#key]
  }

  let value-content = if font == none {
    text(size: 15pt)[#value]
  } else {
    text(size: 15pt, font: font)[#value]
  }

  grid(
    columns: (80pt, 240pt),
    align: (left + horizon, center + bottom),
    key-content,
    box(width: 100%, stroke: (bottom: 0.5pt), outset: (bottom: 5pt))[
      #value-content
    ],
  )
  v(1.6em)
}

#let report(
  course: "《C++程序设计》实验报告",
  major: "材料科学与工程",
  classid: "材料科学与工程1班",
  stdid: "123456",
  name: "lbyxiaolizi",
  week: "第 2 周",
  date: "2026年3月9日",
  fonts: none,
  logo: image("./images/sysu.png", width: 40%),
  body,
) = {
  set document(title: course)
  show: shared.with(fonts: fonts)

  let font-hei = if fonts == none { none } else { fonts.cover-hei }
  let font-fangsong = if fonts == none { none } else { fonts.cover-fangsong }
  let font-song = if fonts == none { none } else { fonts.cover-song }
  let body-font = if fonts == none { none } else { fonts.serif }

  align(left)[
    #logo
  ]

  align(center)[
    #v(30pt)
    #cover-text([中 山 大 学], 48pt, weight: "bold", spacing: 0.2em, font: font-hei)\
    #v(30pt)
    #cover-text([材 料 学 院], 30pt, weight: "bold", spacing: 0.5em, font: font-hei)\
    #v(40pt)
    #cover-text(course, 26pt, weight: "bold", font: font-fangsong)\
    #v(60pt)

    #box[
      #info-row([专#h(2em)业], major, font: font-song)
      #info-row([班#h(2em)级], classid, font: font-song)
      #info-row([学#h(2em)号], stdid, font: font-song)
      #info-row([学生姓名], name, font: font-song)
      #info-row([实验周次], week, font: font-song)
      #info-row([完成日期], date, font: font-song)
      #info-row([成#h(2em)绩], [], font: font-song)
    ]
  ]

  pagebreak()

  set align(left + top)
  if body-font == none {
    set text(size: 12pt)
  } else {
    set text(size: 12pt, font: body-font)
  }
  set par(justify: true, first-line-indent: 0em, leading: 1em)

  body
}

#let lab-table(
  exp-name: "",
  objective: [],
  environment: (
    os: [],
    devtools: [],
    compiler: [],
  ),
  content: (),
  problems: [],
  summary: (),
) = {
  let section(title, body) = [
    #text(size: 14pt)[#title]
    #v(0.8em, weak: true)
    #set text(size: 12pt)
    #body
  ]

  let section-block(title, body, first: false) = block(
    width: 100%,
    inset: 12pt,
    breakable: true,
    above: 0pt,
    below: 0pt,
    stroke: (
      left: 0.5pt,
      right: 0.5pt,
      bottom: 0.5pt,
      top: if first { 0.5pt } else { none },
    ),
  )[
    #section(title, body)
  ]

  let environment-block(env) = [
    操作系统：#env.os \
    开发工具：#env.devtools \
    编译器：#env.compiler
  ]

  let question-images(paths) = [
    #for path in paths [
      #image(path, width: 70%)
      #v(0.8em, weak: true)
    ]
  ]

  let content-block(items) = [
    #for (index, item) in items.enumerate() [
      *题目#(index + 1)：#item.question*

      #v(0.8em, weak: true)
      #item.question-detail

      #v(0.8em, weak: true)
      *解题思路*：#item.thinking

      #v(0.8em, weak: true)
      *代码*：
      #item.code

      #if item.image != () [
        #v(0.8em, weak: true)
        #question-images(item.image)
      ]

      #if item.extra != [] [
        #v(0.8em, weak: true)
        #item.extra
      ]

      #v(1em, weak: true)
    ]
  ]

  let summary-block(items) = [
    #for (index, item) in items.enumerate() [
      *#(index + 1). #item.title* \
      #item.content

      #v(1em, weak: true)
    ]
  ]

  [
    #section-block([实验序号及名称], exp-name, first: true)
    #section-block([一、 实验目的], objective)
    #section-block([二、 实验环境], environment-block(environment))
    #section-block([三、 实验内容与步骤], content-block(content))
    #section-block([四、 遇到的问题及解决方法], problems)
    #section-block([五、 总结与思考], summary-block(summary))
  ]
}
