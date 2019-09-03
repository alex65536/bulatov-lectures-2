.PHONY: build clean distclean style autofix

LATEXMK = latexmk
LATEXMK_FLAGS =

all: style build

git-revision.out:

build: git-revision.out
	bash git_rev.sh
	$(LATEXMK) -pdf $(LATEXMK_FLAGS) main.tex </dev/null

style:
	bash style.sh

autofix:
	bash autofix.sh

clean:
	$(LATEXMK) -c

distclean: clean
	rm -f main.pdf main.dvi
	rm -f git-revision.out
