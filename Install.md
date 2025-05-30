## 本地设置说明

如果您想在本地运行训练营，请根据您的具体情况执行以下说明。
请注意，我们为 Jupyter 提供了一个自定义 javascript 文件，因此如果您已经安装了 Jupyter，仍然需要安装 custom.js 文件。

注意：请确保您使用的是 **Java 8**（而非 Java 9）并已安装 JDK8。截至 2018 年 1 月，Coursier/jupyter-scala 似乎尚不兼容 Java 9。

如果您确实安装了多个 Java 版本，请确保在运行 `jupyter notebook` 之前选择 Java 8 (1.8)：

* Windows 系统：https://gist.github.com/rwunsch/d157d5fe09e9f7cdc858cec58c8462d6
* Mac OS 系统：https://stackoverflow.com/questions/21964709/how-to-set-or-change-the-default-java-jdk-version-on-os-x

### 使用 Docker 进行本地安装 - Linux/Mac/Windows

确保您的系统上已[安装](https://docs.docker.com/get-docker/) Docker。

运行以下命令：

```
docker run -it --rm -p 8888:8888 ucbbar/chisel-bootcamp
```

这将下载训练营的 Docker 镜像并运行它。输出将以下列消息结束：

```
    To access the notebook, open this file in a browser:
        file:///home/bootcamp/.local/share/jupyter/runtime/nbserver-6-open.html
    Or copy and paste one of these URLs:
        http://79b8df8411f2:8888/?token=LONG_RANDOM_TOKEN
     or http://127.0.0.1:8888/?token=LONG_RANDOM_TOKEN
```

将最后一个链接（以 https://127.0.0.1:8888 开头的链接）复制到您的浏览器中，然后学习训练营内容。

### 本地安装 - Mac/Linux

本训练营使用 Jupyter 笔记本。
Jupyter 笔记本允许您在浏览器中以交互方式运行代码。
它支持多种编程语言。
对于本训练营，我们将首先安装 Jupyter，然后安装 Scala 特定的 Jupyter 后端（现在称为 almond）。


#### Jupyter
首先安装 Jupyter。

依赖项：openssh-client、openjdk-8-jre、openjdk-8-jdk（两者都可以使用 -headless 版本）、ca-certificates-java

首先，使用 pip3 安装 Jupyter（或针对 python 2 使用 pip）：http://jupyter.org/install.html
```
pip3 install --upgrade pip
pip3 install jupyter --ignore-installed
```

如果 pip3 不能直接使用（可能是因为您的 Python3 版本已过时），您可以尝试使用 `python3 -m pip` 代替 `pip3`。

（如果以后因任何原因需要重新安装 Jupyter，您可以使用 `--no-deps` 来避免重新安装所有依赖项。）

您可能想尝试一下 Jupyter lab，这是 Project Jupyter 开发的更新的界面。
如果您希望能够在浏览器中运行终端模拟器，它尤其有用。
可以使用 `pip3` 安装：
```
pip3 install jupyterlab
```

#### Jupyter Scala 后端

如果您在本节遇到错误或问题，请先尝试运行 `rm -rf ~/.local/share/jupyter/kernels/scala/`。

接下来，下载 coursier 并使用它来安装 almond（这些说明的来源请参见[此处](https://almond.sh/docs/quick-start-install)）：
```
curl -L -o coursier https://git.io/coursier-cli && chmod +x coursier
SCALA_VERSION=2.12.10 ALMOND_VERSION=0.9.1
./coursier bootstrap -r jitpack \
    -i user -I user:sh.almond:scala-kernel-api_$SCALA_VERSION:$ALMOND_VERSION \
    sh.almond:scala-kernel_$SCALA_VERSION:$ALMOND_VERSION \
    --sources --default=true \
    -o almond
./almond --install
```

如果您愿意，可以删除 `coursier` 和 `almond` 文件。

#### 可视化

需要 [Graphviz](https://graphviz.org/download/) 来显示 Chisel 模块的可视化效果，例如在演示页面中。但是，可视化是可选的，因为其他 Chisel 和 Scala 功能在没有它的情况下也能正常工作。

#### 安装训练营
现在克隆训练营代码仓库并安装自定义脚本。
如果您已经有一个，请将此脚本附加到它。

```
git clone https://github.com/freechipsproject/chisel-bootcamp.git
cd chisel-bootcamp
mkdir -p ~/.jupyter/custom
cp source/custom.js ~/.jupyter/custom/custom.js
```

并在您的本地计算机上启动训练营：
```
jupyter notebook
```

如果您安装了 Jupyter Lab，请运行 `jupyter-lab`。


### 本地安装 - Windows

这些说明通常描述了在 Windows 10 下安装 Generator Bootcamp 的方法。
可能会遇到许多不同的 Windows 配置，并且可能需要进行一些更改。
如果内容已过时或此处应涵盖其他内容，请告知我们。

>在某些情况下，您可能需要启动命令（shell）窗口。
我发现以管理员模式启动命令窗口很有帮助。
为此，请从左下角的启动器中查找或搜索“CMD”，从菜单中选择它时，
右键单击并选择“以管理员模式启动”。
有关此内容的更多详细信息，请参见[此处](http://www.thewindowsclub.com/how-to-run-command-prompt-as-an-administrator)
和其他地方。
最好在过程中的各个步骤之间重新启动任何命令窗口（例如，在安装 Java 之后），
以便识别任何新安装的软件。

#### 确保已安装 Java（最好是 Java 8）。
如果在命令提示符中键入 `java` 并显示“命令未找到”，则需要安装
[Java](https://adoptopenjdk.net/installation.html)。

#### 安装 Jupyter
Jupyter 建议使用 Anaconda 发行版，这是
[Windows 下载链接](https://www.anaconda.com/download/#windows)。

在 Jupyter 安装接近尾声时，会询问是否将 Jupyter 添加到 PATH。
Windows 不建议这样做，但我建议这样做。这将使使用命令提示符运行更容易。

如果您未选择将 Jupyter 添加到 PATH，请从“开始”菜单中使用
“Anaconda Prompt (Anaconda3)”快捷方式启动提示符。

#### 安装 Scala 组件。

最简单的方法似乎是从[此处](https://github.com/coursier/coursier/releases/download/v2.0.0-RC6-24/coursier)下载 Coursier。

转到下载文件夹，其中包含 `coursier`（文件）

```
java -noverify -jar coursier launch --fork almond:0.10.6 --scala 2.12.8 -- --install
```

#### 可视化

需要 [Graphviz](https://graphviz.org/download/) 来显示 Chisel 模块的可视化效果，例如在演示页面中。但是，可视化是可选的，因为其他 Chisel 和 Scala 功能在没有它的情况下也能正常工作。

#### 安装 chisel-bootcamp 代码仓库。
将 [chisel-bootcamp](https://github.com/freechipsproject/chisel-bootcamp) 下载为 zip 文件（或使用 Windows git 客户端）
并将其解压缩到您有权访问的目录中。
理想情况下，您应该将其放在没有空格的路径中。

通过将 `chisel-bootcamp/source/custom.js` 移动到
`%HOMEDRIVE%%HOMEPATH%\.jupyter\custom\custom.js` 来安装自定义脚本。
如果您已经有一个 custom.js 文件，请将此脚本附加到它。

#### 启动 Jupyter 和训练营
在包含解压缩的 chisel-bootcamp 代码仓库的目录中，从新的命令窗口键入：
```bash
jupyter notebook
```
这应该会启动训练营服务器并在您的默认浏览器中打开一个顶层训练营菜单页面。如果它没有
在命令窗口中查找类似以下内容，并将您看到的链接复制并粘贴到
浏览器窗口中。
```bash
    Copy/paste this URL into your browser when you connect for the first time,
    to login with a token:
        http://localhost:8888/?token=9c503729c379fcb3c7a17087f05462c733c1733eb8b31d07
```

##### 代理使用
如果您需要代理，请尝试取消注释并更改 `source/load-ivy.sc` 开头的相关行。

祝您好运！

### Cadence AWS 设置

如果您不知道什么是 Cadence AWS，或者无法访问 Cadence AWS，请跳过此部分。

导航到您的工作目录，该目录可能是您的主目录。

```
cd ~
```

然后运行以下命令。
默认 shell 是 c-shell，但如果您切换到 bash，请改为 source `jupyter_sh` 而不是 `jupyter_csh`。
```
source /craft/tools/jupyter/jupyter_csh
```

默认浏览器 Konqueror 无法与 Jupyter 一起使用。
在后台启动 Firefox，并在它询问时将其设置为您的默认浏览器。
```
/craft/cdns_sw_inst/firefox/45.3.0esr/firefox &
```

克隆代码仓库并启动 Jupyter。
如果它要求提供令牌，请复制并粘贴终端中看到的*用于使用令牌登录*的 URL。
未来的启动在一段时间内将是正常的。
```
git clone /craft/tools/chisel/generator-bootcamp.git
cd generator-bootcamp
jupyter notebook
```

### Cadence Chamber 设置

如果您不知道什么是 Cadence Chamber，请跳过此部分。
导航到您的工作目录，可能是 `/projects/craft_flow/work/<username>/`。
然后运行以下命令。
请注意，`/proj/` 是 `/projects/` 的别名。
如果您使用的是 bash，请改为 source `jupyter_sh` 而不是 `jupyter_csh`。

```
source /proj/craft_flow/tools/jupyter/jupyter_csh
git clone /proj/craft_flow/source/chisel/generator-bootcamp
cd generator-bootcamp
jupyter notebook
```
