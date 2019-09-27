##How to use R: some basics
##try sending the code below down to the console/commandline; highlight it and press ctr+enter, or click run
2+2
2*4

x <- 2
x
y<- x+x
y

x <- "Hello World"
x

##Vectors:  Vectors are a column of data, only one data type allowed (atomic)
x <- 1:10
x
class(x)
length(x)

y<-c("a","b", "c")
y
class(y)
length(y)

##Matrices: an atomic vector with dimensions: the number of rows and columns
m <- matrix(nrow = 2, ncol = 2)
m
dim(m)

m <- matrix(c(4, 4, 4, 4,3,2),  nrow = 2,  ncol = 3)
m
dim(m)

##Data frame: the most common data type for tabular data
dat <- data.frame(id = letters[1:10], x = 1:10, y = 11:20)
head(dat)

##load a data frame R already knows about, called "iris"
data(iris)
class(iris)
dim(iris)
names(iris)

head(iris)
tail(iris)
str(iris)
table(iris$Species)
summary(iris)
plot(iris)

##Subsetting vectors: Vectors are indexed with **[ ]**
##   the number is the item position, starting from the right
y<-c("a","b", "c")
y[1]
y[c(1,3)]
```

## a negative index will show all **but** that item
y<-c("a","b", "c")
y
y[-2]

## a conditional index will grab values that meet a criteria
x<-1:10
x
x==7
x[x<=7]
x[x==7]
x[x<7]
```
##the last item in a vector
length(x)
x[length(x)]


## Data frames and matrices are indexed by **row**, **column** inside [ ]
dat <- data.frame(id = letters[1:10], x = 1:10, y = 11:20)
head(dat)

#row 1, column 2
dat[1,2]
#first 5 rows, column 2
dat[1:5,2]

##all the rows, column2
dat[ ,2]

## You can also grab rows based on a condition
##rows where x >5, column3
dat[ dat$x>7, 2]

## What if I want all the rows in column 1 ("id") where x is greater than 8?
##rows where x >8, column 1
dat[dat$x>8, 1]

## selectively replace rows in y where x meets a criteria
##selectively replace rows where x >7 in  column3 with 100
dat[ dat$x>7, 3]<-100
tail(dat)


## Data frames can also be subset by column name, with $

dat <- data.frame(id = letters[1:10], x = 1:10, y = 11:20)
dat$y
dat[ , "y"]

##Combining data: Vectors
x <- 1:3
y<-c(5,6,7)
z<- c(x,y)
z

##Combining data: data frames and matrices
m <- matrix(c(4, 4, 4, 4),
  nrow = 2,
  ncol = 2)
m
y<-c(2,2)
m<-rbind(m,y)
m

##Combining data: data frames, add a new named column

dat <- data.frame(plot = letters[1:3], band1 = rnorm(n=3, mean=0.1, sd=0.05), band2 = rnorm(n=3, mean=0.2, sd=0.06))
head(dat)
z<-rnorm(n=3, mean=0.15, sd=0.03); z
dat$band3 <- z
head(dat)

## how do I create a new column as a mathmatic combo of other columns?

dat$sr<-(dat$band2)/(dat$band3)
head(dat)

##Combining data:  merge two data frames via a common column

dat <- data.frame(date = seq.Date(from=as.Date("2019-01-01"), 
                                  to=as.Date("2019-01-10"), by=2),  
                  x = 1:5, y = 11:15)
dat2<-data.frame(date = seq.Date(from=as.Date("2019-01-01"), 
                                 to=as.Date("2019-01-05"), by=1),  
                 z = seq(from=5, to=10, length.out=5))
head(dat)
head(dat2)
dat<-merge(dat, dat2, by="date", all.x=T, all.y=T)
head(dat)

##Plotting data
plot(iris$Sepal.Length[iris$Species=="setosa"], 
     iris$Sepal.Width[iris$Species=="setosa"], pch=19,
     xlab= "Sepal Length (mm)", ylab= "Sepal Width (mm)", col="red")
## add more points
points( iris$Sepal.Length[iris$Species=="versicolor"], pch=1,  
        iris$Sepal.Width[iris$Species=="versicolor"], col="blue")

##  how can we use **summary( )** to figure out what the axis limits should be?
summary(iris)

## adjust the plot
plot(iris$Sepal.Length[iris$Species=="setosa"], 
     iris$Sepal.Width[iris$Species=="setosa"],  pch=19,
     xlab= "Sepal Length (mm)", ylab= "Sepal Width (mm)", col="red",
     xlim=c(4.3,7.9), ylim=c(2,4.4))
points( iris$Sepal.Length[iris$Species=="versicolor"], pch=1,  
        iris$Sepal.Width[iris$Species=="versicolor"], col="blue")

## There's a third species. How can find out what it is and add it to the plot?
## Hint: try summary(iris), table(iris$Species), or levels(iris$Species)
plot(iris$Sepal.Length[iris$Species=="setosa"], 
     iris$Sepal.Width[iris$Species=="setosa"],  pch=19,
     xlab= "Sepal Length (mm)", ylab= "Sepal Width (mm)", col="red",
     xlim=c(4.3,7.9), ylim=c(2,4.4))
points( iris$Sepal.Length[iris$Species=="versicolor"], pch=1,  
        iris$Sepal.Width[iris$Species=="versicolor"], col="blue")

##Plotting data: add the third species
plot(iris$Sepal.Length[iris$Species=="setosa"], 
     iris$Sepal.Width[iris$Species=="setosa"],  pch=19,
     xlab= "Sepal Length (mm)", ylab= "Sepal Width (mm)", col="red",
     xlim=c(4.3,7.9), ylim=c(2,4.4))
points( iris$Sepal.Length[iris$Species=="versicolor"], pch=1,  
        iris$Sepal.Width[iris$Species=="versicolor"], col="blue")
points( iris$Sepal.Length[iris$Species=="virginica"], pch=3,  
        iris$Sepal.Width[iris$Species=="virginica"], col="green")


