CFLAGS  ?= -Wall -std=c99
cpif    ?= | cpif
C_SRCS  := $(addsuffix .c,$(addprefix src/,\
	hello\
	fahrcels\
	copy\
	catblanks\
	unambiguous\
	wc\
	words\
	wordlength\
	charfreq\
	longestline\
	))
PDF     := docs/doc.pdf
BIN     := $(patsubst src/%.c,bin/%,${C_SRCS})

ifneq (,$(findstring B,$(MAKEFLAGS)))
latexmk_flags = -gg
endif

latexmk_flags += -cd -pdf -Werror

.PHONY: all bin dev docs install clean nix-build

all: bin dev docs

bin: ${BIN}

dev: ${C_SRCS}

docs: ${PDF}
	@ echo $^

docs/%.pdf: src/%.pdf
	@ install -m644 -o $$(id -u) -g $$(id -g) -Dt docs $^

install:
	install -m755 -Dt "$$out/bin/" ${BIN}
	install -m644 -Dt "$$docs/" ${PDF}
	install -m644 -Dt "$$dev/src/" ${C_SRCS}

src/allcode.tex: $(patsubst %.c,%.nw,$(C_SRCS)) src/common.nw
	noweave -n -index $^ >$@

src/%.pdf: src/%.tex src/allcode.tex
	latexmk $(latexmk_flags) $<

clean:
	$(foreach pdf,${PDF},latexmk ${latexmk_flags} -f -C ${pdf};)
	rm -fR ${BIN} ${C_SRCS}{~,} docs/_minted-* result*

bin/%: src/%.c
	@ mkdir -p $(dir $@)
	${CC} ${CFLAGS} -o $@ $<

src/%.c: src/%.nw src/common.nw
	notangle -R$(notdir $@) $^ ${cpif} $@
	indent -kr -nut $@

nix-build:
	nix-build -A all
	install -m755 -o $$(id -u) -g $$(id -g) -Dt bin result/bin/*
	install -m644 -o $$(id -u) -g $$(id -g) -Dt docs result-docs/*.pdf
	install -m644 -o $$(id -u) -g $$(id -g) -Dt src result-dev/src/*
