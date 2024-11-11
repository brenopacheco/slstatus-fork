VERSION := 1.0.r$(shell git rev-list --count HEAD).$(shell git rev-parse --short HEAD)

X11INC = /usr/include/X11
X11LIB = /usr/lib

CPPFLAGS = -I$(X11INC) -D_DEFAULT_SOURCE -DVERSION=\"${VERSION}\"
CFLAGS   = -std=c99 -pedantic -Wall -Wextra -Wno-unused-parameter -Os
LDFLAGS  = -L$(X11LIB) -s
LDLIBS   = -lX11

CC = cc
