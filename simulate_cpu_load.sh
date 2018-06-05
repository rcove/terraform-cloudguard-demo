#!/bin/bash
# This shell script will load the CPUs CP sk112575 
ncores="$(cat /proc/cpuinfo | grep vendor_id | wc -l)"
PIDS=()
for i in $(seq $ncores)
  do
    taskset ff dd if=/dev/zero of=/dev/null &
    PIDS+=($!)
  done
echo "Load started"
read -n1 -r -p "Press any key to stop the load..." key
kill ${PIDS[@]}