# Our files of specific sizes filled with zeros
STEP := 128
STOP := 2048
DUMMY_FILES := $(shell seq ${STEP} ${STEP} ${STOP})

sweep.log: $(DUMMY_FILES)
	bash sweep_read_sizes.sh > $@

${DUMMY_FILES}:
	dd if=/dev/zero of=$@ bs=1M count=$@

clean:
	rm -f $(DUMMY_FILES)
	rm -f sweep.log
