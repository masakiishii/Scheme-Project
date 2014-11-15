HC=ghc
TARGET=hscheme
MAKEFLAGS=--make

INTERFACEDIR=-hidir
BUILDDIR=-odir

PARSEC=-package parsec

TARGETDIR=./src

HCFLAGS=$(PARSEC) $(MAKEFLAGS) $(INTERFACEDIR) interface/ $(BUILDDIR) build/ -i$(TARGETDIR)

OBJS=build/Main.o \
	build/LispVal.o \
	build/ShowVal.o \
	build/Symbol.o

INTERFACE=interface/Main.hi \
	interface/LispVal.hi \
	interface/ShowVal.hi \
	interface/Symbol.hi

SRC=src/Main.hs


.PHONY: all
all:	$(TARGET)

$(TARGET): $(SRC)
	$(HC) $(HCFLAGS) -o $(TARGET) $^

.PHONY: clean
clean:
	$(RM) $(TARGET) $(OBJS) $(INTERFACE)
