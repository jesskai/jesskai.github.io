MDSOURCES := $(wildcard md-src/*.md)
HTMLPAGES := $(MDSOURCES:md-src/%.md=docs/%.html)

P5SOURCES := $(wildcard p5-src/*.p5.rkt)
SCRIPTS := $(P5SOURCES:p5-src/%.p5.rkt=docs/%.js)

INCLUDES := $(wildcard includes/*)
ETC := $(INCLUDES:includes/%=docs/%)

all: clean $(HTMLPAGES) $(SCRIPTS) $(ETC)
.PHONY: all clean

docs/%.html: md-src/%.md
	pandoc -s $< -o $@ -f markdown

docs/%: includes/%
	cp $< $@

docs/%.js: p5-src/%.p5.rkt
	racket $< > $@

clean:
	rm -r docs
	mkdir docs
