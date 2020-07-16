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
2. Ensure the platform you are using is supported in *site/environment.sh*
   * update modules
   * update compiler selections
   * update AVX support
3. Ensure you have the mkmf submodule
   * downloads version of mkmf pointed to by the project
     - *git submodule update --init mkmf*
   * update mkmf to the latest version
     - *git submodule update --remote mkmf*
4. In the Build directory, execute either
   * COMP_dev [clean]
     - builds a specific configuation
     - allows for recursive use when omitting argument
   * COMP_all
     - creates executables for a set of configurations
     - always performs a clean compile
5. Ensure you have your latest runscrips and/or those of others
   * download a particular user's runscripts
     - *git submodule update --init Users/\<name\>_runscripts*
   * update the runscript submodule to the latest version
     - *git submodule update --remote Users/\<name\>_runscripts*


# Adding your own runscripts as a submodule

1. Create your runscript repository
   * create a directory for the runscripts
     - *mkdir \<name\>_runscripts*
   * populate the directory with whatever directory structure works for you
     - *cp -r (everything you want) \<name\>_runscripts/.*
   * initialize the git repository
     - *git init*
   * perform your first commit
     - *git add .*
     - *git commit -m "initial commit"*
   * add your origin branch
     - *git remote add origin https://gitlab.gfdl.noaa.gov/<First.Last\>/<name\>_runscripts.git*
   * push your first commit to the gitlab server
     - *git push --set-upstream origin master*
2. Add your runscript repository as a submodule to SHiELD_build
   * create a fork of the SHiELD_build repository
     - open *https://gitlab.gfdl.noaa.gov/fv3team/SHiELD_build*
     - click on 'fork' button near top right of the project
     - place the fork in your personal space (First.Last)
   * check out your fork
     - *git clone -b master https://gitlab.gfdl.noaa.gov/<First.Last\>/SHiELD_build.git*
   * change directory to the User space for repositories
     - *cd SHiELD_build/Users*
   * add your runscript repository as a submodule
     - *git submodule add https://gitlab.gfdl.noaa.gov/<First.Last\>/\<name\>_runscripts*
   * save and commit your changes
     - *git commit -am "added \<name\>_runscripts as a submodule"*
   * push your changes back to your fork on gitlab
     - *git push origin master*
3. Create a pull request back to the fv3team repository
   * open *https://gitlab.gfdl.noaa.gov/<First.Last\>/SHiELD_build*
   * select *Merge Requests" in the left-hand side panel
   * follow directions to finalize creation of the merge request
 

# Disclaimer

This project is provided on an "as is" basis and the user assumes responsibility
for its use. Any claims against the Department of Commerce stemming from the
use of this project will be governed by all applicable Federal law. Any reference to
specific commercial products, processes, or services by service mark, trademark,
manufacturer, or otherwise, does not constitute or imply their endorsement,
recommendation or favoring by the Department of Commerce.

This project code is made available through GitLab and is managed
at https://gitlab.gfdl.noaa.gov
