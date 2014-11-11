GHC=ghc
TARGET=hscheme
MAKEFLAGS=--make
INTERFACEDIR=-hidir
BUILDDIR=-odir

PARSEC=-package parsec

GHCFLAGS=$(PARSEC) $(INTERFACEDIR) interface/ $(BUILDDIR) build/

OBJS=build/Main.o

INTERFACE=interface/Main.hi



.PHONY: all
all:	$(TARGET)

$(TARGET): $(OBJS)
	$(GHC) $(GHCFLAGS) -o $(TARGET) $^

build/Main.o: src/Main.hs
	$(GHC) $(GHCFLAGS) -o $@ -c $^

.PHONY: clean
clean:
	$(RM) $(TARGET) $(OBJS) $(INTERFACE)
