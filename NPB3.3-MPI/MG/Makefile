SHELL=/bin/sh
BENCHMARK=mg
BENCHMARKU=MG

include ../config/make.def

OBJS = mg.s ${COMMON}/print_results.s  \
       ${COMMON}/${RAND}.s ${COMMON}/timers.s

include ../sys/make.common

${PROGRAM}: config ${OBJS}
	${FLINK} ${FLINKFLAGS} -o ${PROGRAM} ${OBJS} ${FMPI_LIB}

mg.s:		mg.f  globals.h mpinpb.h npbparams.h
	${FCOMPILE} mg.f

clean:
	- rm -f *.s *.o *~ 
	- rm -f npbparams.h core



