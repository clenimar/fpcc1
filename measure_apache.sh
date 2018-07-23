#!/bin/bash

if [ -z ${1+x} ]; then
  echo "usage: ${0} <num_of_measurements> <num_of_requests> <num_of_concurrent_clients>";
  exit 0;
fi

REPS=$1
REQUESTS=$2
CLIENTS=$3

# initialize results...
FILENAME="results_${REQUESTS}_sconesync_`date +"%s"`.csv"
echo "avg(ms);stdev(us);max(ms);stdev(%)" >> "results/${FILENAME}"

for e in $(seq 1 $REPS); do
    ./wrk2/wrk -t4 -c${CLIENTS} -d30s -R${REQUESTS} -L http://10.30.0.140:12346 \
	    | awk '/Latency/ {print $2 ";" $3 ";" $4 ";" $5}' \
	    | grep ms >> "results/${FILENAME}"
    echo "${e}/${REPS}"
done


