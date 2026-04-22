SRCS := $(filter-out shared.typ, $(wildcard *.typ))
PDFS := $(SRCS:.typ=.pdf)

.PHONY: all clean

all: $(PDFS)

%.pdf: %.typ shared.typ
	typst compile $<

clean:
	rm -f $(PDFS)
