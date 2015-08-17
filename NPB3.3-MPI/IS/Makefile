SHELL=/bin/sh
BENCHMARK=is
BENCHMARKU=IS

include ../config/make.def

include ../sys/make.common

OBJS = is.s ${COMMON}/c_print_results.s ${COMMON}/c_timers.s


${PROGRAM}: config ${OBJS}
	${CLINK} ${CLINKFLAGS} -o ${PROGRAM} ${OBJS} ${CMPI_LIB}

.c.s:
	${CCOMPILE} $<

is.s:             is.c  npbparams.h


clean:
	- rm -f *.s *.o *~ mputil*
	- rm -f is npbparams.h core
