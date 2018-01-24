LIBRARIES = libev libevent libuev libuv picoev

LIB_libev    = ${OBJDIR}/libev/lib/libev.a
LIB_libevent = ${OBJDIR}/libevent/lib/libevent.a
LIB_libuev   = ${OBJDIR}/libuev/lib/libuev.a
LIB_libuv    = ${OBJDIR}/libuv/lib/libuv.a
LIB_picoev   = ${OBJDIR}/picoev/lib/libpicoev.a
LIB_TARGETS = $(foreach lib,${LIBRARIES},${LIB_${lib}})

TOP      = $(shell pwd)
OBJ      = _obj
OBJDIR   = ${TOP}/${OBJ}

BENCH_TARGETS = bench bench-libev bench-libevent bench-picoev

TARGETS  = ${LIB_TARGETS} ${BENCH_TARGETS}

CCFLAGS  = -Os -ggdb
INCLUDES = $(foreach lib,${LIBRARIES},-I_obj/${lib}/include)
CPPFLAGS = 
LDFLAGS  =
LIBS     = ${LIB_picoev} ${LIB_libevent} ${LIB_libev}

# ----------------------------------------------------------------------------

all: ${TARGETS}

# --- bench ------------------------------------------------------------------

bench: bench.c ${LIB_TARGETS} Makefile
	${CC} ${CCFLAGS} ${CPPFLAGS} $< -o $@ ${LDFLAGS} ${LIBS} \
		${INCLUDES} -DWITH_libev -DWITH_libevent -DWITH_picoev

bench-libev: bench.c ${LIB_libev} Makefile
	${CC} ${CCFLAGS} ${CPPFLAGS} $< -o $@ ${LDFLAGS} \
		-I_obj/libev/include ${LIB_libev} -DWITH_libev

bench-libevent: bench.c ${LIB_libevent} Makefile
	${CC} ${CCFLAGS} ${CPPFLAGS} $< -o $@ ${LDFLAGS} \
		-I_obj/libevent/include ${LIB_libevent} -DWITH_libevent

bench-picoev: bench.c ${LIB_picoev} Makefile
	${CC} ${CCFLAGS} ${CPPFLAGS} $< -o $@ ${LDFLAGS} \
		-I_obj/picoev/include ${LIB_picoev} -DWITH_picoev

# --- libev ------------------------------------------------------------------

libev/Makefile:
	cd libev && ./configure

libev/libev.la: libev/Makefile
	make -C libev

${OBJDIR}/libev/lib/libev.a: libev/libev.la
	mkdir -p ${OBJDIR}/libev
	make -C libev install prefix=${OBJDIR}/libev

# --- libevent ---------------------------------------------------------------

libevent/configure:
	cd libevent && ./autogen.sh

libevent/Makefile: libevent/configure
	cd libevent && CC='gcc -m64' ./configure

libevent/libevent.la: libevent/Makefile
	make -C libevent

${OBJDIR}/libevent/lib/libevent.a: libevent/libevent.la
	mkdir -p ${OBJDIR}/libevent
	make -C libevent install prefix=${OBJDIR}/libevent

# --- libuev -----------------------------------------------------------------

libuev/configure:
	cd libuev && ./autogen.sh

libuev/Makefile: libuev/configure
	cd libuev && ./configure

libuev/src/libuev.la: libuev/Makefile
	make -C libuev

${OBJDIR}/libuev/lib/libuev.a: libuev/src/libuev.la
	mkdir -p ${OBJDIR}/libuev
	make -C libuev install prefix=${OBJDIR}/libuev

# --- libuv ------------------------------------------------------------------

libuv/configure:
	cd libuv && ./autogen.sh

libuv/Makefile: libuv/configure
	cd libuv && ./configure

libuv/libuv.la: libuv/Makefile
	make -C libuv

${OBJDIR}/libuv/lib/libuv.a: libuv/libuv.la
	mkdir -p ${OBJDIR}/libuv
	make -C libuv install prefix=${OBJDIR}/libuv

# --- picoev -----------------------------------------------------------------

picoev/libpicoev.a:
	make -C picoev CC=gcc LINUX_BUILD=1 CC_RELEASE_FLAGS=-O2 CC_DEBUG_FLAGS=-g

${OBJDIR}/picoev/lib/libpicoev.a: picoev/libpicoev.a
	mkdir -p ${OBJDIR}/picoev/lib
	cp picoev/libpicoev.a ${OBJDIR}/picoev/lib
	mkdir -p ${OBJDIR}/picoev/include
	cp picoev/picoev.h ${OBJDIR}/picoev/include

