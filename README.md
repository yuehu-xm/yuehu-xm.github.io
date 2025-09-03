   - `2025-01-01-new-paper.md`
4. 首页文案在 `index.md`，可自由编辑。

## 本地预览（可选）
先安装 Ruby、Bundler（Windows 可用 RubyInstaller）。然后在仓库根目录运行：

```bash
bundle install
bundle exec jekyll serve
```

访问 http://127.0.0.1:4000 预览（保存即热更新）。

## 在 GitHub Pages 上发布
该仓库已按 GitHub Pages 白名单插件配置，推荐使用“从分支部署”的方式：

1. 打开仓库 Settings → Pages。
2. Build and deployment → Source 选择 “Deploy from a branch”。
3. Branch 选择默认分支（一般是 `main`），Folder 选 `/ (root)`。
4. 保存后等待 1-3 分钟，访问：https://yuehu-xm.github.io

若你更偏好 GitHub Actions 构建，可在 Pages 中选择 “GitHub Actions”，添加官方 `jekyll` 工作流（可另行说明）。

## 常见问题
- 构建失败？先确认 `Settings → Pages` 的 Source/Branch 设置正确；再看仓库的 Actions/Pages 日志；必要时暂时移除新加的插件或前后回退确认。
- 自定义域名？在仓库根目录添加 `CNAME` 文件填入你的域名，并在 DNS 解析到 GitHub Pages。
# yuehu-xm.github.io

一个使用 Jekyll + Markdown 搭建的学术主页（适配 GitHub Pages）。你只需改 Markdown 内容即可。

## 结构
- `_config.yml`：站点配置（标题/导航/插件/URL 等）
- `index.md`：主页（layout: home，顶部简介 + 最新动态列表）
- `about.md`：关于我
- `publications.md`：发表论文
- `projects.md`：项目
- `_posts/`：博客文章（首页展示），按 `YYYY-MM-DD-title.md` 命名
- `Gemfile`：本地预览依赖（github-pages）
- `.gitignore`：忽略构建目录等

## 如何修改内容
1. 修改 `_config.yml` 中的站点标题、描述、邮箱、单位等。
2. 在 `about.md`、`publications.md`、`projects.md` 填写你的真实信息。
3. 在 `_posts/` 新增 Markdown 文章发布新闻/通知，例如：
