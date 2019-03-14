###########################################################################################################
## Title        : Shots Data 1
## Description  : Create graphs that visualize data sets in shots-data.csv
## Input        : shots-data.csv and other csv files
## Output       : scatterplots of the coordinates of the location where the shots occurred for each player
## Date         : 3/10/2019
## Author       : David Choi
###########################################################################################################
library(dplyr)
library(ggplot2)
library(jpeg)
library(grid)

#file location of data sets
shots_data <- read.csv(file = "../data/shots-data.csv", stringsAsFactors = FALSE)

iguodala <- filter(shots_data, shots_data$name == "Andre Iguodala")
green <- filter(shots_data, shots_data$name == "Draymond Green")
durant <- filter(shots_data, shots_data$name == "Kevin Durant")
thompson <- filter(shots_data, shots_data$name == "Klay Thompson")
curry <- filter(shots_data, shots_data$name == "Stephen Curry")

#file location of the court image
court_file <- "../images/nba-court.jpg"

court_image <- rasterGrob(readJPEG(court_file), 
                          width = unit(1, "npc"),
                          height = unit(1, "npc"))

#4.1
#Andre Iguodala
pdf(file = '../images/andre-iguodala-shot-chart.pdf', width = 6.5, height = 5)
ggplot(data = iguodala) + 
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag), size = 0.8) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Andre Iguodala (2016 season)') +
  theme_minimal()
dev.off()

#Draymond Green
pdf(file = '../images/draymond-green-shot-chart.pdf', width = 6.5, height = 5)
ggplot(data = green) + 
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag), size = 0.8) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Draymond Green (2016 season)') +
  theme_minimal()
dev.off()

#Kevin Durant
pdf(file = '../images/kevin-durant-shot-chart.pdf', width = 6.5, height = 5)
ggplot(data = durant) + 
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag), size = 0.8) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Kevin Durant (2016 season)') +
  theme_minimal()
dev.off()

#Klay Thompson
pdf(file = '../images/klay-thompson-shot-chart.pdf', width = 6.5, height = 5)
ggplot(data = thompson) + 
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag), size = 0.8) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Klay Thompson (2016 season)') +
  theme_minimal()
dev.off()

#Stephen Curry
pdf(file = '../images/stephen-curry-shot-chart.pdf', width = 6.5, height = 5)
ggplot(data = curry) + 
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag), size = 0.8) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Stephen Curry (2016 season)') +
  theme_minimal()
dev.off()


#4.2
shots_charts <- ggplot(data = shots_data) + 
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag), size = 0.8) +
  facet_wrap(~name, ncol = 3) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: GSW (2016 season)') +
  theme_minimal() + 
  theme(legend.title = element_blank(), legend.position = "top")
ggsave(filename = "../images/gsw-shot-charts.pdf", plot = shots_charts, width = 8, height = 7)
ggsave(filename = "../images/gsw-shot-charts.png", plot = shots_charts, width = 8, height = 7)
