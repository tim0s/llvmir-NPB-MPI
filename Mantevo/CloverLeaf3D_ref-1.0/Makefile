LLVM_PATH = /home/timos/Software/llvm33/llvm-3.3.src/build/bin/
DRAGONEGG_PATH = /home/timos/Software/dragonegg/dragonegg-3.3.src/dragonegg.so

FLAGS=-O2 
CFLAGS=-O2
MPI_COMPILER=mpif90 -fc=gfortran-4.6 -g -S -fplugin=${DRAGONEGG_PATH} -fplugin-arg-dragonegg-emit-ir 
C_MPI_COMPILER=mpicc -cc=gcc-4.6 -g -S -fplugin=${DRAGONEGG_PATH} -fplugin-arg-dragonegg-emit-ir
LINKER=${LLVM_PATH}/llvm-link

CSRC = $(wildcard *.c)
FSRC = $(wildcard *.f90)
COBJ = $(CSRC:.c=.o)
FOBJ = $(FSRC:.f90=.o)
OBJS = $(COBJ) $(FOBJ)
BCOS = $(OBJS:.o=.s)

# list of dependencies so that .mods get generated before they are used
all: binary

parse.s : report.s clover.s data.s
generate_chunk.s : generate_chunk_kernel.s clover.s
timestep.s : clover.s update_halo.s report.s ideal_gas.s calc_dt.s viscosity.s definitions.s
initialise_chunk.s : initialise_chunk_kernel.s clover.s
reset_field.s : clover.s reset_field_kernel.s
advection.s : advec_mom_driver.s advec_cell_driver.s update_halo.s clover.s
hydro.s : advection.s viscosity.s reset_field.s timestep.s accelerate.s clover.s flux_calc.s PdV.s
visit.s : viscosity.s ideal_gas.s clover.s update_halo.s
viscosity.s : viscosity_kernel.s clover.s
build_field.s : clover.s
accelerate.s : clover.s accelerate_kernel.s
update_halo.s : clover.s update_halo_kernel.s
start.s : build_field.s ideal_gas.s parse.s update_halo.s clover.s
clover.s : pack_kernel.s data.s definitions.s
initialise.s : report.s parse.s clover.s
calc_dt.s : calc_dt_kernel.s clover.s
advec_cell_driver.s : clover.s advec_cell_kernel.s
field_summary.s : ideal_gas.s field_summary_kernel.s clover.s
read_input.s : parse.s report.s clover.s
ideal_gas.s : clover.s ideal_gas_kernel.s
definitions.s : data.s
flux_calc.s : flux_calc_kernel.s clover.s
clover_leaf.s : clover.s
report.s : clover.s data.s
PdV.s : PdV_kernel.s clover.s update_halo.s report.s ideal_gas.s revert.s
advec_mom_driver.s : advec_mom_kernel.s clover.s
revert.s : clover.s revert_kernel.s


%.s : %.c
	$(C_MPI_COMPILER) $(CFLAGS) -c $<

%.s : %.f90
	$(MPI_COMPILER) $(FLAGS) -c $<

binary: $(BCOS)
	$(LINKER) $(BCOS) -o clover_leaf

clean:
	rm -f *.s *.o *.mod *genmod* *cuda* *hmd* *.cu *.oo *.hmf *.lst *.cub *.ptx *.cl clover_leaf
