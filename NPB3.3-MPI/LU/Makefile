SHELL=/bin/sh
BENCHMARK=lu
BENCHMARKU=LU
VEC=

include ../config/make.def

OBJS = lu.s init_comm.s read_input.s bcast_inputs.s proc_grid.s neighbors.s \
       nodedim.s subdomain.s setcoeff.s sethyper.s setbv.s exact.s setiv.s \
       erhs.s ssor.s exchange_1.s exchange_3.s exchange_4.s exchange_5.s \
       exchange_6.s rhs.s l2norm.s jacld.s blts$(VEC).s jacu.s buts$(VEC).s \
       error.s pintgr.s verify.s ${COMMON}/print_results.s ${COMMON}/timers.s

include ../sys/make.common


# npbparams.h is included by applu.incl
# The following rule should do the trick but many make programs (not gmake)
# will do the wrong thing and rebuild the world every time (because the
# mod time on header.h is not changed. One solution would be to 
# touch header.h but this might cause confusion if someone has
# accidentally deleted it. Instead, make the dependency on npbparams.h
# explicit in all the lines below (even though dependence is indirect). 

# applu.incl: npbparams.h

${PROGRAM}: config
	@if [ x$(VERSION) = xvec ] ; then	\
		${MAKE} VEC=_vec exec;		\
	elif [ x$(VERSION) = xVEC ] ; then	\
		${MAKE} VEC=_vec exec;		\
	else					\
		${MAKE} exec;			\
	fi

exec: $(OBJS)
	${FLINK} ${FLINKFLAGS} -o ${PROGRAM} ${OBJS} ${FMPI_LIB}

.f.s :
	${FCOMPILE} $<

lu.s:		lu.f applu.incl npbparams.h
bcast_inputs.s:	bcast_inputs.f applu.incl npbparams.h mpinpb.h
blts$(VEC).s:	blts$(VEC).f
buts$(VEC).s:	buts$(VEC).f
erhs.s:		erhs.f applu.incl npbparams.h
error.s:	error.f applu.incl npbparams.h mpinpb.h
exact.s:	exact.f applu.incl npbparams.h
exchange_1.s:	exchange_1.f applu.incl npbparams.h mpinpb.h
exchange_3.s:	exchange_3.f applu.incl npbparams.h mpinpb.h
exchange_4.s:	exchange_4.f applu.incl npbparams.h mpinpb.h
exchange_5.s:	exchange_5.f applu.incl npbparams.h mpinpb.h
exchange_6.s:	exchange_6.f applu.incl npbparams.h mpinpb.h
init_comm.s:	init_comm.f applu.incl npbparams.h mpinpb.h 
jacld.s:	jacld.f applu.incl npbparams.h
jacu.s:		jacu.f applu.incl npbparams.h
l2norm.s:	l2norm.f mpinpb.h
neighbors.s:	neighbors.f applu.incl npbparams.h
nodedim.s:	nodedim.f
pintgr.s:	pintgr.f applu.incl npbparams.h mpinpb.h
proc_grid.s:	proc_grid.f applu.incl npbparams.h
read_input.s:	read_input.f applu.incl npbparams.h mpinpb.h
rhs.s:		rhs.f applu.incl npbparams.h
setbv.s:	setbv.f applu.incl npbparams.h
setiv.s:	setiv.f applu.incl npbparams.h
setcoeff.s:	setcoeff.f applu.incl npbparams.h
sethyper.s:	sethyper.f applu.incl npbparams.h
ssor.s:		ssor.f applu.incl npbparams.h mpinpb.h
subdomain.s:	subdomain.f applu.incl npbparams.h mpinpb.h
verify.s:	verify.f applu.incl npbparams.h

clean:
	- /bin/rm -f npbparams.h
	- /bin/rm -f *.s *.o *~
