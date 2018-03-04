CFLAGS ?= -Wall -std=c99
cpif   ?= | cpif
NW_SRC := $(wildcard src/*.nw)
CH01_SRC  := $(addsuffix .c,$(addprefix src/,\
	hello\
	fahrcels\
	))
C_SRC  := ${CH01_SRC}
PDF    := $(patsubst src/%.nw,docs/%.pdf,${NW_SRC})
BIN    := $(patsubst src/%.c,bin/%,${C_SRC})


ifneq (,$(findstring B,$(MAKEFLAGS)))
latexmk_flags = -gg
endif

latexmk_flags += -cd -pdf


.PHONY: all check clean

.SUFFIXES: .tex .pdf

.tex.pdf:
	ln -sf ../src/$(notdir $*).{bib,c} ../src/preamble.tex docs/
	latexmk ${latexmk_flags} $<
	rm $*.{bib,c} docs/preamble.tex


all: ${CH01_SRC} ${BIN} ${PDF}


check:
	@ bin/check


clean:
	$(foreach pdf,${PDF},latexmk ${latexmk_flags} -f -C ${pdf};)
	rm -fR ${BIN} ${C_SRC}{~,} docs/_minted-*


docs/%.tex: src/%.nw
	noweave -n -delay -index $< ${cpif} $@


bin/%: src/%.c
	@ mkdir -p $(dir $@)
	${CC} ${CFLAGS} -o $@ $<


${CH01_SRC}: src/ch01.nw
	notangle -R$(notdir $@) $< ${cpif} $@
	indent -kr -nut $@
