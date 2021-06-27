# Reading the data (already in my working directory)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# subsetting the data to get that for Baltimore city
baltimore_city <- NEI[NEI$fips == "24510",]

# making the plot and saving it as png file
png(filename = "plot3.png")
library(ggplot2)
g <- ggplot(baltimore_city, aes(factor(year), Emissions, fill = type))
g+geom_bar(stat = "identity")+facet_grid(.~type) + xlab("Year") + ylab("Emissions in tons")+
  ggtitle("Baltimore Emissions by source type from 1999 to 2008") +
  theme(plot.title = element_text(hjust = 0.5))
dev.off()


