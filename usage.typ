#import "./report.typ": *

#show: report.with(
  course: "《C++程序设计》实验报告",
  major: "材料科学与工程",
  classid: "材料科学与工程1班",
  stdid: "123456",
  name: "lbyxiaolizi",
  week: "第 2 周",
  date: "2026年3月9日"
)

#lab-table(
  exp-name: [实验 02：C++基础编程练习],
  objective: [
    1. 熟练掌握利用集成开发环境编写 C++程序的基本流程；
    2. 巩固 C++语言基本语法和书写规范性；
    3. 加深对头文件和命令空间作用的理解
  ],
  environment: [
    操作系统：Windows 11 \
    开发工具：VS Code \
    编译器：g++ (Rev11, Built by MSYS2 project) 15.2.0
  ],
  content: [
    *题目1：程序改错-1* \
    `lab02_01.cpp` 文件中 C++ 程序存在多处语法和书写错误，请找出并改正，使其能够正确编译运行，并输出两数之和。

    *解题思路*：改正错误语法即可

    *原始代码存在错误*：
    - 多处代码不以 `;` 结尾
    - `main` 函数的声明应为 `int` 而非 `Int` ，大小写错误
    - 对 `a b` 的声明应当使用 `,` 分隔，而非空格

    *修改后代码*：
    ```cpp
    #include <iostream>
    using namespace std;
    
    int main() {
        int a, b;
        cout << "Please input two integer numbers:" << endl;
        cin >> a >> b;
        cout << "a+b=" << a+b << endl;
        return 0;
    }
    ```
  ],
  problems: [无],
  summary: [
    *1. 总结本次实验* \
    本次实验对CPP的基本语法进行了加深，对头文件以及关键字有相关认识，以及对命名空间相关的使用进行学习。

    *2. 心得体会* \
    对CPP语言中的std库有了更深的认识，在编程中要更加注意namespace可能带来的问题，尽量少的使用全局引入。
  ]
)