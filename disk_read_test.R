# Setup -------------------------------------------------------------------


read_sweep_log <- function(fp) {
  sweep <- read.table(fp, sep = "\t", header = FALSE)
  colnames(sweep) <- c("Size", "Duration")
  # Read speed in Mbps
  sweep$Speed <- sweep$Size * 8 / sweep$Duration
  sweep
}

plot_sweep <- function(sweep, ...) {
  plot(sweep$Speed,
       ylab = "Read speed (Mbps)",
       xlab = "File Size (MB)",
       main = "File read speed versus total size, eight repeats per file",
       xaxt = 'n',
       pch = 19,
       cex = 0.7,
       ...
  )
  firsts <- match(unique(sweep$Size), sweep$Size)
  abline(v = firsts, lwd=1, col="#00000011")
  abline(v = match(1024, sweep$Size), lwd=3, col="#00000044")
  points(firsts, sweep$Speed[firsts], pch=19, col="red")
  axis(side = 1, at = firsts, labels = sweep$Size[firsts])
  
  #text(x = 60, y = mean(sweep$Speed), labels = '1 GB', adj = 0.2)
  
  legend(x = "topright",
         legend = c("First Read", "Subsequent Reads"),
         pch = 19,
         col = c("red", "black"))
}


# Run ---------------------------------------------------------------------


sweep <- read_sweep_log("sweep.log")
png(filename = "sweep.png",
    width = 1600,
    height = 1200,
    res = 150)
plot_sweep(sweep)
dev.off()
