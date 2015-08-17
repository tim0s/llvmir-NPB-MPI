SHELL=/bin/sh
BENCHMARK=cg
BENCHMARKU=CG

include ../config/make.def

OBJS = cg.s ${COMMON}/print_results.s  \
       ${COMMON}/${RAND}.s ${COMMON}/timers.s

include ../sys/make.common

${PROGRAM}: config ${OBJS}
	${FLINK} ${FLINKFLAGS} -o ${PROGRAM} ${OBJS} ${FMPI_LIB}

cg.s:		cg.f  mpinpb.h npbparams.h
	${FCOMPILE} cg.f

clean:
	- rm -f *.s *.o *~ 
	- rm -f npbparams.h core



