The folder contains a Random Forest (RF.R) machine learning algorithm to detect meiotic double-strand break (DSB) and crossover (CO) sites in plants as well as raw and normalized datasets from maize and Arabidopsis used for algorithm training. Additionally, logistic regression (LR.R) and decision tree (Decision_tree.R) are also included to estimate model performance. pca_plot.R was used for plotting first two principal components and cross_region.R was for testing model robust by predicting independant desert regions and calculating their accuracy.


The raw dataset includes DSB/CO site locations and location features. Class column: 1 represents recombination (DSB or CO) site;  0 represents recombination coldspot site.

The normalized function transforms data into the range of 	0 to 1
norm<-function (x) {
   x<-(x-min(x))/(max(x)-min(x))
}

