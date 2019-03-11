##################################################
## Title        : Shots Data (Part 3)
## Description  : Create a csv file shots-data.csv that contains data of shots made by five players
## Input        :
##                - andre-iguodala.csv
##                - draymond-green.csv
##                - kevin-durant.csv
##                - klay-thompson.csv
##                - stephen-curry.csv
## Output       : shots-data.csv and other summaries of data in txt format
## Date         : 3/10/2019
## Author       : David Choi
##################################################

#read in five data

#curry
curry <- read.csv("../data/stephen-curry.csv", stringsAsFactors = FALSE)
curry <- data.frame(name = c("Stephen Curry"), curry)

curry$shot_made_flag[curry$shot_made_flag == "n"] <- "shot_no"
curry$shot_made_flag[curry$shot_made_flag == "y"] <- "shot_yes"

curry$minute <- ((12 * curry$period) - curry$minutes_remaining)

sink(file = '../output/stephen-curry-summary.txt')
summary(curry)
sink()

#iguodala  
iguodala <- read.csv("../data/andre-iguodala.csv", stringsAsFactors = FALSE)
iguodala <- data.frame(name = c("Andre Iguodala"), iguodala)

iguodala$shot_made_flag[iguodala$shot_made_flag == "n"] <- "shot_no"
iguodala$shot_made_flag[iguodala$shot_made_flag == "y"] <- "shot_yes"

iguodala$minute <- ((12 * iguodala$period) - iguodala$minutes_remaining)

sink(file = '../output/andre-iguodala-summary.txt')
summary(iguodala)
sink()

#green
green <- read.csv("../data/draymond-green.csv", stringsAsFactors = FALSE)
green <- data.frame(name = c("Draymond Green"), green)

green$shot_made_flag[green$shot_made_flag == "n"] <- "shot_no"
green$shot_made_flag[green$shot_made_flag == "y"] <- "shot_yes"

green$minute <- ((12 * green$period) - green$minutes_remaining)

sink(file = '../output/draymond-green-summary.txt')
summary(green)
sink()

#durant
durant <- read.csv("../data/kevin-durant.csv", stringsAsFactors = FALSE)
durant <- data.frame(name = c("Kevin Durant"), durant)

durant$shot_made_flag[durant$shot_made_flag == "n"] <- "shot_no"
durant$shot_made_flag[durant$shot_made_flag == "y"] <- "shot_yes"

durant$minute <- ((12 * durant$period) - durant$minutes_remaining)

sink(file = '../output/kevin-durant-summary.txt')
summary(durant)
sink()

#thompson
thompson <- read.csv("../data/klay-thompson.csv", stringsAsFactors = FALSE)
thompson <- data.frame(name = c("Klay Thompson"), thompson)

thompson$shot_made_flag[thompson$shot_made_flag == "n"] <- "shot_no"
thompson$shot_made_flag[thompson$shot_made_flag == "y"] <- "shot_yes"

thompson$minute <- ((12 * thompson$period) - thompson$minutes_remaining)

sink(file = '../output/klay-thompson-summary.txt')
summary(thompson)
sink()

#concatenate all data into one
shots_data <- rbind(iguodala, green, durant, thompson, curry)
write.csv(x = shots_data, file = "../data/shots-data.csv", row.names = FALSE)
sink(file = '../output/shots-data-summary.txt')
summary(shots_data)
sink()
