This project is using R programming to generate transitional matrix for optimizing the driving route. The algorithm of Markovchain can be use to optimize the route system of UBER.

1.Data processing. 
 converted your data into the form shown in Inter.csv.

2.set work directory and reading data.
 •change the directory and data name according to your requirement

setwd("/Users/Desktop/free") ## set your work directory
dat <- read.csv("Inter.csv") ## the original data set

3. output data.
 transitionsimple(parameter1,parameter2)
	paramenter1 is the row number if data in inter.csv
	parameter2 is the directory of output datafile and the name of output file.

	eg. transitionsimple(1,"./east/east_1to2.csv")
 	The east1stto2nd transition matrix will output the file called east (you have 	to create this file under free )under current work directory
