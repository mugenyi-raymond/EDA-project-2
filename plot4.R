
# Reading the data (already in my working directory)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#getting matches of coal in the EI.sector variable of SCC data
coal_matches <- grep("[Cc][Oo][Aa][Ll]", SCC$EI.Sector)

# subsetting the SCC data for the coal_matches
coal_matches_scc <- SCC[coal_matches,]

# getting SCC from NEI data that matches coal_matches_scc i got from SCC data
library(dplyr)
coal_matches_nei <-NEI %>% filter(SCC %in% coal_matches_scc$SCC) 

# making the plot and saving it as png file
png(filename = "plot4.png")
library(ggplot2)
g <- ggplot(coal_matches_nei, aes(factor(year), Emissions/1000, fill = year))
g + geom_bar(stat = "identity") + xlab("Year") + ylab("Emissions in kilotons")+
  ggtitle("Coal combustion related sources across U.S :1999-2008") +
  theme(plot.title = element_text(hjust = 0.5))
dev.off()
