SHELL=/bin/sh
BENCHMARK=bt
BENCHMARKU=BT
VEC=

include ../config/make.def


OBJS = bt.s make_set.s initialize.s exact_solution.s exact_rhs.s \
       set_constants.s adi.s define.s copy_faces.s rhs.s solve_subs.s \
       x_solve$(VEC).s y_solve$(VEC).s z_solve$(VEC).s add.s error.s \
       verify.s setup_mpi.s \
       ${COMMON}/print_results.s ${COMMON}/timers.s

include ../sys/make.common

# npbparams.h is included by header.h
# The following rule should do the trick but many make programs (not gmake)
# will do the wrong thing and rebuild the world every time (because the
# mod time on header.h is not changed. One solution would be to 
# touch header.h but this might cause confusion if someone has
# accidentally deleted it. Instead, make the dependency on npbparams.h
# explicit in all the lines below (even though dependence is indirect). 

# header.h: npbparams.h

${PROGRAM}: config
	@if [ x$(VERSION) = xvec ] ; then	\
		${MAKE} VEC=_vec exec;		\
	elif [ x$(VERSION) = xVEC ] ; then	\
		${MAKE} VEC=_vec exec;		\
	else					\
		${MAKE} exec;			\
	fi

exec: $(OBJS)
	@if [ x$(SUBTYPE) = xfull ] ; then	\
		${MAKE} bt-full;		\
	elif [ x$(SUBTYPE) = xFULL ] ; then	\
		${MAKE} bt-full;		\
	elif [ x$(SUBTYPE) = xsimple ] ; then	\
		${MAKE} bt-simple;		\
	elif [ x$(SUBTYPE) = xSIMPLE ] ; then	\
		${MAKE} bt-simple;		\
	elif [ x$(SUBTYPE) = xfortran ] ; then	\
		${MAKE} bt-fortran;		\
	elif [ x$(SUBTYPE) = xFORTRAN ] ; then	\
		${MAKE} bt-fortran;		\
	elif [ x$(SUBTYPE) = xepio ] ; then	\
		${MAKE} bt-epio;		\
	elif [ x$(SUBTYPE) = xEPIO ] ; then	\
		${MAKE} bt-epio;		\
	else					\
		${MAKE} bt-bt;			\
	fi

bt-bt: ${OBJS} btio.s
	${FLINK} ${FLINKFLAGS} -o ${PROGRAM} ${OBJS} btio.s ${FMPI_LIB}

bt-full: ${OBJS} full_mpiio.s btio_common.s
	${FLINK} ${FLINKFLAGS} -o ${PROGRAM}.mpi_io_full ${OBJS} btio_common.s full_mpiio.s ${FMPI_LIB}

bt-simple: ${OBJS} simple_mpiio.s btio_common.s
	${FLINK} ${FLINKFLAGS} -o ${PROGRAM}.mpi_io_simple ${OBJS} btio_common.s simple_mpiio.s ${FMPI_LIB}

bt-fortran: ${OBJS} fortran_io.s btio_common.s
	${FLINK} ${FLINKFLAGS} -o ${PROGRAM}.fortran_io ${OBJS} btio_common.s fortran_io.s ${FMPI_LIB}

bt-epio: ${OBJS} epio.s btio_common.s
	${FLINK} ${FLINKFLAGS} -o ${PROGRAM}.ep_io ${OBJS} btio_common.s epio.s ${FMPI_LIB}

.f.s:
	${FCOMPILE} $<

.c.s:
	${CCOMPILE} $<


bt.s:             bt.f  header.h npbparams.h  mpinpb.h
make_set.s:       make_set.f  header.h npbparams.h  mpinpb.h
initialize.s:     initialize.f  header.h npbparams.h
exact_solution.s: exact_solution.f  header.h npbparams.h
exact_rhs.s:      exact_rhs.f  header.h npbparams.h
set_constants.s:  set_constants.f  header.h npbparams.h
adi.s:            adi.f  header.h npbparams.h
define.s:         define.f  header.h npbparams.h
copy_faces.s:     copy_faces.f  header.h npbparams.h  mpinpb.h
rhs.s:            rhs.f  header.h npbparams.h
x_solve$(VEC).s:  x_solve$(VEC).f  header.h work_lhs$(VEC).h npbparams.h  mpinpb.h
y_solve$(VEC).s:  y_solve$(VEC).f  header.h work_lhs$(VEC).h npbparams.h  mpinpb.h
z_solve$(VEC).s:  z_solve$(VEC).f  header.h work_lhs$(VEC).h npbparams.h  mpinpb.h
solve_subs.s:     solve_subs.f  npbparams.h
add.s:            add.f  header.h npbparams.h
error.s:          error.f  header.h npbparams.h  mpinpb.h
verify.s:         verify.f  header.h npbparams.h  mpinpb.h
setup_mpi.s:      setup_mpi.f mpinpb.h npbparams.h 
btio.s:           btio.f  header.h npbparams.h
btio_common.s:    btio_common.f mpinpb.h npbparams.h 
fortran_io.s:     fortran_io.f mpinpb.h npbparams.h 
simple_mpiio.s:   simple_mpiio.f mpinpb.h npbparams.h 
full_mpiio.s:     full_mpiio.f mpinpb.h npbparams.h 
epio.s:           epio.f mpinpb.h npbparams.h 

clean:
	- rm -f *.o *.s *~ mputil*
	- rm -f  npbparams.h core
