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

build_field.s : clover.s
initialise_chunk.s : initialise_chunk_kernel.s clover.s
initialise.s : clover.s report.s parse.s
flux_calc.s : clover.s flux_calc_kernel.s
advec_cell_driver.s : clover.s advec_cell_kernel.s
field_summary.s : ideal_gas.s clover.s field_summary_kernel.s
PdV.s : clover.s report.s ideal_gas.s revert.s update_halo.s PdV_kernel.s
parse.s : report.s clover.s data.s
start.s : ideal_gas.s parse.s clover.s update_halo.s
report.s : clover.s data.s
viscosity.s : clover.s viscosity_kernel.s
read_input.s : report.s clover.s parse.s
calc_dt.s : calc_dt_kernel.s clover.s
update_halo.s : update_halo_kernel.s clover.s
definitions.s : data.s
ideal_gas.s : clover.s ideal_gas_kernel.s
visit.s : update_halo.s clover.s viscosity.s ideal_gas.s
advec_mom_driver.s : advec_mom_kernel.s clover.s
generate_chunk.s : generate_chunk_kernel.s clover.s
accelerate.s : accelerate_kernel.s clover.s
clover.s : definitions.s pack_kernel.s data.s
clover_leaf.s : clover.s
hydro.s : accelerate.s timestep.s clover.s viscosity.s reset_field.s advection.s flux_calc.s PdV.s
revert.s : clover.s revert_kernel.s
reset_field.s : clover.s reset_field_kernel.s
advection.s : advec_cell_driver.s clover.s advec_mom_driver.s update_halo.s
timestep.s : update_halo.s definitions.s ideal_gas.s clover.s report.s viscosity.s calc_dt.s


%.s : %.c
	$(C_MPI_COMPILER) $(CFLAGS) -c $<

%.s : %.f90
	$(MPI_COMPILER) $(FLAGS) -c $<

binary: $(BCOS)
	$(LINKER) $(BCOS) -o clover_leaf

clean:
	rm -f *.s *.o *.mod *genmod* *cuda* *hmd* *.cu *.oo *.hmf *.lst *.cub *.ptx *.cl clover_leaf
