SHELL=/bin/sh
BENCHMARK=sp
BENCHMARKU=SP

include ../config/make.def


OBJS = sp.s make_set.s initialize.s exact_solution.s exact_rhs.s \
       set_constants.s adi.s define.s copy_faces.s rhs.s      \
       lhsx.s lhsy.s lhsz.s x_solve.s ninvr.s y_solve.s pinvr.s    \
       z_solve.s tzetar.s add.s txinvr.s error.s verify.s setup_mpi.s \
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

${PROGRAM}: config ${OBJS}
	${FLINK} ${FLINKFLAGS} -o ${PROGRAM} ${OBJS} ${FMPI_LIB}

.f.s:
	${FCOMPILE} $<

sp.s:             sp.f  header.h npbparams.h  mpinpb.h
make_set.s:       make_set.f  header.h npbparams.h  mpinpb.h
initialize.s:     initialize.f  header.h npbparams.h
exact_solution.s: exact_solution.f  header.h npbparams.h
exact_rhs.s:      exact_rhs.f  header.h npbparams.h
set_constants.s:  set_constants.f  header.h npbparams.h
adi.s:            adi.f  header.h npbparams.h
define.s:         define.f  header.h npbparams.h
copy_faces.s:     copy_faces.f  header.h npbparams.h  mpinpb.h
rhs.s:            rhs.f  header.h npbparams.h
lhsx.s:           lhsx.f  header.h npbparams.h
lhsy.s:           lhsy.f  header.h npbparams.h
lhsz.s:           lhsz.f  header.h npbparams.h
x_solve.s:        x_solve.f  header.h npbparams.h  mpinpb.h
ninvr.s:          ninvr.f  header.h npbparams.h
y_solve.s:        y_solve.f  header.h npbparams.h  mpinpb.h
pinvr.s:          pinvr.f  header.h npbparams.h
z_solve.s:        z_solve.f  header.h npbparams.h  mpinpb.h
tzetar.s:         tzetar.f  header.h npbparams.h
add.s:            add.f  header.h npbparams.h
txinvr.s:         txinvr.f  header.h npbparams.h
error.s:          error.f  header.h npbparams.h  mpinpb.h
verify.s:         verify.f  header.h npbparams.h  mpinpb.h
setup_mpi.s:      setup_mpi.f mpinpb.h npbparams.h 


clean:
	- rm -f *.s *.o *~ mputil*
	- rm -f npbparams.h core
