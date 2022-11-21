The folders included the raw data and normalized data of trainning data from maize and arabidopsis
The raw data has the detail location and features information, while normaized data has been removed chromosome and coordinates infornation.
The class column: 1 represnts CO/DSB  0 resents coldspots site
The normalzied function makes all data in the range -1 to 1
norm<-function (x) {
   x<-(x-min(x))/(max(x)-min(x))
}
