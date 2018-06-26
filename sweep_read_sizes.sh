#!/usr/bin/env bash

function get_timing {
	grep copied | sed -r 's/^.*copied, ([0-9.]+) s.*$/\1/'
}

function dd_null {
	dd if=$1 of=/dev/null bs=1M count=$1
}

# In MB
STEP=128
MAX=2048 
TIMES=8
for mbytes in $(seq $STEP $STEP $MAX); do
	for rep in {1..8}; do
		seconds=$(dd_null $mbytes 2>&1 | get_timing)
		echo -e "$mbytes\t$seconds"
	done
done
