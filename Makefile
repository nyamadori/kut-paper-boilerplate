# 文献リストファイル
REFERENCE_FILE = refs.bib

# 画像ディレクトリ
IMAGE_DIR = images/

XBB_SRC_SUFFIXES = %.jpg %.jpeg %.png %.pdf
XBB_SRC_FILE_PATTERN = $(patsubst \%.%,$(IMAGE_DIR)*.%,$(XBB_SRC_SUFFIXES))
XBB_SRC_FILES = $(wildcard $(XBB_SRC_FILE_PATTERN))

.PHONY: clean all abstract paper debug
all: abstract paper
abstract: abstract.pdf
paper: paper.pdf

clean:
	rm -f *.{aux,pdf,log,bbl,blg,dvi,lof}
	rm -f images/*.xbb

%.pdf: %.tex %.xbb $(REFERENCE_FILE)
	sed -i'.bak' -e 's/、/，/g; s/。/．/g' $<
	platex $*
	pbibtex $*
	platex $*
	platex $*
	dvipdfmx $*

%.xbb: $(XBB_SRC_FILES)
	extractbb $?
