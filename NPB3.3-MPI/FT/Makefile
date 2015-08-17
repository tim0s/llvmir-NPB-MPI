SHELL=/bin/sh
BENCHMARK=ft
BENCHMARKU=FT

include ../config/make.def

include ../sys/make.common

OBJS = ft.s ${COMMON}/${RAND}.s ${COMMON}/print_results.s ${COMMON}/timers.s

${PROGRAM}: config ${OBJS}
	${FLINK} ${FLINKFLAGS} -o ${PROGRAM} ${OBJS} ${FMPI_LIB}



.f.s:
	${FCOMPILE} $<

ft.s:             ft.f  global.h mpinpb.h npbparams.h

clean:
	- rm -f *.s *.o *~ mputil*
	- rm -f ft npbparams.h core
