SHELL=/bin/sh
BENCHMARK=dt
BENCHMARKU=DT

include ../config/make.def

include ../sys/make.common
#Override PROGRAM
DTPROGRAM  = $(BINDIR)/$(BENCHMARK).$(CLASS)

OBJS = dt.s DGraph.s \
	${COMMON}/c_print_results.s ${COMMON}/c_timers.s ${COMMON}/c_randdp.s


${PROGRAM}: config ${OBJS}
	${CLINK} ${CLINKFLAGS} -o ${DTPROGRAM} ${OBJS} ${CMPI_LIB}

.c.s:
	${CCOMPILE} $<

dt.s:             dt.c  npbparams.h
DGraph.s:	DGraph.c DGraph.h

clean:
	- rm -f *.s *.o *~ mputil*
	- rm -f dt npbparams.h core
