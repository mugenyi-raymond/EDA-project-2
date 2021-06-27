# Reading the data (already in my working directory)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# subsetting the data to get that for Baltimore city
baltimore_city <- NEI[NEI$fips == "24510",]

#getting matches of vehicle in the EI.sector variable of SCC data
vehicle_matches <- grep("[Vv]ehicle", SCC$EI.Sector)

# subsetting the SCC data for the vehicle_matches
vehicle_matches_scc <- SCC[vehicle_matches,]

# getting SCC from baltimore city data that matches vehicle_matches_scc i got from SCC data
library(dplyr)
vehicle_matches_nei <-baltimore_city %>% filter(SCC %in% vehicle_matches_scc$SCC) 

# making the plot and saving it as png file
png(filename = "plot5.png")
library(ggplot2)
g <- ggplot(vehicle_matches_nei, aes(factor(year), Emissions, fill = year))
g + geom_bar(stat = "identity") + xlab("Year") + ylab("Emissions in tons") + 
  ggtitle("Baltimore motor vehicle emission sources from 1999-2008") +
  theme(plot.title = element_text(hjust = 0.5))
dev.off()

