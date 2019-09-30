An Introduction to data manipulation in R
============================
transition: none
css: custom.css
autosize: true

Jessica L. O'Connell

Download/Install materials from **https://github.com/jloconnell/Intro_to_R**

Learning Objectives
==============
* why program/ why use R
* how to use R
* code recipes

Learning Objectives
==============
* **why program/ why use R**
* how to use R
* code recipes

Why program?
==========
* get more done in less time and with less pain
* a record of your data steps
* extensible, learn over time
* repeatable
* open source: puts the knowledge of the science community at your finger tips
* creative: if you can imagine it, you can probably program it

Which programming language?
============
* The one your colleagues already use
* An open source language (not MatLab)
  - “free as in beer”: 
     + it costs nothing
  - “free as in speech”: 
     + the right to see how the software works
     + the right to redistribute and improve/contribute
* We'll learn R today, but it's similar to other programming languages (Python, JavaScript)

Why R?
============
* It's a fully-featured programming language with rich statistics functions
* It's open-source
* It has many geospatial and machine learning libraries
 - "Yes, there's an R package for that"

Programming has a learning curve
============
* slow to create the first script
* fast to use the script to repeat the steps
* our goal is to learn:
  - some programming basics
  - create some code recipes
* you won't learn everything now

More resources
===============
* Cran: https://cran.r-project.org/manuals.html
* Swirl: R package that teaches R basics through easy interactive learning
* Software Carpentry: https://swcarpentry.github.io/r-novice-inflammation/
* Data Carpentry: https://datacarpentry.org/R-ecology-lesson/index.html
* Hadley Wickham, R for Data Science: https://r4ds.had.co.nz/

Learning Objectives
==============
* why program/ why use R
* **how to use R**
* code recipes

Object-oriented programming basics
==============
* data are stored as objects
* data has types and structures
* functions: a set of steps to apply to data
* data can be read in from disk, manipulated via functions, and written out to disk
* plotting: data can be visualized, plots can be saved to disk
* for loops: quick repeating of steps
* scripts: a text file of computer instructions/ data steps

How to use R: some basics
======================
* R is a calculator


```r
2+2
```

```
[1] 4
```

```r
2*4
```

```
[1] 8
```

```r
2^3
```

```
[1] 8
```

* Practice: can you use the symbols below?
       
       /  *  +   - 
       
       sqrt(4) , sum( 2, 4 ) , mean( 2,4 )

How to use R: some basics
======================
* R is object-oriented
* tip: press Alt - (or Option - on Mac) to auto-insert **<-**

```r
x <- 2
x
```

```
[1] 2
```

```r
y<- x+x
y
```

```
[1] 4
```

```r
y<- sum(x,x,x)
y
```

```
[1] 6
```

How to use R: some basics
======================
* R can also handle text and character data


```r
x <- "Hello World"
x
```

```
[1] "Hello World"
```

R data types: the type of variable
======================
* character (text)
* numeric (real or decimal)
* integer (whole numbers)
* logical (TRUE/FALSE)
* dates/times
* factors (special type of ordered character data)
* some others

R data structures: the type of object
======================
- Vectors
- Matrices
- Data frames
- Some others


Vectors
======================
*  Vectors are a column of data, only one data type allowed (atomic)


```r
x <- 1:10
x
```

```
 [1]  1  2  3  4  5  6  7  8  9 10
```

```r
class(x)
```

```
[1] "integer"
```

```r
length(x)
```

```
[1] 10
```

Vectors
======================
*  Vectors are a column of data, only one data type allowed (atomic)


```r
y<-c("a","b", "c")
y
```

```
[1] "a" "b" "c"
```

```r
class(y)
```

```
[1] "character"
```

```r
length(y)
```

```
[1] 3
```

* Practice: use the examples to create a vector of numeric or logical data

Matrices
======================
* Matrix: an atomic vector with dimensions: the number of rows and columns
 + still atomic (only one data type allowed)


```r
m <- matrix(nrow = 2, ncol = 2)

##note: NA is the data type for missing data
m
```

```
     [,1] [,2]
[1,]   NA   NA
[2,]   NA   NA
```

```r
class(m)
```

```
[1] "matrix"
```

```r
##what are the dimensions (rows, colunns)?
dim(m)
```

```
[1] 2 2
```

* Why did the code above create a matrix of missing data?

Matrices
======================
* Matrix: an atomic vector with dimensions: the number of rows and columns
 + still atomic (only one data type allowed)


```r
m <- matrix(c(4, 4, 4, 4,3,2),  nrow = 2,  ncol = 3)
m
```

```
     [,1] [,2] [,3]
[1,]    4    4    3
[2,]    4    4    2
```

```r
dim(m)
```

```
[1] 2 3
```

* Practice: use the examples to create a matrix filled with character data


Data frame
======================
* Data frame: the most common data type for tabular data
 + each column is atomic, but different columns can have different data types
 + each column has the same number of observations (rows)
 + each column has it's own name


```r
dat <- data.frame(id = letters[1:10], x = 1:10, y = 11:20)

##see the top few rows
head(dat)
```

```
  id x  y
1  a 1 11
2  b 2 12
3  c 3 13
4  d 4 14
5  e 5 15
6  f 6 16
```

```r
## see some summary info
class(dat)
```

```
[1] "data.frame"
```

```r
dim(dat)
```

```
[1] 10  3
```

Data frame
======================
* see the data type, and dimensions (rows, columns), and the column names


```r
data(iris)
class(iris)
```

```
[1] "data.frame"
```

```r
dim(iris)
```

```
[1] 150   5
```

```r
names(iris)
```

```
[1] "Sepal.Length" "Sepal.Width"  "Petal.Length" "Petal.Width" 
[5] "Species"     
```

* Practice: use **head(** iris **)** to see which species is in the first few rows
* What do you guess the function to see the last few rows is?


Data frame
======================
* the first few rows with **head( )** and and the last few with **tail( )**


```r
head(iris)
```

```
  Sepal.Length Sepal.Width Petal.Length Petal.Width Species
1          5.1         3.5          1.4         0.2  setosa
2          4.9         3.0          1.4         0.2  setosa
3          4.7         3.2          1.3         0.2  setosa
4          4.6         3.1          1.5         0.2  setosa
5          5.0         3.6          1.4         0.2  setosa
6          5.4         3.9          1.7         0.4  setosa
```

```r
tail(iris)
```

```
    Sepal.Length Sepal.Width Petal.Length Petal.Width   Species
145          6.7         3.3          5.7         2.5 virginica
146          6.7         3.0          5.2         2.3 virginica
147          6.3         2.5          5.0         1.9 virginica
148          6.5         3.0          5.2         2.0 virginica
149          6.2         3.4          5.4         2.3 virginica
150          5.9         3.0          5.1         1.8 virginica
```


Data frame
======================
* see the structure of all the data with **str( )**


```r
str(iris)
```

```
'data.frame':	150 obs. of  5 variables:
 $ Sepal.Length: num  5.1 4.9 4.7 4.6 5 5.4 4.6 5 4.4 4.9 ...
 $ Sepal.Width : num  3.5 3 3.2 3.1 3.6 3.9 3.4 3.4 2.9 3.1 ...
 $ Petal.Length: num  1.4 1.4 1.3 1.5 1.4 1.7 1.4 1.5 1.4 1.5 ...
 $ Petal.Width : num  0.2 0.2 0.2 0.2 0.2 0.4 0.3 0.2 0.2 0.1 ...
 $ Species     : Factor w/ 3 levels "setosa","versicolor",..: 1 1 1 1 1 1 1 1 1 1 ...
```

* cross tabulate one column with table


```r
table(iris$Species)
```

```

    setosa versicolor  virginica 
        50         50         50 
```

Data frame
======================
* see a summary of all the data with **summary( )**


```r
summary(iris)
```

```
  Sepal.Length    Sepal.Width     Petal.Length    Petal.Width   
 Min.   :4.300   Min.   :2.000   Min.   :1.000   Min.   :0.100  
 1st Qu.:5.100   1st Qu.:2.800   1st Qu.:1.600   1st Qu.:0.300  
 Median :5.800   Median :3.000   Median :4.350   Median :1.300  
 Mean   :5.843   Mean   :3.057   Mean   :3.758   Mean   :1.199  
 3rd Qu.:6.400   3rd Qu.:3.300   3rd Qu.:5.100   3rd Qu.:1.800  
 Max.   :7.900   Max.   :4.400   Max.   :6.900   Max.   :2.500  
       Species  
 setosa    :50  
 versicolor:50  
 virginica :50  
                
                
                
```

Data frame
======================
* In R studio, you should have already typed the code: **data(iris)**
* Look at the Environment tab in the top right box, did iris appear there?
* Click on iris to see what happens
* Notice everything else in the environment tab. These are the objects in memory now.


Subsetting vectors
============
* Vectors are indexed with **[ ]**
  + the number is the item position, starting from the right


```r
 y<-c("a","b", "c")
y[1]
```

```
[1] "a"
```

```r
y[c(1,3)]
```

```
[1] "a" "c"
```

Subsetting vectors
===========
 * Vectors are indexed with **[ ]**
   + a negative index will show all **but** that item


```r
y<-c("a","b", "c")
y
```

```
[1] "a" "b" "c"
```

```r
y[-2]
```

```
[1] "a" "c"
```

Subsetting vectors
=============
* Vectors are indexed with **[ ]**
    + a conditional index will grab values that meet a criteria


```r
x<-seq(1,20, by=2)
x
```

```
 [1]  1  3  5  7  9 11 13 15 17 19
```

```r
x[x<=7]
```

```
[1] 1 3 5 7
```

```r
x[x==7]
```

```
[1] 7
```

* Practice: can you grab the 5th item in the vector? 
*     Try saving values of **x** greater than 10 as **y**

Subsetting vectors
=============
* What if I want just **less than**, instead of **less than or equal**?

Subsetting data
=============
* What if I want just **less than**, instead of **less than or equal**?


```r
x[x<7]
```

```
[1] 1 3 5
```

Subsetting vectors
=============
* What if I want to see the last item in the vector?

Subsetting vectors
=============
* What if I want just the last item in the vector?


```r
length(x)
```

```
[1] 10
```

```r
x[length(x)]
```

```
[1] 19
```

Subsetting data frames and matrices
============
* Data frames and matrices are indexed by **row**, **column** inside [ ]


```r
dat <- data.frame(id = letters[1:10], x = 1:10, y = 11:20)
head(dat)
```

```
  id x  y
1  a 1 11
2  b 2 12
3  c 3 13
4  d 4 14
5  e 5 15
6  f 6 16
```

```r
#row 1, column 2
dat[1,2]
```

```
[1] 1
```

Subsetting data frames and matrices
============
* What if I want the first 5 rows in column 2?
* What about all the rows in column 2?


```r
#first 5 rows, column 2
dat[1:5,2]
```

```
[1] 1 2 3 4 5
```

```r
##all the rows, column2
dat[ ,2]
```

```
 [1]  1  2  3  4  5  6  7  8  9 10
```

* Practice: Try grabing the 2nd row and saving it as **z**
* what kind of data is z? (try **class(** z **)** to see)

Subsetting data frames and matrices
============
* You can also grab rows based on a condition


```r
##rows where x >5, column3
dat[ dat$x>7, 2]
```

```
[1]  8  9 10
```

Subsetting data frames and matrices
============
* What if I want all the rows in column 1 ("id") where a different column, x, is greater than 8?


```r
##rows where x >8, column 1
dat[dat$x>8, 1]
```

```
[1] i j
Levels: a b c d e f g h i j
```

```r
dat$x>8
```

```
 [1] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE  TRUE
```

* Note: if you give R an index of TRUE and FALSE, it assumes you want to keep TRUE

Subsetting data frames and matrices
============
* selectively replace rows in y where x meets a criteria


```r
##selectively replace rows where x >7 in  column3 with 100
dat[ dat$x>7, 3]<-100
tail(dat)
```

```
   id  x   y
5   e  5  15
6   f  6  16
7   g  7  17
8   h  8 100
9   i  9 100
10  j 10 100
```

Subsetting data frames
============
* Data frames can also be subset by column name, with $


```r
dat <- data.frame(id = letters[1:10], x = 1:10, y = 11:20)
dat$y
```

```
 [1] 11 12 13 14 15 16 17 18 19 20
```

```r
dat[ , "y"]
```

```
 [1] 11 12 13 14 15 16 17 18 19 20
```

Combining data: Vectors
======================
* c( ), for "combine" or "concatenate"


```r
x <- 1:3
y<-c(5,6,7)
z<- c(x,y)
z
```

```
[1] 1 2 3 5 6 7
```

Combining data: data frames and matrices
======================
* append a row: **rbind( )**, append a column: **cbind( )**


```r
m <- matrix(c(4, 4, 4, 4),
  nrow = 2,
  ncol = 2)
m
```

```
     [,1] [,2]
[1,]    4    4
[2,]    4    4
```

```r
y<-c(2,2)
m<-rbind(m,y)
m
```

```
  [,1] [,2]
     4    4
     4    4
y    2    2
```

* practice: create a vector and then use **cbind(** **)** to add it to your matrix. Look at the result.

Combining data: data frames
======================
* add a new named column


```r
dat <- data.frame(plot = letters[1:3], band1 = rnorm(n=3, mean=0.1, sd=0.05), band2 = rnorm(n=3, mean=0.2, sd=0.06))
head(dat)
```

```
  plot      band1     band2
1    a 0.09769060 0.2021737
2    b 0.03810718 0.2707714
3    c 0.14466211 0.1841557
```

```r
z<-rnorm(n=3, mean=0.15, sd=0.03); z
```

```
[1] 0.1415049 0.1775517 0.1240980
```

```r
dat$band3 <- z
head(dat)
```

```
  plot      band1     band2     band3
1    a 0.09769060 0.2021737 0.1415049
2    b 0.03810718 0.2707714 0.1775517
3    c 0.14466211 0.1841557 0.1240980
```

Combining data: data frames
======================
* how do I create a new column as a mathmatic combo of other columns?


```r
dat$sr<-(dat$band2)/(dat$band3)
head(dat)
```

```
  plot      band1     band2     band3       sr
1    a 0.09769060 0.2021737 0.1415049 1.428739
2    b 0.03810718 0.2707714 0.1775517 1.525028
3    c 0.14466211 0.1841557 0.1240980 1.483954
```

* practice: create a new column in **dat** that is the normalized difference of two band columns 
pseudo code: (x-y)/(x+y)


Combining data: data frames
======================
* merge two data frames via a common column


```r
dat <- data.frame(date = seq.Date(from=as.Date("2019-01-01"), 
                                  to=as.Date("2019-01-10"), by=2),  
                  x = 1:5, y = 11:15)
dat2<-data.frame(date = seq.Date(from=as.Date("2019-01-01"), 
                                 to=as.Date("2019-01-05"), by=1),  
                 z = seq(from=5, to=10, length.out=5))
head(dat)
```

```
        date x  y
1 2019-01-01 1 11
2 2019-01-03 2 12
3 2019-01-05 3 13
4 2019-01-07 4 14
5 2019-01-09 5 15
```

```r
head(dat2)
```

```
        date     z
1 2019-01-01  5.00
2 2019-01-02  6.25
3 2019-01-03  7.50
4 2019-01-04  8.75
5 2019-01-05 10.00
```

Combining data: data frames
======================
* merge two data frames via a common column


```r
dat<-merge(dat, dat2, by="date", all.x=TRUE, all.y=TRUE)
head(dat)
```

```
        date  x  y     z
1 2019-01-01  1 11  5.00
2 2019-01-02 NA NA  6.25
3 2019-01-03  2 12  7.50
4 2019-01-04 NA NA  8.75
5 2019-01-05  3 13 10.00
6 2019-01-07  4 14    NA
```

* Practice: what happens if I change all.x or all.y to FALSE?

Plotting data
===============


```r
plot(iris$Sepal.Length[iris$Species=="setosa"], 
     iris$Sepal.Width[iris$Species=="setosa"], pch=19,
     xlab= "Sepal Length (mm)", ylab= "Sepal Width (mm)", col="red")
```

![plot of chunk unnamed-chunk-31](00-intro_to_R-figure/unnamed-chunk-31-1.png)


Plotting data: add more points
===============

```r
plot(iris$Sepal.Length[iris$Species=="setosa"], 
     iris$Sepal.Width[iris$Species=="setosa"], pch=19,
     xlab= "Sepal Length (mm)", ylab= "Sepal Width (mm)", col="red")
points( iris$Sepal.Length[iris$Species=="versicolor"], pch=1,  
        iris$Sepal.Width[iris$Species=="versicolor"], col="blue")
```

![plot of chunk unnamed-chunk-32](00-intro_to_R-figure/unnamed-chunk-32-1.png)

Plotting data: adjust the plot
===============
* how can we use **summary( )** to figure out what the axis limits should be?

![plot of chunk unnamed-chunk-33](00-intro_to_R-figure/unnamed-chunk-33-1.png)

Plotting data: adjust the plot
===============
* how can we use **summary( )** to figure out what the axis limits should be?


```
  Sepal.Length    Sepal.Width     Petal.Length    Petal.Width   
 Min.   :4.300   Min.   :2.000   Min.   :1.000   Min.   :0.100  
 1st Qu.:5.100   1st Qu.:2.800   1st Qu.:1.600   1st Qu.:0.300  
 Median :5.800   Median :3.000   Median :4.350   Median :1.300  
 Mean   :5.843   Mean   :3.057   Mean   :3.758   Mean   :1.199  
 3rd Qu.:6.400   3rd Qu.:3.300   3rd Qu.:5.100   3rd Qu.:1.800  
 Max.   :7.900   Max.   :4.400   Max.   :6.900   Max.   :2.500  
       Species  
 setosa    :50  
 versicolor:50  
 virginica :50  
                
                
                
```

Plotting data: adjust the plot
===============

```r
plot(iris$Sepal.Length[iris$Species=="setosa"], 
     iris$Sepal.Width[iris$Species=="setosa"],  pch=19,
     xlab= "Sepal Length (mm)", ylab= "Sepal Width (mm)", col="red",
     xlim=c(4.3,7.9), ylim=c(2,4.4))
points( iris$Sepal.Length[iris$Species=="versicolor"], pch=1,  
        iris$Sepal.Width[iris$Species=="versicolor"], col="blue")
```

![plot of chunk unnamed-chunk-35](00-intro_to_R-figure/unnamed-chunk-35-1.png)

Plotting data: adjust the plot
===============
* There's a third species. How can find out what it is and add it to the plot?
* Hint: try summary(iris), table(iris$Species), or levels(iris$Species)

![plot of chunk unnamed-chunk-36](00-intro_to_R-figure/unnamed-chunk-36-1.png)

Plotting data: add the third species
===============


```r
plot(iris$Sepal.Length[iris$Species=="setosa"], 
     iris$Sepal.Width[iris$Species=="setosa"],  pch=19,
     xlab= "Sepal Length (mm)", ylab= "Sepal Width (mm)", col="red",
     xlim=c(4.3,7.9), ylim=c(2,4.4))
points( iris$Sepal.Length[iris$Species=="versicolor"], pch=1,  
        iris$Sepal.Width[iris$Species=="versicolor"], col="blue")
points( iris$Sepal.Length[iris$Species=="virginica"], pch=3,  
        iris$Sepal.Width[iris$Species=="virginica"], col="green")
```

![plot of chunk unnamed-chunk-37](00-intro_to_R-figure/unnamed-chunk-37-1.png)
  
