CFLAGS ?= -Wall -std=c99
cpif   ?= | cpif
NW_SRC := $(wildcard src/*.nw)
CH01_SRC  := $(addsuffix .c,$(addprefix src/,\
	hello\
	fahrcels\
	copy\
	catblanks\
	wc\
	))
C_SRC  := ${CH01_SRC}
PDF    := $(patsubst src/%.nw,docs/%.pdf,${NW_SRC})
BIN    := $(patsubst src/%.c,bin/%,${C_SRC})


ifneq (,$(findstring B,$(MAKEFLAGS)))
latexmk_flags = -gg
endif

latexmk_flags += -cd -pdf


.PHONY: all
all: bin dev docs

.PHONY: bin
bin: ${BIN}

.PHONY: dev
dev: ${CH01_SRC}

.PHONY: docs
docs: ${PDF}


.PHONY: install
install:
	install -m755 -Dt "$$out/bin/" ${BIN}
	install -m644 -Dt "$$docs/" ${PDF}
	install -m644 -Dt "$$dev/src/" ${C_SRC}


.SUFFIXES: .tex .pdf

.tex.pdf:
	ln -sf ../src/$(notdir $*).{bib,c} ../src/preamble.tex docs/
	latexmk ${latexmk_flags} $<
	rm $*.{bib,c} docs/preamble.tex


.PHONY: clean
clean:
	$(foreach pdf,${PDF},latexmk ${latexmk_flags} -f -C ${pdf};)
	rm -fR ${BIN} ${C_SRC}{~,} docs/_minted-* result*


docs/%.tex: src/%.nw
	noweave -n -delay -index $< ${cpif} $@


bin/%: src/%.c
	@ mkdir -p $(dir $@)
	${CC} ${CFLAGS} -o $@ $<


${CH01_SRC}: src/ch01.nw
	notangle -R$(notdir $@) $< ${cpif} $@
	indent -kr -nut $@


.PHONY: nix-build
nix-build:
	nix-build -A all
	install -m755 -o $$(id -u) -g $$(id -g) -Dt bin result/bin/*
	install -m644 -o $$(id -u) -g $$(id -g) -Dt docs result-docs/*.pdf
	install -m644 -o $$(id -u) -g $$(id -g) -Dt src result-dev/src/*
