# SHiELD_build

This run/build environment is for use with the SHiELD code base and is
an update to the original fvGFS build system.


# Description

Everything needed to build th SHiELD model on a given platform has been included.
Supported platforms:
  * Gaea
  * Orion
  * Hera
  * Jet (untested)

The build system builds the FMS library once and will use it for all subsequent
builds.


# Caveats

There are special handling instructions in BUILD/mk_scritps/mk_makefile for
the following files:
  * GFS_diagnostics
     - compiles at -O0 to improve compilation speed
  * radiation_aerosols.f
     - reduced to CORE-AVX-I to ensure reproducibility
     - may no longer be needed (is it fixed in newer versions of Intel??)
  * nh_utils.F90
     - adds --fast-transcendentals for performance
  * fv_mapz.F90
     - adds --fast-transcendentals for performance


# Instructions

Process for building SHiELD

1. Modify/run CHECKOUT_code
   * tags/branches from GitHub and GitLab
2. Ensure the platform you are using is supported in site/environment.sh
   * update modules
   * update compiler selections
   * update AVX support
3. Ensure you have the mkmf submodule
   * git submodule update --init
   * git submodule update --remote mkmf
4. In the Build directory, execute either
   * COMP_dev [clean]
     - builds a specific configuation
     - allows for recursive use when omitting argument
   * COMP_all
     - creates executables for a set of configurations
     - always performs a clean compile


# Disclaimer

This project is provided on an "as is" basis and the user assumes responsibility
for its use. Any claims against the Department of Commerce stemming from the
use of this project will be governed by all applicable Federal law. Any reference to
specific commercial products, processes, or services by service mark, trademark,
manufacturer, or otherwise, does not constitute or imply their endorsement,
recommendation or favoring by the Department of Commerce.

This project code is made available through GitLab and is managed
at https://gitlab.gfdl.noaa.gov
