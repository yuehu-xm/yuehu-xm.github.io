# Makefile：包含用于本地启动文档站点的目标（mkdocs 与 jekyll），并加入多语言构建
.PHONY: s sj b install all build clean

WORKROOT := $(CURDIR)
OUTDIR   := $(WORKROOT)/output
MKDOCS_LATEST := mkdocs_HuYue_9.6.18.yml
MKDOCS_EN   := mkdocs_en.yml
MKDOCS_ZH   := mkdocs_zh.yml

# 默认目标：构建站点
all: build

# 使用指定的 mkdocs 配置文件启动本地开发服务器（支持热重载）
s:
	mkdocs serve -f $(MKDOCS_LATEST)

# 通过 Bundler 启动 Jekyll，本地服务器启用 livereload（需安装依赖）
sj:
	bundle exec jekyll serve --livereload

# 构建使用指定 mkdocs 配置文件的静态站点
b:
	mkdocs build -f $(MKDOCS_LATEST)

# 安装项目所需的 Python 依赖（参见 `requirements.txt`）
install:
	pip install -r requirements.txt

build:
	mkdir -p $(OUTDIR)/en
	mkdocs build -f $(MKDOCS_EN) -d $(OUTDIR)/en
	# 复制 images（Unix）
	cp -R images $(OUTDIR)/en || true
	# Windows 原生命令备用（在 CMD 下可取消注释并使用）
	# xcopy images "$(OUTDIR)\\en\\images" /E /I /Y

	mkdir -p $(OUTDIR)/zh
	mkdocs build -f $(MKDOCS_ZH) -d $(OUTDIR)/zh
	# 复制 images（Unix）
	cp -R images $(OUTDIR)/zh || true
	# Windows 原生命令备用（在 CMD 下可取消注释并使用）
	# xcopy images "$(OUTDIR)\\zh\\images" /E /I /Y


clean:
	# 清理输出目录（Unix）
	rm -rf $(OUTDIR) || true
	# Windows 原生命令备用：
	# rmdir /S /Q "$(OUTDIR)"
