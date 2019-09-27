##This is an R script. In it, we will explore how to load the spectral reflectance data in the svc files,
##standardize them to a common wavelength intervals, clean them up a little 
##and put them all together into a common data frame that we can write out to use whenever we need it
##This code will also explore how to plot all these data together in the same graph 
##
##goals: learn to read data on your computer into R
##       learn how to change data into a more useful form and write it back out
##       learn how to manipulate text strings and merge data frames along the way
##       learn how to summarise data based on a common group with tidyverse
##       learn how to plot data and use "for loops" to make plotting many data sets easier
##       learn how to save plots to your hard drive as jpegs

##install the package below if you haven't yet, but don't load it into memory with library(plyr), 
##this will avoid function name conflicts with the dplyr package, which is loaded when we load tidyverse
install.packages("plyr")

##Lets load the other libraries with the extra functions we'll need
library(tidyverse);library(stringr)

##first set your working directory, change this to the "processed_svc_data" folder path on your computer
setwd("/home/jessica/Documents/UGA/Teaching/Intro_to_R/assignment/data/processed_svc_data")

##now we can use R to make a list of all the files in this folder that end in ".sig"
files<-list.files(pattern=".sig")
head(files)

##looks like there's some jpg files in there. We don't need those right now, so lets remove them
##Take a look at the Strings cheatsheet available at https://rstudio.com/resources/cheatsheets/
##Can you use this to write some code below that will first dectect which lines in files are jpegs and then remove them from the files vector?
##pseudo code, replace with your code
   detect the items in the vector files which represent jpeg files
   modify (<-) the files vector so that you remove the items representing jpegs (remember, x[-1] removes the first item)


#lets see if it worked, we should just have the sig files now
head(files)

##now lets use the file names to create a data frame with meta data about our sample plots
##we can use this later to label our data columns with the plot names
##look again at the Strings cheatsheet, which functions should we use here to pull the plot names from the the files vector?
##pseudo code, replace with your code
x<- split the file name into a plot name and the rest of the file name, use a text pattern in the name to create the split

##can we turn x into a data frame with a plot column? how should we complete the code below? Replace the ??? with your guess
file_info<-data.frame(plot= ??)

##if you're feeling confident, you could also split the date column out of the file name and add it to file_info, 
##you'll need to escape the "." in .sig because . is a wildcard in text searches, you can escape it with "//.sig"
##You can read more about this on the strings cheatsheet
##psuedocode:
dates<-??
file_info$date<-??

##Ok, now that we have some meta data about our files, lets read the file data into R
##Look at the help for read.table with ?read.table
##why do I need 'skip =25' below?, what happens if you omit this? What happens if you don't put header=FALSE?
##Open a .sig file in a text editor to see what's going on
reflect<-read.table(files[1], header=FALSE, skip= 25)
head(reflect)

##for this exercise, our goal is to create a single dataframe that has all of our spectral data
##One way to do this is to have a wavelength column and columns for each plot with spectral reflectance data
##lets try that and subset the first reflectance file to just the columns we need 
reflect<-reflect[,c(1,4)]
##It will be easier if we label the column names
colnames(reflect)<-c("wave", "reflect")
head(reflect)

##Unfortunately, the super ger doesn't always collect data at the exact same wavelengths
##This means we can't use the wavelength column to merge the separate files together
##but we can fix this by standardizing wavelength to a common interval

##Lets standardize reflectance to an average by 10 nm increments 
##We'll use a function from the plyr library. 
##We haven't loaded plyr functions with library(plyr), but we can access them anyway with plyr::function_name()
reflect$wave<-plyr::round_any(reflect$wave, 10)

##before going further, first by do some data clean up
##we can use ifelse to remove extreme values (replace them with NA), while leaving the rest of the data alone
##once you get the hang of this, you could add other clean up steps here too.
reflect$reflect<-ifelse(reflect$reflect<0.01,NA,reflect$reflect)
reflect$reflect<-ifelse(reflect$reflect>90,NA,reflect$reflect)


##now we need to standardize the reflect data frame to a 10 nm interval
head(reflect)
##notice that reflect has several rows with the same wavelength
##lets reduce this to just one row for every identical wavelength by taking the mean
##we can do this with the tidyverse dplyr functions; 
##Take a look a the dplyr cheatsheet, 
##It's at ##https://rstudio.com/resources/cheatsheets/, or accessed under the help menu in RStudio
##You can also find a lot of help on these functions in Wickhams online book at: https://r4ds.had.co.nz/transform.html
##tidyverse functions can by chained together with the %>% symbol so that the output from one is given to the next one
##Remember that tidyverse functions take data differently than base-R, 
##    you often don't need the to reference a column as dat$col but instead can just use the column name
##which functions do need to group together to accomplish our goal? which columns of data do we need to use?
##psuedo code: replace with your code 
reflect<- reflect %>% group the data frame by wavelength  %>% summarise the data as the mean of each wavelength interval
head(reflect)

##lets see what this looks like at this point
plot(reflect$wave, reflect$reflect, type="l", ylab="Spectral reflectance", xlab="Wavelength (nm)")

##now we're going to prepare to add columns for the other plots. This means the reflectance value for this plot needs it's own name
##Lets assume you were able to create the file_info data frame above, 
##and that this dataframe has the plot names in the same order as the files
colnames(reflect)<-c("wave", file_info$plot[1])
head(reflect)

##lets repeat and build out the dataframe for other samples
##pseudocode: load the data from a file named in the files vector into a temporary data frame, 
##            **hint, repeat the code from above for a single file, but index files with "i" in the right place
##            Paste in the code from above for the next datasteps, decide where you need "i"
##            Make sure that the reflectance column in a gets the right plot name every time through the loop
##            **hint, you can test the loop by temporarily creating an object i with a row number from files that you want to test
##            Merge a with the reflect data frame using the wavelengths as a merge column
##            you will eventually have a dataframe called reflect with the following columns:
##               wave, m1, m2, m3 ... t4 t5 t6
for (i in 2:length(files)) {
    #i<-2 ##Uncomment this line to test the for loop without "for"
    
    a<-read.table -- fill this out
    
    ##repeat the code from above, where we grab the wave and reflectance columns only and name them
    ##but do this on the 
    your code here
    
    #standardize wave to common values
    your code here 
    
    ##remove extreme values
    your code here
    
    ##now standardize to 10 nm interval with dplyr/tidyverse
    your code here
    
    ##rename the columns in a so that we have a column for wave to merge with, a column named for the plot, get the plot name from file_info
    colnames(a)<- your code here
    reflect<-merge(reflect,a, by="wave", all.x=T, all.y=T)
 }


##Can we plot all of the spectra into a single plot?
##Lets start with the first one again, but lets use color this time

##set up our color palatte using a built in color function
##we need as many unique colors as we have sample plots
##I'm adding an empty item at the begining of the colors vector 
##thus, the index for colors is the same as the column index in reflect, will this make a for loop easier to code?
colors<-c("nothing",topo.colors(length(files)))
##what do these colors look like? Skip the first one, which is nothing :)
plot(1:length(files), col=colors[2:length(colors)], pch=19, cex=2)

##practice, play with rainbow(), heat.colors(), terrain.colors to get other color palettes

##Now lets' plot the first series, in the first color. 
##We'll also need to expand the y axis limits to make room for the other sample data
plot(reflect$wave, reflect[,2], type="l", 
     ylab="Spectral reflectance", xlab="Wavelength (nm)", 
     ylim=c(0,45), col=colors[2])
##we can add the next sample plot with lines
lines(reflect$wave, reflect[,3], col=colors[3])

##create a for loop that uses lines to get the other samples graphed
##hint, you can cycle through the columns with number:ncol(reflect), 
##     where number is the column number you want to start the loop with
for( your code here) {
    lines(  your code here )
}
##lets add a legend; we can get the sample plot labels from file_info again
legend("topleft", legend=file_info$plot, col=colors[2:length(colors)], pch=15,cex=0.75)


##Let's save the plot for later, we can save as any file type, but why not a jpeg?
jpeg("../../output/MyPlot.jpeg", width=5, height=4.5, units="in", res=96) 
##the line below allows you to set the plot margins to remove some white space, 
par(mar=c(4.5,4.5,1,1)) # 4.5 lines of space on the bottom, 4.5 for right, 1 line for top, 1 line for left
plot(reflect$wave, reflect[,2], type="l", 
     ylab="Spectral reflectance", xlab="Wavelength (nm)", 
     ylim=c(0,45), col=colors[2])
for(your code here, paste from above ){
    your code here, paste from above
}
legend("topleft", legend=file_info$plot, col=colors[2:length(colors)], pch=15,cex=0.75)
##close the plotting device and write to disk happens after dev.off()
##this is how R knows your done providing plot code
dev.off()

##lets write out this reflect data frame to a csv file to use later
write.csv(reflect, "../../output/myspectra.csv", row.names=F)

##Note that the reflect data frame makes plotting the data easy in this case, but this isn't tidy data
##tidy data has one row for each observation/plot/sample and the columns are attributes/variables about the sample
##The attributes about these samples are the wavelengths
##so tidy data would be a dataframe that has these columns:
##plot, band1, band2, ... bandx
##Tidy data will be easier to give to statistics functions
##Try creating some tidy data:
##  hint: data.frame(t() ) will transpose data and convert it to a dataframe from a matrix
##Psuedo code:
 
x<- transpose the rows and columns of reflect with a function
convert x to a data frame
colnames(x)<- c() what should the column names be? 
x$plot <- how to add a column with the sample plot names?
reorder the columns in x so that plot column comes before the band columns, 
      hint for above: try using base R indexing [ , ], c() and ncols() 

write.csv(x, "../../output/my_tidy_spectra.csv", row.names=F)

