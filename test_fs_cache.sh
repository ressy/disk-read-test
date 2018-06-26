#!/usr/bin/env bash

# A different approach, using dd's "direct" flag.  This isn't a clear-cut proof
# like the other one but I'm keeping it in case it's a useful reference.

DATA=$1
LEN=$2
function dd_direct {
	dd if=$DATA bs=1M count=$LEN iflag=direct of=/dev/null 2>&1
}

function dd_regular {
	dd if=$DATA bs=1M count=$LEN of=/dev/null 2>&1
}

function mem_num {
	grep ^$1: /proc/meminfo | grep -o '[0-9]*'
}

function main {
	NMAX=15
	SWITCHEVERY=4
	for i in $(seq 0 $NMAX); do
		#mem_total=$(mem_num MemTotal)
		#mem_free=$(mem_num MemFree)
		mem_cached=$(mem_num Cached)
		if [ $(((i/SWITCHEVERY)%2)) -eq 0 ]; then
			mode="direct"
			timing=$(dd_direct)
		else
			mode="regular"
			timing=$(dd_regular)
		fi
		seconds=$(echo "$timing" | grep copied | sed -r 's/^.*copied, ([0-9.]+) s.*$/\1/')
		echo -e "$i\t$mode\t$seconds\t$mem_cached"
	done
}

main $@
