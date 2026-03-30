# 中山大学 材料学院 程序设计课程 实验报告模板

本模板基于YSOS 2项目中附带实验报告模板修改

原项目：<https://github.com/YatSenOS/YatSenOS-Tutorial-Volume-2/tree/main/template>

格式参照25级曾剑敏老师 程序设计II实验 课程附件中实验报告参考模板修改。

> 应老师要求，已经将表格修改为单列。（虽然我觉得双列更美观+信息效率更高

## 使用方式

MacOS / Linux:

```bash
./install-local-package.sh
```

Windows:

```bat
install-local-package.bat
```

上述脚本会尝试把当前仓库软链接到 Typst local packages 目录下，安装完成后在本机任何项目里都可以直接import：

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

根据 Typst Universe 的规则，包本身不应该规定用户项目实际使用的字体，也不应在包里携带字体文件。

因此本模板：

- 不会硬编码正文字体和代码字体
- 使用者可以参照[fonts.typ](./fonts.typ)提供一个字体对象，Windows用户可以选择直接复制该文件
- 其他系统请先运行 `typst fonts` 查看可用字体，再自行修改 `fonts.typ`

### Demo

参见[usage.typ](./usage.typ)
