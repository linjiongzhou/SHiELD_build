#!/bin/sh


if [ `hostname | cut -c1-4` = "gaea" ] || [ `hostname | cut -c1-3` = "nid" ] ; then
   echo " gaea environment "

   . ${MODULESHOME}/init/sh
   module unload PrgEnv-pgi
   module load   PrgEnv-intel
   module rm intel
   #module load intel/19.0.5.281
   module load intel/18.0.6.288
   module load cray-netcdf
   module load craype-hugepages4M

   # make your compiler selections here
   export FC=ftn
   export CC=cc
   export CXX=CC
   export LD=ftn
   export TEMPLATE=site/intel.mk
   export LAUNCHER=srun

   # highest level of AVX support
   export AVX_LEVEL=-xCORE-AVX2


elif [ `hostname | cut -c1-5` = "Orion" ] ; then
   echo " Orion environment "

   . ${MODULESHOME}/init/sh
   module load intel/2020
   module load impi/2020
   module load netcdf
   module load hdf5

   export CPATH="${NETCDF}/include:${CPATH}"
   export HDF5=${HDF5_ROOT}
   export LIBRARY_PATH="${LIBRARY_PATH}:${NETCDF}/lib:${HDF5}/lib"
   export NETCDF_DIR=${NETCDF}

   # make your compiler selections here
   export FC=mpiifort
   export CC=mpiicc
   export CXX=mpicpc
   export LD=mpiifort
   export TEMPLATE=site/intel.mk
   export LAUNCHER=srun

   # highest level of AVX support
   export AVX_LEVEL=-xSKYLAKE-AVX512


elif [ `hostname | cut -c1-2` = "fe" ] || [ `hostname | cut -c1` = "x" ] ; then
   echo " jet environment "

   . ${MODULESHOME}/init/sh
   module purge
   module load newdefaults
   module load intel/2016.2.181 # Jet's default is 15.0.3.187, but this one is 16.0.2.181
   module load szip/2.1
   module load hdf5/1.8.9
   module load netcdf4/4.2.1.1
   module load mvapich2/2.1

   export LIBRARY_PATH="${LIBRARY_PATH}:${NETCDF4}/lib:${HDF5}/lib"
   export NETCDF_DIR=${NETCDF4}

   # make your compiler selections here
   export FC=mpiifort
   export CC=mpiicc
   export CXX=mpicpc
   export LD=mpiifort
   export TEMPLATE=site/intel.mk
   export LAUNCHER=srun


elif [ `hostname | cut -c1` = "h" ] ; then
   echo " hera environment "

   source $MODULESHOME/init/sh
   module load intel/15.1.133
   module load netcdf/4.3.0
   module load hdf5/1.8.14

   export LIBRARY_PATH="${LIBRARY_PATH}:${NETCDF}/lib:${HDF5}/lib"
   export NETCDF_DIR=${NETCDF}

   # make your compiler selections here
   export FC=mpiifort
   export CC=mpiicc
   export CXX=mpicpc
   export LD=mpiifort
   export TEMPLATE=site/intel.mk
   export LAUNCHER=srun

   # highest level of AVX support
   export AVX_LEVEL=-xSKYLAKE-AVX512

elif [ `hostname | cut -c1-3` = "lsc" ] ; then
   echo " lsc environment "

   source $MODULESHOME/init/sh
   module load oneapi/2022.1
   module load compiler/2022.0.1
   module load mpi/2021.5.0
   module load netcdf/4.8.0
   module load hdf5/1.12.0

   export CPATH="${NETCDF_ROOT}/include:${CPATH}"
   export NETCDF_DIR=${NETCDF_ROOT}

   # make your compiler selections here
   export FC=mpiifort
   export CC=mpiicc
   export CXX=mpicpc
   export LD=mpiifort
   export TEMPLATE=site/intel.mk
   export LAUNCHER=mpirun

   # highest level of AVX support
   if [ `hsostname | cut -c4-6` = "amd" ] ; then
     export AVX_LEVEL=-march=core-avx2
   else
     export AVX_LEVEL=-xSKYLAKE-AVX512
   fi

else

   echo " no environment available based on the hostname "

fi

