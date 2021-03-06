#! make
CC=gcc
CFLAGS=-c -Wall -std=c99 -I./src/tests -I./src/lib 
LDFLAGS= 
MAKE=make
LIBFILES=./src/lib/replace_bbcode.c 
TESTFILES=./src/tests/main.c ./src/tests/test_bbcode.c
CFILES=$(LIBFILES) $(TESTFILES)

SOURCES = $(notdir $(CFILES))
EXECUTABLE=testbbcode.exe
BUILDDIR=./bin/debug/

#LINT=lint -p
OBJECTS=$(addprefix $(BUILDDIR),$(SOURCES:.c=.o))

EXECUTABLEPATH=$(BUILDDIR)$(EXECUTABLE)

all: $(CFILES) $(EXECUTABLEPATH) 

folder:
	mkdir -p $(BUILDDIR)

$(EXECUTABLEPATH): $(OBJECTS) folder
	$(CC) $(LDFLAGS) $(OBJECTS) -o $@

run: $(EXECUTABLEPATH)
	cd $(BUILDDIR); ./$(EXECUTABLE);

clean: 
	rm $(OBJECTS) 
	rm $(EXECUTABLEPATH)
	rmdir $(BUILDDIR)

$(BUILDDIR)main.o: ./src/tests/main.c folder
	$(CC) $(CFLAGS) -c $< -o $@

$(BUILDDIR)replace_bbcode.o: ./src/lib/replace_bbcode.c folder
	$(CC) $(CFLAGS) -c $< -o $@

$(BUILDDIR)test_bbcode.o: ./src/tests/test_bbcode.c folder
	$(CC) $(CFLAGS) -c $< -o $@

#lint: $(SOURCES)
#	$(LINT) $(SOURCES)

$(BUILDDIR)%.o: %.c	folder
	$(CC) $(CFLAGS) -c $< -o $@
