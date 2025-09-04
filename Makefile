# Makefile：本地预览 / 构建 / 部署 MkDocs 站点（含多语言构建）
# 适用环境：
# - Windows 推荐使用 Git Bash 或 WSL 运行（支持 mkdir -p、cp、rm）
# - 若在 CMD/PowerShell 下运行，请使用下方给出的 Windows 原生命令（取消注释）
# 前提依赖：已安装 Python 与 mkdocs（例如：pip install mkdocs mkdocs-material）

.PHONY: all s b g build clean a m p amp

# 关闭子 make 的目录提示（更安静）
#MAKEFLAGS += --no-print-directory

# 工作根目录（make 的内置变量 CURDIR 即当前目录）
WORKROOT := $(CURDIR)
# 多语言构建时的统一输出目录
OUTDIR   := $(WORKROOT)/output

# 提交信息（可通过 `make m COMMIT_MSG="your message"` 覆盖）
COMMIT_MSG ?= update

# 主配置文件（常用：预览/构建/部署）
MKDOCS_LATEST := mkdocs_HuYue_9.6.18.yml
# 多语言构建所用配置
MKDOCS_EN   := mkdocs_en.yml
MKDOCS_ZH   := mkdocs_zh.yml

# 默认目标：启动本地预览（热重载）
all: s

# ======================================================================================================================

# 本地预览：启动开发服务器（默认端口 8000）
# 访问地址通常为：http://127.0.0.1:8000
s:
	mkdocs serve -f $(MKDOCS_LATEST)

# 构建静态站点到默认目录 site/
b:
	mkdocs build -f $(MKDOCS_LATEST)

# 部署到 GitHub Pages：推送到 gh-pages 分支
# --clean：部署前清理远端旧文件，避免历史遗留
g:
	mkdocs gh-deploy -f $(MKDOCS_LATEST) --clean

# ======================================================================================================================

a:
	@git add .

m:
	@git diff --cached --quiet && echo [m] no staged changes, skip commit || git commit -m "$(COMMIT_MSG)"

p:
	@git push


amp:
	git add .
	git diff --cached --quiet && echo [amp] no staged changes, skip commit and push || (git commit -m "$(COMMIT_MSG)" && git push)



# ======================================================================================================================

# 多语言构建：分别产出到 output/en 与 output/zh
build:
	# 创建目录（Git Bash/WSL 可用）；若使用 CMD/PowerShell，请使用下方等价命令
	mkdir -p $(OUTDIR)/en
	# PowerShell 等价（备用）：
	# powershell -NoProfile -Command "New-Item -ItemType Directory -Force '$(OUTDIR)\en' | Out-Null"

	# 构建英文站点
	mkdocs build -f $(MKDOCS_EN) -d $(OUTDIR)/en

	# 复制静态资源（Git Bash/WSL 可用）；Windows(CMD) 可用 xcopy；`|| true` 防止不存在时报错
	cp -R images $(OUTDIR)/en || true
	# Windows（CMD）等价（备用）：
	# xcopy images "$(OUTDIR)\en\images" /E /I /Y

	# 创建中文目录
	mkdir -p $(OUTDIR)/zh
	# PowerShell 等价：
	# powershell -NoProfile -Command "New-Item -ItemType Directory -Force '$(OUTDIR)\zh' | Out-Null"

	# 构建中文站点
	mkdocs build -f $(MKDOCS_ZH) -d $(OUTDIR)/zh

	# 复制静态资源
	cp -R images $(OUTDIR)/zh || true
	# Windows（CMD）等价：
	# xcopy images "$(OUTDIR)\zh\images" /E /I /Y

# 清理输出目录
clean:
	# Git Bash/WSL
	rm -rf $(OUTDIR) || true
	# Windows（CMD）等价：
	# rmdir /S /Q "$(OUTDIR)"
	# PowerShell 等价：
	# powershell -NoProfile -Command "Remove-Item -Recurse -Force '$(OUTDIR)'"
