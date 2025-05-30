> :warning: Jupyter Binder 项目的某些功能已经过时。虽然教程内容仍然有效，大部分练习也仍可运行，但您可能会遇到一些错误。

[![活页夹](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/jiafjioajfijaiofnkan/chisel-bootcamp/translation-to-chinese)

**_对于训练营的老用户，我们已将 Scala 从 2.11 版本升级到 Scala 2.12 版本。如果您遇到错误，请按照安装说明升级到 2.12 版本。_**

# Chisel 训练营

将您的硬件设计水平从实例提升到生成器！
本训练营将教授您 Chisel，一个用 Scala 编写的伯克利硬件构建 DSL。
它会同时教授您 Scala，并围绕*硬件生成器*的概念构建 Chisel 的学习框架。

## 您将学到什么

- 为什么硬件设计更适合表达为生成器，而不是实例
- Scala（一种现代编程语言）的基础知识和一些高级功能
- Chisel（一种嵌入在 Scala 中的硬件描述语言）的基础知识和一些高级功能
- 如何为 Chisel 设计编写单元测试
- Chisel 库中一些有用功能的基本介绍，包括 [dsptools](https://github.com/ucb-bar/dsptools/) 和 [rocketchip](https://github.com/freechipsproject/rocket-chip)。

## 先决条件

- 熟悉 Verilog、VHDL，或至少具备一些数字硬件设计知识
- 具有使用“高级”语言（如 Python、Java、C++ 等）的编程经验
- 强烈的学习愿望

## 入门指南

[在此处](https://mybinder.org/v2/gh/jiafjioajfijaiofnkan/chisel-bootcamp/translation-to-chinese)尝试一下！无需本地安装！

如果您想在本地尝试，[请在此处查看安装说明](Install.md)。

## 大纲

本训练营分为多个模块，模块又进一步细分。
本 README 文件作为*模块 0*，介绍并激发学习本训练营内容的动力。
*模块 1* 快速介绍 Scala。
它会教授您足够的 Scala 知识以开始编写 Chisel，但在此过程中还会教授更多 Scala 概念。
Chisel 在*模块 2* 中引入，从一个硬件示例开始并对其进行分解。
*模块 2* 的其余部分涵盖组合逻辑和时序逻辑，以及软件和硬件控制流。
*模块 3* 教您如何使用 Chisel 编写硬件生成器，并利用 Scala 的高级编程语言特性。
学完本训练营后，您将能够阅读和理解大部分 [Chisel 代码库](https://github.com/freechipsproject/chisel3) 并开始使用 [Rocket Chip](https://github.com/freechipsproject/rocket-chip)。
本教程目前*不*涵盖 SBT、构建系统、FPGA 或 ASIC 流程的后端，或模拟电路。

## 动机
所有硬件描述语言都支持编写单个实例。
然而，编写实例非常繁琐。
为什么要在编写别人可能已经设计过的东西的略微修改版本时犯同样的错误呢？
Verilog 支持有限的参数化，例如位宽和 generate 语句，但这只能带您走这么远。
如果我们不能编写 Verilog 生成器，就需要编写一个新的实例，从而使代码量翻倍。
作为一种更好的选择，我们应该编写一个程序来生成两个硬件实例，这将减少我们的代码量并使繁琐的事情变得更容易。
这些程序称为生成器。

理想情况下，我们希望我们的生成器是（1）可组合的，（2）强大的，并且（3）能够对生成的设计进行细粒度控制。
错误检查对于确保组合合法是必要的；没有它，调试将非常困难。
这要求生成器语言理解设计的语义（以了解什么是合法的，什么是不合法的）。
此外，生成器不应过于冗长！
我们希望生成器程序能够简洁地表达许多不同的设计，而无需为每个实例在 if 语句中重写它。
最后，它应该是一种零成本抽象。
硬件设计性能对微小的变化非常敏感，因此，您需要能够精确地指定微体系结构。
生成器与高级综合（HLS）有很大不同。

Chisel 的优势在于您如何使用它，而不在于语言本身。
如果您决定编写实例而不是生成器，那么与 Verilog 相比，您将看到 Chisel 的优势较少。
但是，如果您花时间学习如何编写生成器，那么 Chisel 的强大功能将变得显而易见，您会发现自己再也回不去编写 Verilog 了。
学习编写生成器是困难的，但我们希望本教程能为您铺平道路，使您成为一名更好的硬件设计师、程序员和思考者！

## 常见问题解答

### 内核启动时崩溃

启动 Scala 笔记本时出现以下错误，Jupyter 显示内核已崩溃：

```
Exception in thread "main" java.lang.RuntimeException: java.lang.NullPointerException
	at jupyter.kernel.server.ServerApp$.apply(ServerApp.scala:174)
	at jupyter.scala.JupyterScalaApp.delayedEndpoint$jupyter$scala$JupyterScalaApp$1(JupyterScala.scala:93)
	at jupyter.scala.JupyterScalaApp$delayedInit$body.apply(JupyterScala.scala:13)
  ...

Caused by: java.lang.NullPointerException
	at ammonite.runtime.Classpath$.classpath(Classpath.scala:31)
	at ammonite.interp.Interpreter.init(Interpreter.scala:93)
	at ammonite.interp.Interpreter.processModule(Interpreter.scala:409)
	at ammonite.interp.Interpreter$$anonfun$10.apply(Interpreter.scala:151)
	at ammonite.interp.Interpreter$$anonfun$10.apply(Interpreter.scala:148)
  ...
```

确保您选择了 **Java 8** 来运行 Jupyter（请参阅上面的说明）。

## 贡献者
- Stevo Bailey ([stevo@berkeley.edu](mailto:stevo@berkeley.edu))
- Adam Izraelevitz ([adamiz@berkeley.edu](mailto:azidar@berkeley.edu))
- Richard Lin ([richard.lin@berkeley.edu](mailto:edwardw@berkeley.edu))
- Chick Markley ([chick@berkeley.edu](mailto:chick@berkeley.edu))
- Paul Rigge ([rigge@berkeley.edu](mailto:rigge@berkeley.edu))
- Edward Wang ([edwardw@berkeley.edu](mailto:edwardw@berkeley.edu))
