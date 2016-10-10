#Data Visualization
#Justin Joque
#Clark Data Labs
#Fall 2016 workshop



#a few helpful tricks
########
c(1,2,3) #concatanate a set of elements
1:20 #list numbers between two numbers
colors() #list all of R's colors
palette() #show the current order of colors
palette(rainbow(6)) #set colors
palette(c("green","brown","red")) #set user defined colors
identify(x,y,labels=labelfield) #label points interactively


#loading the data
#############


#we can call the data frame anything we want, but I've used census for this example

census <- read.csv(file.choose()) #read in the csv file
head(census) #see the headers plus the first six rows
summary(census) #see some summary statistics
fix(census) #open an excel-esque data editor


#histogram
############

hist(census$unemploy,xlab="Unemployment",main="Histogram of Unemployment by County in Michigan") 
#by adding breaks as a paramter we can increase or decrease the bin-size

#scatter plot
##############

plot(census$unemploy,census$hh_income)
#cex controls the size of the points (1 is default)

#we can plot the log of a variable by simply addiing it to the plot command
plot(census$hh_income, log(census$population,2))

#for the y axis this is the population normalized by area (population density)
plot(census$hh_income, census$population/census$area)

#multiple scatterplots can be made by choosing multiple variables (this will plot columns 5 through 11)
plot(census[5:11], cex=.7)


#tying other information to variables; here we take the unemployment and use it as the size
plot(census$rent,census$hh_income,cex=census$unemploy*18,pch=20,col="red") #pch=20 chooses a different symbol

#we can also build up a plot by using the points function i.e.
points(census$rent,census$hh_income,pch=20,col="blue")

#use this formula in excel or R to map a variable to be between two numbers (i.e. mapping a variable to use for size between 1 and 10):
#(new_max - new_min) * ([value] - lowest_value) / (highest_value - lowest_value) + new_min

#it is easy to add a new column:
#census$newcol <- [formula]

#subsetting data
################

# census[1:5] returns the first 5 columns, as does census[,1:5], but census[1:5,] give the first five rows

upper <- census[census$region=="upper",] #note the comma after the conditional!
central <- census[census$region=="central",] #without the comma it defaults to the second part
lower <- census[census$region=="south",]

#we can also build up a plot by using the points function i.e.
plot(c(0,max(census$rent)),c(0,max(census$hh_income)),type="n") #create a blank canvas
points(upper$rent,upper$hh_income,pch=20,col="blue")
points(central$rent,central$hh_income,pch=20,col="red")
points(lower$rent,lower$hh_income,pch=20,col="green")

#boxplot
###########
boxplot(census[,12],census[,13],col="lightblue",names=c("men","women"),main="Median Income by Sex For Population\nThat Worked Full-time Last 12 Months\nby County ACS 2006-2010")
boxplot(hh_income ~ region,data=census, col="lightgreen", main="Median Income by Region\nby County ACS 2006-2010") #this will give us household in come by region



#heatmap
##########

census2 <- census[3:11]
row.names(census2) <- census$name
census_matrix <- data.matrix(census2)
heatmap(census_matrix, Rowv=NA, Colv=NA, col=cm.colors(256), scale="column")


