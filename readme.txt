The folder contains a Random Forest machine learning algorithm to detect meiotic double-strand break (DSB) and crossover (CO) sites in plants as well as raw and normalized datasets from maize and Arabidopsis used for algorithm training. Additionally, the logistic regression (LR.R) and decision_tree.R are also included.

The raw dataset includes DSB/CO site locations and location features. Class column: 1 represents recombination (DSB or CO) site;  0 represents recombination coldspot site.

The normalized function transforms data into the range of 	0 to 1
norm<-function (x) {
   x<-(x-min(x))/(max(x)-min(x))
}

