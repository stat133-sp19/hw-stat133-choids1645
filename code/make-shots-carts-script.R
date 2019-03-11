##################################################
## Title        : Shots Data 1
## Description  : Create graphs that visualize data sets in shots-data.csv
## Input        : shots-data.csv and other csv files
## Output       : scatterplots of the coordinates of the location where the shots occurred for each player
## Date         : 3/10/2019
## Author       : David Choi
##################################################
library(dplyr)
library(ggplot2)
library(jpeg)
library(grid)

#file location of data sets
shots_data <- read.csv(file = "data/shots-data.csv")

iguodala <- filter(shots_data, shots_data$name == "Andre Iguodala")
green <- filter(shots_data, shots_data$name == "Draymond Green")
durant <- filter(shots_data, shots_data$name == "Kevin Durant")
thompson <- filter(shots_data, shots_data$name == "Klay Thompson")
curry <- filter(shots_data, shots_data$name == "Stephen Curry")

#file location of the court image
court_file <- "images/nba-court.jpg"

court_image <- rasterGrob(readJPEG(court_file), 
                          width = unit(1, "npc"),
                          height = unit(1, "npc"))
#thompson scatterplot example
thompson_scatterplot <- ggplot(data = thompson) + 
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Klay Thompson (2016 season)') +
  theme_minimal()
thompson_scatterplot
