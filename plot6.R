# Reading the data (already in my working directory)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# creating data frame with the required fips and corresponding city names
df <- data.frame(fips = c("24510", "06037"), city = c("Baltimore City", "Los Angels"))

# subsetting the data to get that for Baltimore city and Los Angels
baltimore_los <- NEI[NEI$fips == "24510" | NEI$fips == "06037",]

#getting matches of vehicle in the EI.sector variable of SCC data
vehicle_matches <- grep("[Vv]ehicle", SCC$EI.Sector)

# subsetting the SCC data for the vehicle_matches
vehicle_matches_scc <- SCC[vehicle_matches,]

# getting SCC from baltimore_los data that matches vehicle_matches_scc i got from SCC data
library(dplyr)
baltimore_los_vehicle_matches <-baltimore_los %>% filter(SCC %in% vehicle_matches_scc$SCC) 

# Now merging df created at first with baltimore_los_vehicle_matches to create a new data
# frame with an extra variable "city".City names will make the plot more understandable
# than using fips.
baltimore_los_vehicle_matches_final <- merge(df, baltimore_los_vehicle_matches)

# making the plot and saving it as png file
png(filename = "plot6.png")
g <- ggplot(baltimore_los_vehicle_matches_final, aes(factor(year), Emissions, fill = year))
g + geom_bar(stat = "identity") + facet_grid(.~city) + xlab("Year") + 
  ylab("Emissions in tons") + 
  ggtitle("Baltimore vs Los Angels motor Vehicle emissions:1999-2008") +
  theme(plot.title = element_text(hjust = 0.5))
dev.off()
