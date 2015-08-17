SHELL=/bin/sh
BENCHMARK=ep
BENCHMARKU=EP

include ../config/make.def

OBJS = ep.s ${COMMON}/print_results.s ${COMMON}/${RAND}.s ${COMMON}/timers.s

include ../sys/make.common

${PROGRAM}: config ${OBJS}
	${FLINK} ${FLINKFLAGS} -o ${PROGRAM} ${OBJS} ${FMPI_LIB}


ep.s:		ep.f  mpinpb.h npbparams.h
	${FCOMPILE} ep.f

clean:
	- rm -f *.s *.o *~ 
	- rm -f npbparams.h core



