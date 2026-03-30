# 中山大学 材料学院 程序设计课程 实验报告模板

本模板基于YSOS 2项目中附带实验报告模板修改

原项目：<https://github.com/YatSenOS/YatSenOS-Tutorial-Volume-2/tree/main/template>

格式参照25级曾剑敏老师 程序设计II实验 课程附件中实验报告参考模板修改。

> 应老师要求，已经将表格修改为单列。（虽然我觉得双列更美观+信息效率更高

限于时间，*跨平台字体*没有真实测试适配效果，不确定是否有效！

如果遇到问题，烦请自行修改适配，字体格式如下：

| **内容**                | **字体**                         | **字号** | **格式** |
| ----------------------- | -------------------------------- | -------- | -------- |
| 中 山 大 学 标题        | 黑体                             | 48       | 加粗     |
| 材 料 学 院             | 黑体                             | 30       | 加粗     |
| 《C++程序设计》实验报告 | 仿宋_GB2312                      | 一号     | 加粗     |
| 专业 班级等             | 宋体                             | 三号     | 常规     |
| 材料科学与工程等内容    | 宋体                             | 小三     | 常规     |
| 实验序号及名称等小标题  | 宋体                             | 四号     | 常规     |
| 实验报告内容            | 中文：宋体 英文：Times New Roman | 小四     | 常规     |

## 使用方式

MacOS / Linux:

```bash
./install-local-package.sh
```

Windows:

```bat
install-local-package.bat
```

上述脚本会尝试把当前仓库软链接到 Local packages 目录下，安装完成后在任何项目里都可以直接import：

```typ
#import "@local/sysu-mse-cpp-template:0.1.0": report, lab-table
```

也可以自定义 `namespace`/`name`/`version`/`data-dir`，参数顺序为：

```text
<namespace> <name> <version> <data-dir>
```

例如：

```bash
./install-local-package.sh local sysu-mse-cpp-template 0.1.0 "$HOME/Library/Application Support"
```

> 注意：使用脚本指定`version`和`name`并不会更新`typst.toml`里的版本号和包名。为避免不可预期的后果，请保持与`typst.toml`里面的值一致

### 字体说明

根据 Typst 包资源说明，包本身不应该规定用户项目实际使用的字体，也不应在包里携带字体文件。

因此这个模板：

- 包内部不再硬编码正文字体和代码字体
- 使用者必须在“自己的项目根目录”里手动提供一个 `fonts.typ`
- 模板通过 `report(fonts: ...)` 显式接收字体配置
- Windows 用户可以直接复制本仓库根目录下 [fonts.typ](./fonts.typ) 的内容作为起点
- 其他系统请先运行 `typst fonts` 查看可用字体，再自行修改 `fonts.typ`

这里的 [fonts.typ](./fonts.typ) 只是“给用户复制到自己项目里”的推荐示例，不属于包的自动配置，也不应该被当作包 API 依赖。

### Demo

参见[usage.typ](./usage.typ)
