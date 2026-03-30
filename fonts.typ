// Copy this file to the root of your own Typst project and customize it there.
// This is a Windows-oriented recommendation and is not imported by the package.

#let report-fonts = (
  serif: (
    "Source Han Serif SC",
    "Source Han Serif",
    "宋体",
    "Times New Roman",
    "Georgia",
    "Garamond",
    "Palatino",
    "Baskerville",
  ),
  monospace: (
    "JetBrains Mono",
    "Courier New",
    "Courier",
    "Consolas",
    "Monaco",
  ),
  sans: (
    "Source Han Sans SC",
    "Source Han Sans",
    "黑体",
    "SimHei",
    "Microsoft YaHei",
    "PingFang SC",
  ),
  cover-hei: (
    "Times New Roman",
    "SimHei", // Windows
    "PingFang SC",
    "Heiti SC", // macOS
    "Noto Sans CJK SC", // Linux
    "sans", // 兜底
  ),
  cover-fangsong: (
    "Times New Roman",
    "FangSong", // Windows
    "STFangsong", // macOS
    "Noto Serif CJK SC", // Linux
    "serif", // 兜底
  ),
  cover-song: (
    "Times New Roman",
    "SimSun", // Windows
    "Songti SC",
    "STSong", // macOS
    "Noto Serif CJK SC", // Linux
    "serif", // 兜底
  ),
)
