#import "./shared.typ": *

#let report(
  course: "《C++程序设计》实验报告",
  major: "材料科学与工程",
  classid: "材料科学与工程1班",
  stdid: "123456",
  name: "lbyxiaolizi",
  week: "第 2 周",
  date: "2026年3月9日",
  body,
) = {
  set document(title: course)
  show: shared

// ==================== 跨平台字体配置  ====================
  // 删除了中文别名和特定系统特有的不常用字体，只保留标准英文名

  // 1. 黑体 (用于大标题)
  let font-hei = (
    "Times New Roman",
    "SimHei",                  // Windows
    "PingFang SC", "Heiti SC", // macOS
    "Noto Sans CJK SC",        // Linux
    "sans"                     // 兜底
  )

  // 2. 仿宋 (用于副标题)
  let font-fangsong = (
    "Times New Roman",
    "FangSong",                // Windows
    "STFangsong",              // macOS
    "Noto Serif CJK SC",       // Linux
    "serif"                    // 兜底
  )

  // 3. 宋体 (用于正文)
  let font-song = (
    "Times New Roman", 
    "SimSun",                  // Windows
    "Songti SC", "STSong",     // macOS
    "Noto Serif CJK SC",       // Linux
    "serif"                    // 兜底
  )

  // ==================== 封面页 ====================
  // 1. 左上角校徽
  align(left)[
    #image("./images/sysu.png", width: 40%)
  ]

  // 2. 主标题区
  align(center)[
    #v(30pt)
    // 黑体 48pt (磅) 加粗
    #text(size: 48pt, weight: "bold", font: font-hei, spacing: 0.2em)[中 山 大 学]\
    #v(30pt)
    // 黑体 30pt (磅) 加粗
    #text(size: 30pt, weight: "bold", font: font-hei, spacing: 0.5em)[材 料 学 院]\
    #v(40pt)
    // 仿宋 一号(26pt) 加粗
    #text(size: 26pt, weight: "bold", font: font-fangsong)[#course]\
    #v(60pt)

    // 3. 个人信息填空区
    #let info-row(key, value) = {
      grid(
        columns: (80pt, 240pt),
        align: (left + horizon, center + bottom),
        text(size: 16pt, font: font-song)[#key], 
        box(width: 100%, stroke: (bottom: 0.5pt), outset: (bottom: 5pt))[
          #text(size: 15pt, font: font-song)[#value] 
        ]
      )
      v(1.6em) 
    }

    #box[
      #info-row([专#h(2em)业], major)
      #info-row([班#h(2em)级], classid)
      #info-row([学#h(2em)号], stdid)
      #info-row([学生姓名], name)
      #info-row([实验周次], week)
      #info-row([完成日期], date)
      #info-row([成#h(2em)绩], [])
    ]
  ]

  pagebreak()

  // ==================== 正文页设置 ====================
  set align(left + top)
  set text(size: 12pt, font: font-song)
  set par(justify: true, first-line-indent: 0em, leading: line_height)

  body
}

// 主体内容的表格布局
#let lab-table(
  exp-name: "",
  objective: [],
  environment: [],
  content: [],
  problems: [],
  summary: [],
) = {
  // 确保表格里的字体也能跨平台，且不报警告
  let font-song = (
    "Times New Roman", 
    "SimSun", 
    "Songti SC", "STSong", 
    "Noto Serif CJK SC", 
    "serif"
  )
  
  // 辅助函数：将标题和内容拼接放在同一个单元格内
  // 标题使用 四号(14pt)，正文使用 小四(12pt)
  let section(title, body) = [
    #text(size: 14pt, font: font-song)[#title]
    #v(0.8em, weak: true) // 标题和内容之间的间距
    #set text(size: 12pt, font: font-song)
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
  )[ #section(title, body) ]

  [
    #section-block([实验序号及名称], exp-name, first: true)
    #section-block([一、 实验目的], objective)
    #section-block([二、 实验环境], environment)
    #section-block([三、 实验内容与步骤], content)
    #section-block([四、 遇到的问题及解决方法], problems)
    #section-block([五、 总结与思考], summary)
  ]
}
}