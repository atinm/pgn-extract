# Make file for the pgn-extract program.
#    Program: pgn-extract: a Portable Game Notation (PGN) extractor.
#    Copyright (C) 1994-2015 David Barnes
#    This program is free software; you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation; either version 1, or (at your option)
#    any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program; if not, write to the Free Software
#    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
#    David Barnes may be contacted as D.J.Barnes@kent.ac.uk
#    http://www.cs.kent.ac.uk/people/staff/djb/

OBJS=grammar.o lex.o map.o decode.o moves.o lists.o apply.o output.o eco.o\
	lines.o end.o main.o hashing.o argsfile.o mymalloc.o fenmatcher.o\
	taglines.o
DEBUGINFO=-g

# These flags are particularly severe on checking warnings.
# It may be that they are not all appropriate to your environment.
# For instance, not all environments have prototypes available for
# the standard library functions.

# Linux users might need to add -D__linux__ to these in order to
# use strcasecmp instead of strcmpi (cf output.c)

# Mac OS X users might need to add -D__unix__ to CFLAGS
# and use CC=cc or CC=gcc

CFLAGS+=-c -pedantic -Wall -Wshadow -Wformat -Wpointer-arith \
	-Wstrict-prototypes -Wmissing-prototypes -Wwrite-strings \
	-Wsign-compare $(DEBUGINFO)\
	-I/usr/local/lib/ansi-include \
	-O3
CC=clang

# AIX 3.2 Users might like to use these alternatives for CFLAGS and CC.
# Thanks to Erol Basturk for providing them.
AIX_CFLAGS=-c -D_POSIX_SOURCE -D_XOPEN_SOURCE -D_ALL_SOURCE
AIX_CC=xlc

all: pgn-extract db-extract

pgn-extract : $(OBJS)
	$(CC) $(DEBUGINFO) $(OBJS) -o pgn-extract

db-extract: db-extract.o
	$(CC) $(DEBUGINFO) db-extract.o -o db-extract

purify : $(OBJS)
	purify $(CC) $(DEBUGINFO) $(OBJS) -o pgn-extract

clean:
	rm -f core pgn-extract *.o

db-extract.o : db-extract.c
	$(CC) $(CFLAGS) db-extract.c

mymalloc.o : mymalloc.c mymalloc.h
	$(CC) $(CFLAGS) mymalloc.c

apply.o :  apply.c defs.h lex.h grammar.h typedef.h map.h bool.h apply.h taglist.h\
	   eco.h decode.h moves.h hashing.h mymalloc.h output.h fenmatcher.h
	$(CC) $(CFLAGS) apply.c

argsfile.o : argsfile.c argsfile.h bool.h defs.h typedef.h lines.h \
		taglist.h tokens.h lex.h taglines.h moves.h eco.h apply.h output.h \
		lists.h mymalloc.h
	$(CC) $(CFLAGS) argsfile.c

decode.o : decode.c defs.h typedef.h taglist.h lex.h bool.h decode.h lists.h \
            tokens.h mymalloc.h
	$(CC) $(CFLAGS) decode.c

eco.o :  eco.c defs.h lex.h typedef.h map.h bool.h eco.h taglist.h apply.h \
           mymalloc.h
	$(CC) $(CFLAGS) eco.c

end.o : end.c end.h bool.h defs.h typedef.h lines.h tokens.h lex.h mymalloc.h \
        apply.h grammar.h
	$(CC) $(CFLAGS) end.c

grammar.o : grammar.c bool.h defs.h typedef.h lex.h taglist.h map.h lists.h\
	    moves.h apply.h output.h tokens.h eco.h end.h grammar.h hashing.h \
	    mymalloc.h
	$(CC) $(CFLAGS) grammar.c

hashing.o : hashing.c hashing.h bool.h defs.h typedef.h tokens.h\
		taglist.h lex.h mymalloc.h
	$(CC) $(CFLAGS) hashing.c

lex.o : lex.c bool.h defs.h typedef.h tokens.h taglist.h map.h\
	lists.h decode.h moves.h lines.h grammar.h mymalloc.h apply.h\
	output.h
	$(CC) $(CFLAGS) lex.c

lines.o : lines.c bool.h lines.h mymalloc.h
	$(CC) $(CFLAGS) lines.c

lists.o :  lists.c lists.h taglist.h bool.h defs.h typedef.h mymalloc.h
	$(CC) $(CFLAGS) lists.c

main.o : main.c bool.h defs.h typedef.h tokens.h taglist.h lex.h moves.h\
	   map.h lists.h output.h end.h grammar.h hashing.h \
	   argsfile.h mymalloc.h
	$(CC) $(CFLAGS) main.c

map.o :  map.c defs.h lex.h typedef.h map.h bool.h decode.h taglist.h \
         mymalloc.h
	$(CC) $(CFLAGS) map.c

moves.o :  moves.c defs.h typedef.h lex.h bool.h map.h lists.h moves.h apply.h\
	   lines.h taglist.h mymalloc.h fenmatcher.h
	$(CC) $(CFLAGS) moves.c

fenmatcher.o : fenmatcher.c apply.h bool.h defs.h fenmatcher.h mymalloc.h typedef.h
	$(CC) $(CFLAGS) fenmatcher.c

output.o :  output.c output.h taglist.h bool.h typedef.h defs.h lex.h grammar.h\
	    apply.h mymalloc.h
	$(CC) $(CFLAGS) output.c

taglines.o : taglines.c bool.h defs.h typedef.h tokens.h taglist.h lex.h lines.h \
             lists.h moves.h output.h taglines.h
	$(CC) $(CFLAGS) taglines.c

