##script to associate superger sig and jpeg files with the svc file read number from the field
##(info found inside the file) and then rename the sig and jpeg files with the field plot name
##Usage: enter svc number into field_svc_data.ods file; create directories for data;
##       change date below to correct date string and field data sheet to correct sheet in the ods file; 
##       plot each match to make sure it's good data; if you want to use a new sig file, 
##       change the svc number in the .ods file to the new read number and re-run merge statements
##       double check input directories and output filenames/directories before writing out 
##       processed data

##code steps: create a data frame of the svc sig and jpeg files
##            merge these with a data frame of your field collected plot names and file read numbers
##            copy the raw svc files to a new folder, renamed with the field plot names

library(tidyverse); library(readxl)

##setup directories; change date to correct date (MMDDYYYY)
date<-"07122016"
  
#super ger file root
fileroot<-paste0("seagrant_", date)
##first set your working directory, change this to the "raw_svc_data" folder path on your computer
##if you're on Windows, remember that the file path must use "/" not "\"
##note also, the path needs " " around the path string
setwd("/home/jessica/UGA/Teaching/Intro_to_R/data/raw_svc_data")
outdir<-("../output/")
  
##load the field data
##change the path below to the file path on your computer
field<-read_excel("/home/jessica/UGA/Teaching/Intro_to_R/data/field_svc_data.xlsx")

##Process the SVC files
##create a dataframe of the sig files with corresponding jpeg files in same row
files<-list.files()
jpeg<-files[grep(".jpg", files)]
jpeg<-data.frame(jpeg=as.character(jpeg))
head(jpeg)

sig<-files[-grep(".jpg", files)]
sig<-data.frame(sig=as.character(sig))

##we need to merge sig and jpeg together into one data frame, 
##so that we can associate the sig file with it's jpeg file
##To merge them, we need a column in both of data frames that has the same values
##Let's use str_sub to split off the .jpeg from the jpeg file name
##Practice: add a key columns to jpeg and sig that is just the file root
##try ?str_sub if you don't know what it does
jpeg$key <-
sig$key <-

##now we can use the key column to merge these data frames to 
super_ger<-merge(jpeg, sig, by="key", all.y=T)

##lets clean up our data type to make things easier
##makes sure the sig and jpeg fields are character, not factor data types
super_ger$sig<-as.character(super_ger$sig)
super_ger$jpeg<-as.character(super_ger$jpeg)

##Now we need the file read number, we wrote down in the field but annoyingly, it's inside the sig file
##open a sig file with a text editor, see if you can find where the read number is.


##Did you find it? Look at the memory slot line in the sig file. It has two numbers.
##which one is the right one? Open a couple of sig files to see if you can tell.


##OK, lets pull that number out of the sig file and add it as a column to our superger data frame,
##This will allow us to use it to merge our field data to the super_ger file data

##we're going to need to loop over all the files eventually, but lets start with just the first one to see what to do
##to open a sig file, use readLines() which can read text in any plain text file
x<-readLines(super_ger$sig[1])
##let's see what x looks like
##compare it to a .sig file in your text editor
x[1:25]

##what if I grab just one line from x?
x[4]

##which line do I need to get the line that has the field read info? Replace the ? in the [] below
x<-x[?]

##ok but now I need to separate the number I want from the rest of the text
##how can str_split() solve this? Which character should I split on?
##replace the ? between the " " below with the right character
x<-str_split(x, "?", simplify=T)
head(x)

##ok, now add a column to our super_ger dataframe with the field read, just for the first row
##replace the ? below with the right column number from x
super_ger$field_read[1]<-as.numeric(x[,?])

##Now we need to create a loop that can repeat this for all the files
##start by intializing an empty column that we can put data in as we go through the for loop
super_ger$field_read<-rep(NA, nrow(super_ger))

##fill in the rows below with the right code, use the code we made above to help you
for(i in 1:nrow(super_ger)){
    x<-readLines(super_ger[i,"sig"])
    ?
    ?
}

##Now we need a new key field, one that has the field read number, 
##we can use this to merge the field data from the .ods file
super_ger$key<-paste0(fileroot, "_",super_ger$field_read)
#now create the same column in the field data frame
field$key<-paste0(fileroot, "_",field$svc_field_read)
super_ger<-merge(super_ger, field, by="key", all.x=T)

##lets clean up the column types for this one again
super_ger<-super_ger[order(super_ger$plot),]
super_ger$sig<-as.character(super_ger$sig)
super_ger$jpeg<-as.character(super_ger$jpeg)

z<-4

y<-read.table(super_ger[super_ger$field_read==z,"sig"], skip=25)
colnames(y)<-c("wave", "reference", "target", "reflectance")
##Reduce the margins for the plot, see ?par and search for mar for help
##(skip several times to get to the actual mar help entry)
##mar: a numerical vector of the form c(bottom, left, top, right) 
##which gives the number of lines of margin to be specified on the four sides of the plot. 
##The default is c(5, 4, 4, 2) + 0.1.
par(mar=c(2.75, 4.5, 1, 1))
plot(y$wave, y$reflectance, xlab="", ylab="reflectance", type="l", lwd=2)

##subset the super_ger data frame to just those rows that have plot data, ie., the ones we want to keep
super_ger<-super_ger[!is.na(super_ger$plot),]


##now we get to the heart of the matter, lets copy the old sig and jpeg files to a new folder, 
##but lets rename them in the process with our field plot names
##to do this we need file.copy()
##look at the help for file.copy
##look at the head of the super_ger data frame, this has columns with all the old file names
head(super_ger)
##so we can use the super_ger data frame to get the old file names for file.copy
##Now we need a way to tell file.copy what the new file name and location should be; 
##Remember above we created a variable called outdir that has the new location; print outdir below
outdir
##where does R think it is right now?
getwd()

##if I write a file into the current working directory some basic code looks like this
x<-data.frame(x=1:10)
write.csv(x,"test.csv")

##where is test.csv on your computer?

##lets get rid of the file we made, we don't need it
file.remove("test.csv")

##lets try putting test.csv somewhere else
write.csv(x,"../test2.csv")

##where did it go? Can you use paste or paste0 and the outdir object to see if you can put test.csv in the output folder?
write.csv(x, paste0(?, ?))

##ok, how can we use file.copy, the file names in the super_ger data frame and 
##paste or paste0 to copy our .sig and .sig.jpg files into the output folder with a new name?
##change the ?'s below to complete the code
file.copy(superger$? , paste0(outdir, ?, ?, ".sig"))
file.copy(superger$? , paste0(outdir, ?, ?, ".sig.jpg"))

##Now write a for loop that we copy all of the files over
for(i in 1:nrow(super_ger)){
    file.copy(???)
    file.copy(???)
}
    

