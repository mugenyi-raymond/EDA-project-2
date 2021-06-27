# Reading the data (already in my working directory)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# subsetting the data to get that for Baltimore city
baltimore_city <- NEI[NEI$fips == "24510",]

#grouping the Emissions by year and calculating their total  in each year
# with aggregate function.

total_emissions <- aggregate(Emissions ~ year, data = baltimore_city, FUN = sum)

# Making the plot and saving it as png file
png(filename = "plot2.png")
with(total_emissions, barplot(height = Emissions/1000, names.arg = year,
                              col = c("red", "blue", "green", "yellow")))
title(main = "Baltmore, Maryland Total Emissions in kilotons: 1999 - 2008",xlab = "Year",
      ylab = "PM2.5 Emissions in kilotons" )

dev.off()
