<p align="center" height="250">
  <img height="300" src="logo.png" align="center"/>
</p>
<p align=center>
<a target="_blank" href="https://www.npmjs.com/package/@fine.sh/cli" title="NPM version"><img src="https://img.shields.io/npm/v/@fine.sh/cli/latest.svg?style=flat-square"></a>
<a target="_blank" href="https://www.npmjs.com/package/@fine.sh/clis" title="Node version"><img src="https://img.shields.io/npm/dt/@fine.sh/cli.svg?style=flat-square"></a>
<a target="_blank" href="https://opensource.org/licenses/MIT" title="License: MIT"><img src="https://img.shields.io/github/license/WittBulter/@fine.sh/cli.svg?style=flat-square"></a>
<a target="_blank" href="https://travis-ci.org/WittBulter/@fine.sh/cli" title="Build Status"><img src="https://img.shields.io/travis/WittBulter/@fine.sh/cli.svg?style=flat-square"></a>
</p>

## fine -- generate your document site in 3 seconds

> fine 目前仍旧处于测试版本，我们会不断补充更多的功能，同时也尽可能的提高它的健壮性。

> 你可以在 [这里](https://github.com/WittBulter/fine.sh-cli/issues/new) 留下建议和反馈。

<br/>

### 什么是 fine

> fine 是帮助你在无服务器的环境下快速生成文档站点的工具，你可以用它为自己的项目快速生成文档而不用关心样式、部署、页面的问题。

> 甚至你可以用 fine 来生成自己的博客，fine 为任何一个项目都提供了独特的域名。

> 当然，最重要的是，fine 是免费的。

<br/>

### 怎么使用 fine

首先你需要准备一个包含 markdown 文件 (.md) 的项目，fine 的工作是帮助你把 markdown 文件转化成站点并部署它们。

切换到你的项目目录下，输入以下命令：

```bash
npx @fine.sh/cli
```

没有了？

是的。npx 允许你临时使用一个包，完成会立刻清除。你可以用这条命令试试这个 fine 是如何帮你生成一个文档站点的。

**如果你需要使用 fine，建议安装 fine 到全局:**

```bash
npm i @fine.sh/cli -g
```

<br/>

### 使用指南

你可以选择快速部署模式在几秒内生成一个站点，当然也可以让 fine.sh/cli 在项目目录下生成一个配置文件，这样你就可以拥有一个特别的域名。

举例来说，如果你配置的项目名称是 'love'，理所应当的，当你运行完成后就会得到一个 'love.fine.sh' 的域名。这是你专属的。

当你修改了一些文档想要再次使用它时，不用担心，只需要输入:

```bash
fine
```

事就这样成了。

<br/>

### 更多命令

    - fine login --- 登录
    - fine ls --- 查看我的项目
    - fine who --- 查看我的信息
    - fine rm --- 根据提示移除一个项目

<br/>

### 约定

虽然你可以通过 fine.sh 免费发布文档站点，但仍旧要对其中内容负责。

    - fine.sh 只能发布非盈利性质的文档站点。

    - **如果你的独有站点中的内容不符合文档站点，或是包含违反法律、社会道德、引起他人强烈不适的内容，fine.sh 有权利在不告知的情况下屏蔽您的站点同时协助相关部门的调查取证工作。**

<br/>

### LICENSE

[**MIT**](LICENSE)
