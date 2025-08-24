# Go 后端开发教程 - Hugo 站点

这是一个基于 Hugo 和 Docsy 主题构建的 Go 后端开发教程网站。

## 🚀 快速开始

### 环境要求

- Hugo Extended v0.110.0+ 
- Node.js v16+
- Go 1.19+

### 本地开发

```bash
# 克隆项目
git clone <your-repo-url>
cd course-backend-go-2025

# 安装依赖
npm install

# 启动开发服务器
hugo server --bind 0.0.0.0 --port 1313

# 构建生产版本
hugo --minify
```

## 📁 项目结构

```
course-backend-go-2025/
├── content/                 # 内容文件
│   ├── _index.md           # 首页内容
│   └── docs/               # 课程文档
│       ├── _index.md       # 文档首页
│       ├── lesson00/       # 第0课
│       ├── lesson01/       # 第1课
│       └── ...
├── static/                 # 静态资源
│   ├── images/             # 图片资源
│   │   ├── lesson00/       # 第0课图片
│   │   ├── lesson01/       # 第1课图片
│   │   └── ...
│   └── img/                # 其他图片
├── config/                 # 配置文件
│   └── _default/
│       ├── params.toml     # 主题参数
│       └── menus.toml      # 菜单配置
├── hugo.toml              # 主配置文件
├── package.json           # Node.js 依赖
└── go.mod                 # Hugo 模块配置
```

## ✏️ 内容修改指南

### 1. 修改首页内容

编辑 `content/_index.md` 文件：

```markdown
---
title: "Go 后端开发教程"
linkTitle: "Go 后端开发教程"
---

{{< blocks/cover title="你的标题" image_anchor="top" height="full" >}}
<!-- 首页内容 -->
{{< /blocks/cover >}}
```

### 2. 添加新课程

#### 步骤1：创建课程目录
```bash
mkdir content/docs/lesson19
```

#### 步骤2：创建课程文件
```bash
# 创建课程文件
touch content/docs/lesson19/新课程.md
```

#### 步骤3：添加 Front Matter
在课程文件开头添加：

```markdown
---
title: "课程标题"
linkTitle: "第19课"
weight: 20
description: >
  课程描述
---

# 课程内容开始...
```

#### 步骤4：添加图片（如果需要）
```bash
# 创建图片目录
mkdir static/images/lesson19

# 复制图片到该目录
cp your-images/* static/images/lesson19/
```

在 Markdown 中引用图片：
```markdown
![图片描述](/images/lesson19/your-image.png)
```

### 3. 修改现有课程

直接编辑对应的课程文件：
```bash
# 例如修改第1课
vim content/docs/lesson01/蓝山工作室——Golang第一节课.md
```

### 4. 修改导航菜单

编辑 `config/_default/menus.toml`：

```toml
[[main]]
name = "菜单名称"
url = "/your-url/"
weight = 30
```

### 5. 修改站点配置

编辑 `hugo.toml`：

```toml
title = '你的站点标题'
baseURL = 'https://your-domain.com/'

[params]
  github_repo = 'https://github.com/your-username/your-repo'
  # 其他配置...
```

## 🖼️ 图片管理

### 图片存放规则

- 课程图片：`static/images/lesson{XX}/`
- 通用图片：`static/images/`
- 特殊图片：`static/img/`

### 图片引用格式

```markdown
# 课程图片
![描述](/images/lesson00/image.png)

# 通用图片  
![描述](/images/common-image.png)

# 外部图片
![描述](https://external-url.com/image.png)
```

### 批量修复图片路径

如果图片路径有问题，运行修复脚本：

```bash
./fix_image_paths.sh
```

## 🎨 主题自定义

### 修改主题参数

编辑 `config/_default/params.toml`：

```toml
[ui]
sidebar_menu_compact = false
breadcrumb_disable = false
sidebar_search_disable = false
navbar_logo = true
footer_about_enable = true

[[links.user]]
name = "GitHub"
url = "https://github.com/your-username/your-repo"
icon = "fab fa-github"
desc = "Development takes place here!"
```

### 自定义样式

如需自定义 CSS，创建：
```bash
mkdir -p assets/scss
touch assets/scss/_variables_project.scss
touch assets/scss/_styles_project.scss
```

## 🚀 部署

### GitHub Pages

1. 推送代码到 GitHub
2. 在仓库设置中启用 GitHub Pages
3. 选择 GitHub Actions 作为源
4. 创建 `.github/workflows/hugo.yml`：

```yaml
name: Deploy Hugo site to Pages

on:
  push:
    branches: ["main"]
  workflow_dispatch:

permissions:
  contents: read
  pages: write
  id-token: write

concurrency:
  group: "pages"
  cancel-in-progress: false

defaults:
  run:
    shell: bash

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4
        with:
          submodules: recursive
      
      - name: Setup Hugo
        uses: peaceiris/actions-hugo@v2
        with:
          hugo-version: 'latest'
          extended: true
      
      - name: Setup Node
        uses: actions/setup-node@v4
        with:
          node-version: '18'
          cache: 'npm'
      
      - name: Install dependencies
        run: npm ci
      
      - name: Build with Hugo
        env:
          HUGO_ENVIRONMENT: production
          HUGO_ENV: production
        run: hugo --minify
      
      - name: Upload artifact
        uses: actions/upload-pages-artifact@v2
        with:
          path: ./public

  deploy:
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    runs-on: ubuntu-latest
    needs: build
    steps:
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v2
```

### Vercel 部署

1. 连接 GitHub 仓库到 Vercel
2. 设置构建命令：`hugo --minify`
3. 设置输出目录：`public`
4. 设置环境变量：`HUGO_VERSION=0.148.2`

### Netlify 部署

1. 连接 GitHub 仓库到 Netlify
2. 设置构建命令：`hugo --minify`
3. 设置发布目录：`public`
4. 在 `netlify.toml` 中配置：

```toml
[build]
publish = "public"
command = "hugo --minify"

[context.production.environment]
HUGO_VERSION = "0.148.2"
HUGO_ENV = "production"
HUGO_ENABLEGITINFO = "true"
```

## 🔧 常用命令

```bash
# 启动开发服务器
hugo server -D

# 构建站点
hugo

# 构建并压缩
hugo --minify

# 清理缓存
hugo mod clean

# 更新模块
hugo mod get -u

# 检查配置
hugo config

# 查看站点信息
hugo list all
```

## 📝 内容编写技巧

### Front Matter 模板

```yaml
---
title: "课程标题"
linkTitle: "简短标题"
weight: 10
description: >
  课程描述，支持多行
date: 2024-01-01
draft: false
---
```

### Docsy 短代码

```markdown
# 提示框
{{% alert title="提示" %}}
这是一个提示信息
{{% /alert %}}

# 代码块
{{< highlight go >}}
func main() {
    fmt.Println("Hello, World!")
}
{{< /highlight >}}

# 卡片
{{< cardpane >}}
{{< card header="标题" >}}
内容
{{< /card >}}
{{< /cardpane >}}
```

## 🐛 常见问题

### 1. 图片不显示
- 检查图片路径是否正确
- 确保图片文件存在于 `static/` 目录
- 运行 `./fix_image_paths.sh` 修复路径

### 2. 构建失败
- 检查 Hugo 版本是否符合要求
- 确保 Node.js 依赖已安装
- 检查 Markdown 语法是否正确

### 3. 主题样式问题
- 清理缓存：`hugo mod clean`
- 重新构建：`hugo --minify`
- 检查主题配置是否正确

### 4. 中文字符问题
- 确保文件编码为 UTF-8
- 检查 `hugo.toml` 中的语言配置

## 📚 参考资源

- [Hugo 官方文档](https://gohugo.io/documentation/)
- [Docsy 主题文档](https://www.docsy.dev/docs/)
- [Markdown 语法指南](https://www.markdownguide.org/)
- [Hugo 短代码参考](https://gohugo.io/content-management/shortcodes/)

## 🤝 贡献指南

1. Fork 项目
2. 创建特性分支：`git checkout -b feature/new-lesson`
3. 提交更改：`git commit -am 'Add new lesson'`
4. 推送分支：`git push origin feature/new-lesson`
5. 提交 Pull Request

---

如有问题，请提交 Issue 或联系维护者。