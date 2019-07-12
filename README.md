# Isoenergy

扫描隧道显微镜散射解金属等能面。

提示：如果你无法渲染其中的公式，请阅读 `README.pdf`，两者内容相同。

## 大作业简介

FIXME!

## 数据说明

100份不同的等能面附近的态密度分布，存在 `dos-momentum` 中。每份数据是
一个 `HDF5` 文件，文件中`/isoE`是一个 `(201, 201)` 的二维数组，数字代
表电子在倒空间中的态密度。其中倒空间的单位为任意值，态密度的归一常
数也是任意值：在本问题中，只有相对强度有明确的物理意义。

### 输出路径

`dos-position` 代表普通散射中心的实空间，`dos-position/m` 代表磁性散射
中心的实空间，`dos-position/damp` 代表衰减的普通散射中心的实空间，
`dos-position/m/damp` 代表衰减的磁性散射中心的实空间。

将以上的路径中 `dos-position` 替换成 `STM`，则对应相应输出数据的可视化
图。

输入数据的可视化图在 `p_momentum` 目录中。

## 作业要求（功能部分）

### Makefile

本次作业提供了 Makefile，最终助教也将使用 Makefile 进行测试。需要注意，
你在编写所有程序文件时，都应该使用 make 给程序传入的参数（来自
`sys.argv`），而非硬编码下面提到的任何文件名或通道编号等信息；否则，你
可能无法通过测试。

在本目录中运行 `make -n` 即可看到实际运行的命令，这或许能帮助你开发。

### 基本要求

作业功能部分（占80分）的基础要求分成以下几个部分，完成各个任务即可拿到相应分数。

| 任务（程序名）  | 分数 |
| --------------- | ---- |
| scatter.py      | 40   |
| gimage.py       | 20   |
| damping.py      | 20   |

#### `scatter.py `

读取 `dos-momentum/%.h5`，输出 `dos-position/%.h5`，其中`%`代表从
`0000` 到 `0099` 的字符串。以 `dos-momentum/0023.h5` 程序的调用形式为：

```
python3 scatter.py 0 dos-momentum/0023.h5 dos-position/0023.h5
```

其中第一个参数 `0` 代表普通散射中心模式，即入射波和出射波在散射中心没
有相位差。如果第一个参数是 `1`，代表磁性散射中心模式，即入射波和出射波
在散射中心有 $\pi$ 的相位差。

设倒空间的态密度为 $f(\mathbf{k})$, 当散射中心在实空间原点时，实空间的态密度为：

$ D(\mathbf{r}) = \int \mathrm{d}\mathbf{k}_1 f(\mathbf{k}_1) |\int \mathrm{d}\mathbf{k}_2 f(\mathbf{k}_2) (e^{-i\mathbf{k}_1\mathbf{r}} + e^{-i\mathbf{k}_2\mathbf{r}}| $

如果散射中心有磁性，即 `sys.argv[1]==1` 时，需要给出射波填加一个 $\pi$
的相位：

$ D(\mathbf{r}) = \int \mathrm{d}\mathbf{k}_1 f(\mathbf{k}_1) |\int \mathrm{d}\mathbf{k}_2 f(\mathbf{k}_2) (e^{-i\mathbf{k}_1\mathbf{r}} + e^{-i(\mathbf{k}_2\mathbf{r} + \pi)}| $

#### `gimage.py`

读取实空间(当 `sys.argv[1]==1`)或倒空间(当`sys.argv[1]==0`)的二维态密
度数组，画出可以表征二维标量场的图形。以 `dos-momentum/0023.h5` 为倒，
程序的调用形式为：

```
python3 gimage.py 0 dos-momentum/0023.h5 p_momentum/0023.png
```

注意标注横纵坐标的标签、图的标题。

提示：备选之一为 `matplotlib.pyplot.imshow`。

#### `damping.py`

对理想条件下的散射态密度依距离衰减：

$ D^*(\mathbf{r}) = D(\mathbf{r}) e^{-|\mathbf{r}| / L} $

其中 $L=20$ 为衰减长度，定为 20 个实空间像素单位。程序的调用形式为：

```
python3 damping.py dos-position/0023.h5 dos-position/damp/0023.h5
```

### 提高要求

提高要求为加分项，至多可加 20 分。你可以自由发挥，一些可选项为：

FIXME!

如果你实现了任何提高要求，请在实验报告中详细说明你的工作，这将作为评分的依据。

## 作业要求（非功能部分）

非功能部分的要求详见大作业公告，此部分占 20 分。
