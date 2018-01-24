LIBRARIES = libev libevent libuev libuv picoev

LIB_libev    = libev/libev.la
LIB_libevent = libevent/libevent.la
LIB_libuev   = libuev/src/libuev.la
LIB_libuv    = libuv/libuv.la
LIB_picoev   = picoev/libpicoev.so
LIB_TARGETS = $(foreach lib,${LIBRARIES},${LIB_${lib}})

TARGETS = ${LIB_TARGETS}

# ----------------------------------------------------------------------------

all: ${TARGETS}

# --- bench ------------------------------------------------------------------

bench:


# --- libev ------------------------------------------------------------------

libev/Makefile:
	cd libev && ./configure

libev/libev.la: libev/Makefile
	make -C libev

# --- libevent ---------------------------------------------------------------

libevent/configure:
	cd libevent && ./autogen.sh

libevent/Makefile: libevent/configure
	cd libevent && ./configure

libevent/libevent.la: libevent/Makefile
	make -C libevent

# --- libuev -----------------------------------------------------------------

libuev/configure:
	cd libuev && ./autogen.sh

libuev/Makefile: libuev/configure
	cd libuev && ./configure

libuev/src/libuev.la: libuev/Makefile
	make -C libuev

# --- libuv ------------------------------------------------------------------

libuv/configure:
	cd libuv && ./autogen.sh

libuv/Makefile: libuv/configure
	cd libuv && ./configure

libuv/libuv.la: libuv/Makefile
	make -C libuv

# --- picoev -----------------------------------------------------------------

picoev/libpicoev.so:
	make -C picoev CC=gcc LINUX_BUILD=1 CC_RELEASE_FLAGS=-O2 CC_DEBUG_FLAGS=-g

