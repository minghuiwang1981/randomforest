The folder contains a Random Forest machine learning algorithm to detect meiotic double-strand break (DSB) and crossover (CO) sites in plants as well as raw and normalized datasets from maize and Arabidopsis used for algorithm training.

The raw dataset includes DSB/CO site locations and location features. Class column: 1 represents recombination (DSB or CO) site;  0 represents recombination coldspot site.

The normalized function transforms data into the range of 	-1 to 1
norm<-function (x) {
   x<-(x-min(x))/(max(x)-min(x))
}

