# 日常维护指南

## 🔄 常用修改操作

### 1. 修改课程内容

直接编辑对应的 Markdown 文件：
```bash
# 例如修改第1课
vim content/docs/lesson01/蓝山工作室——Golang第一节课.md
```

修改后推送到 GitHub，Vercel 会自动重新部署。

### 2. 添加新课程

```bash
# 创建新课程目录和文件
mkdir content/docs/lesson19
touch content/docs/lesson19/新课程名.md
```

在文件开头添加：
```markdown
---
title: "课程标题"
linkTitle: "第19课"
weight: 20
description: >
  课程描述
---

# 课程内容...
```

### 3. 添加图片

```bash
# 为新课程创建图片目录
mkdir static/images/lesson19

# 复制图片
cp your-images/* static/images/lesson19/
```

在 Markdown 中引用：
```markdown
![图片描述](/images/lesson19/your-image.png)
```

### 4. 修改首页

编辑 `content/_index.md` 文件，修改首页的介绍内容。

### 5. 修改站点配置

编辑 `hugo.toml`：
- 修改站点标题：`title = '新标题'`
- 修改 GitHub 链接：`github_repo = 'https://github.com/your-username/your-repo'`

## 🖼️ 图片问题修复

如果图片显示有问题，运行：
```bash
./fix_image_paths.sh
```

## 🧪 本地测试

```bash
# 启动本地服务器预览
hugo server --bind 0.0.0.0 --port 1313

# 访问 http://localhost:1313 查看效果
```

## 📤 发布流程

1. 修改内容
2. 本地测试（可选）
3. 提交到 GitHub：
   ```bash
   git add .
   git commit -m "更新课程内容"
   git push
   ```
4. Vercel 自动部署（通常1-2分钟完成）

## ⚠️ 注意事项

- 图片文件名不要包含中文字符
- Markdown 文件保存为 UTF-8 编码
- 每次修改后记得提交到 GitHub
- 如果 Vercel 部署失败，检查构建日志

就这么简单！有问题随时问我。