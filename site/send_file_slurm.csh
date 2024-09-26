#!/bin/csh -fv
########################################################################
# generic run script for sending files /$PBS_JOBID_send_data.er
########################################################################
#SBATCH --job-name=Send_file
#SBATCH --output=%x.o%j
#SBATCH --time=16:00:00
#SBATCH --partition=rdtn_c5
#SBATCH --cluster=es
#SBATCH --account=gfdl_w
####SBATCH --account=bil-coastal-gfdl
#SBATCH --ntasks=1
#SBATCH --export=NONE

#################################################################
# set environment
#################################################################

  mkdir -p ~/STDOUT
  
  set echo

  echo "test!"
  #setenv siteConfig /autofs/mnt/ncrc-svm1_home1/Jan-Huey.Chen/Util/env_c3.cshrc
  #if ( -f $siteConfig ) source $siteConfig
  source $MODULESHOME/init/tcsh
  module load gcp
  echo "test2!"

########################################################################
# determine extension of file to be sent 
########################################################################

  if ( $extension == tar ) then
    cd $source
    if ( $type == restart ) then
      find -iname '*res*' > file.list.txt
      find -iname '*data*' >> file.list.txt
    else
      find -iname '*.nc*' > file.list.txt
    endif
    set files = `wc -l file.list.txt | awk '{print $1}'`

    if ( $files > 0 ) then
      tar -b 1000 -cf $source:t.tar --files-from file.list.txt
      if ( $type == history ) then
        mv $source:t.tar ../$source:t.nc.tar
      else
        mv $source:t.tar ../$source:t.tar
      endif
      rm file.list.txt
    else
       echo "NOTE: End-of-script for send_file for $source and $destination"
    endif

    if ( $type == history ) then
      set source_name      = $source.nc.tar
    else
      set source_name      = $source.tar
    endif
    set destination_name = $destination:h/
  else
    set source_name      = $source
    set destination_name = $destination
  endif

  #set staged_name = `echo $source_name | sed "s/lustre\/fs\/scratch/lustre\/ltfs\/stage/g"`
  set staged_name = $source_name 

########################################################################
# send the data from $source_name to $destination
########################################################################

  echo "source file      = " $source_name
  echo "staged file      = " $staged_name
  echo "destination file = " $destination_name

  if ( ! -d $staged_name:h ) mkdir -p $staged_name:h
#  gcp -v -cd ${source_name} ${staged_name}
  cd $staged_name:h
#  gcp -v -cd ${staged_name} ${tag}${destination_name}
  gcp -v -cd ${staged_name} ${destination_name}

#  gcp -v -cd $source_name $destination_name

  if ( $status == 0 ) then
    if ( $extension == tar ) then
    rm $staged_name
      if ( $source:e != tar ) then
        rm $source_name
        echo "NOTE: Natural end-of-script for send_file for $source and $destination"
      endif
    endif
  endif

  exit


