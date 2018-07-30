#!/bin/bash

set -xe

if [ -z ${1+x} ]; then
  echo "usage: ${0} <num_of_measurements> <num_of_requests> <num_of_concurrent_clients> <endpoint> <type>";
  exit 0;
fi

REPS=$1
REQUESTS=$2
CLIENTS=$3
ENDPOINT=$4
TYPE=$5

# initialize results...
FILENAME="apache-results-multi.csv"
#echo "avg,tdev,max,stdev" >> "results/${FILENAME}"

for e in $(seq 1 $REPS); do
#    b=`./wrk2/wrk -t4 -c${CLIENTS} -d30s -R${REQUESTS} -L ${ENDPOINT}`
#    echo ${b}
#    b | awk '/Latency/ {print $2 "," $3 "," $4 "," $5}'
     t=`./wrk2/wrk -t4 -c${CLIENTS} -d30s -R${REQUESTS} -L ${ENDPOINT} \
 	    | awk '/Latency/ {print $2 "," $3 "," $4 "," $5}' \
 	    | grep %`
     echo "${TYPE},${REQUESTS},${CLIENTS},${t}" >> "results/${FILENAME}"
     echo "${e}/${REPS}"
done
