library("readxl")
library("stringr")

## READ DATA
mrt_data <- read.csv("mrt-data.csv", sep = ";", dec = ",")
# normalize subject ID and time point variable
mrt_data$timepoint <- str_sub(mrt_data$Subject_ID, -1, -1)
mrt_data$Subject_ID <- paste(str_sub(mrt_data$Subject_ID, 5, 5), str_sub(mrt_data$Subject_ID, 7, 8), sep = "")

group_data <- read_excel("group-data.xlsx")

## JOIN DATA
full_data <- merge(mrt_data, group_data, by = c("Subject_ID", "timepoint"))

# ANOVA for all variables
sample_anova <- aov(TotalGrayVol ~ group, data = full_data)
summary(sample_anova)
