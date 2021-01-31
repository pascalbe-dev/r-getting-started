library("readxl")
library("stringr")
library("car")
library("dplyr")

## READ DATA
mrt_data <- read.csv("mrt-data.csv", sep = ";", dec = ",")
# normalize subject ID and time point variable
mrt_data$timepoint <- str_sub(mrt_data$Subject_ID, -1, -1)
mrt_data$Subject_ID <- paste(str_sub(mrt_data$Subject_ID, 5, 5), str_sub(mrt_data$Subject_ID, 7, 8), sep = "")

group_data <- read_excel("group-data.xlsx")

## JOIN DATA
full_data <- merge(group_data, mrt_data, by = c("Subject_ID", "timepoint"))

# ANOVA for one variables
sample_anova <- aov(TotalGrayVol ~ group, full_data)
summary(sample_anova)

# ANCOVA
t1_data <- filter(full_data, timepoint == 1)
sample_ancova <- aov(TotalGrayVol ~ group + EstimatedTotalIntraCranialVol, t1_data)
# correct summary with type III errors
Anova(sample_ancova, type="III")
