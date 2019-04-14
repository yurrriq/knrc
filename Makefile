CFLAGS  ?= -Wall -std=c99 -Os
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
	longlines\
	))
LIB_SRCS := $(addprefix src/,$(addsuffix .o,\
	get_line\
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

dev: ${C_SRCS} $(patsubst %.o,%.c,${LIB_SRCS}) $(patsubst %.o,%.h,${LIB_SRCS})

docs: ${PDF}
	@ echo $^

install:
	install -m755 -Dt "$$out/bin/" ${BIN}
	install -m644 -Dt "$$docs/" ${PDF}
	install -m644 -Dt "$$dev/src/" ${C_SRCS}

nix-build:
	nix-build -A all
	install -m755 -o $$(id -u) -g $$(id -g) -Dt bin result/bin/*
	install -m644 -o $$(id -u) -g $$(id -g) -Dt docs result-docs/*.pdf
	install -m644 -o $$(id -u) -g $$(id -g) -Dt src result-dev/src/*

clean:
	$(foreach pdf,${PDF},latexmk ${latexmk_flags} -f -C ${pdf};)
	rm -fR ${BIN} ${C_SRCS}{~,} docs/_minted-* result*

docs/%.pdf: src/%.pdf
	@ install -m644 -o $$(id -u) -g $$(id -g) -Dt docs $^

src/allcode.tex: $(patsubst %.c,%.nw,$(C_SRCS)) src/common.nw
	noweave -n -index $^ >$@

src/%.pdf: src/%.tex src/allcode.tex
	latexmk $(latexmk_flags) $<

bin/%: src/%.o src/libknrc.a
	${CC} ${CFLAGS} $< -Lsrc -lknrc -o $@

.INTERMEDIATE: src/libknrc.a
src/libknrc.a: ${LIB_SRCS}
	${AR} rcs $@ $^

src/%.h: src/%.nw src/common.nw
	notangle -R$(notdir $@) $^ ${cpif} $@
	indent -kr -nut $@

src/%.c: src/%.nw src/common.nw
	notangle -R$(notdir $@) $^ ${cpif} $@
	indent -kr -nut $@
