##  Functions: an example function

half.it<- function(x) {
  y<-x/2
  return(y)

myvector<-1:10
myvector
new.vect<-half.it(myvector)
new.vect

##Functions: Explore some known functions
?seq.Date
seq.Date

##Functions: arguments
?data.frame

##Functions: arguments with defaults will be set for you if you don't change them
## data.frame will default to setting characters as factors
dat<-data.frame(id=c("a","b", "c"), x=1:3)
str(dat)
dat
unclass(dat$id)

##Factors: A quick warning
## factors are useful in some situations, but are often interpreted by functions as the underying integers
dat$id<-ifelse(dat$id=="a","z",dat$id)
dat
dat<-data.frame(id=letters[1:3], x=1:3)
dat$id<-ifelse(dat$id=="a","z",as.character(dat$id))
dat

##Functions: Arguments
## arguments with defaults will be set for you if you don't change them
## can change the encoding of the data frame by setting the stringsAsFactors argument yourself
dat2<-data.frame(id=c("a","b", "c"), x=1:3, stringsAsFactors=F)
str(dat2)
dat2$id<-ifelse(dat2$id=="a","z",dat2$id)
dat2

half.it

##Functions: You can make your own functions as complicated as you like

calc_index_l8<-function(dat.frame){
  ##This function assumes it is supplied with a data frame
  ##This function needs a data frame with Landsat 8 bands as columns
  ##The data frame should have the column names b1 for band1, etc.
  ##The function will return NDVI, a Simple Ratio, and SAVI
  
  ndvi<-(dat.frame$b5-dat.frame$b4)/(dat.frame$b5+dat.frame$b4) 
  indices<-data.frame(ndvi=ndvi)
  indices$sr<-(dat.frame$b5/dat.frame$b4)
  indices$savi <- 1.5*(dat.frame$b5-dat.frame$b4) /
    (dat.frame$b5+dat.frame$b4+0.5)
  return(indices)
}

#Functions: R practice on your own
# With the last example as a code recipe, define a function that calculates vegetation indices from the super GER
# Use the bands for the veg indices you identified in lab 1
# How can you add these indices as columns in your data? (see the combining data slides or cheatsheet)
# try this later as practice on your own



## Control Stuctures: for
x<-letters[1:3]
x
for(i in 1:length(x)){
  print(paste("this one was", x[i]))
}

##Control Stuctures: can use for loops to collect a result

## a loop to collect a new result
x<-1:10

##intialize a result vector
result<-0
for(i in 1:length(x)){
  result[i]<- x[i]*x[i]
  print(paste("i is", i, "and result[i] is", result[i]))
}
result

##For loop: practice
##  see if you can plot the iris data with different colors by species via a for loop
colors<-c("red", "blue", "green")
x<-unique(iris$Species)
plot(iris$Sepal.Length[iris$Species=="setosa"], 
     iris$Sepal.Width[iris$Species=="setosa"], 
     xlab= "Sepal Length (mm)", ylab= "Sepal Width (mm)", 
     pch=19, col=colors[1])

for( i in ??){
  
  points(    some code here that plots points for the other species  )
}

## hint: replace ?? with a sequence, 
## hint: for the points code, start with the code for adding points for one species 
## you can also use the x vector we created in the first code chunk to index the species; to see this, try x[1]



##tidyverse: dplyr for data manipulation
library(dplyr)
filter(iris, Species=="setosa")



##tidyverse:  several function-verbs can be joined together with the pipe symbol  %>% 
##   Note the new data structure, tibble; this is the tidyverse version of a data frame

names(iris)
iris %>% filter(Sepal.Width<3.3) %>% group_by(Species) %>% summarise(Sep.Len=mean(Sepal.Length))

##tidyverse: practice
## see if you can add another column summarising other variables inside summarise()
## can you summarise with other functions besides mean() (ex:sd(), sum(), +, / )
## what if you change the filter step? what happens?
## use the code below to get started

iris %>% filter(Sepal.Width<3.3) %>% group_by(Species) %>% 
  summarise(Sep.Len=mean(Sepal.Length),
            var.name= 
  )



