# Test of repeated reads from a filesystem

This code will generate a series of files across a range of sizes, and then
test the time to read each file into memory across multiple repeated reads.  On
a system with memory to spare and a page cache configured as expected,
subsequent reads will be much faster than the first read for a given file,
because Linux will supply the copy it already holds in RAM.  If that copy is
dropped from the cache (or never cached to begin with) there will be no speed
difference across repeated reads.  Make sure there is plenty of RAM to spare
and ideally not much other activity on the node for these numbers to make any
sense.

## See Also

 * [Experiments and fun with the Linux disk cache](https://www.linuxatemyram.com/play.html)
 * [vmtouch](https://hoytech.com/vmtouch/)
 * [IBM Spectrum Scale Wiki > Tuning Parameters](https://www.ibm.com/developerworks/community/wikis/home?lang=en#!/wiki/General%20Parallel%20File%20System%20%28GPFS%29/page/Tuning%20Parameters)
