# Makefile：包含用于本地启动文档站点的目标（mkdocs 与 jekyll），并加入多语言构建
.PHONY: s sj b install all build clean

WORKROOT := $(CURDIR)
OUTDIR   := $(WORKROOT)/output
MKDOCS_LATEST := mkdocs_HuYue_9.6.18.yml
MKDOCS_EN   := mkdocs_en.yml
MKDOCS_ZH   := mkdocs_zh.yml

# 默认目标
all: s

s:
	mkdocs serve -f $(MKDOCS_LATEST)

b:
	mkdocs build -f $(MKDOCS_LATEST)

g:
	mkdocs gh-deploy -f $(MKDOCS_LATEST) --clean

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
