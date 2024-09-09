#Introduction to R with ChatGPT


###Basic operations
2 + 2   # Addition
5 * 3   # Multiplication
10 / 2  # Division

###Assigning Variables
x <- 5     # This assigns the value 5 to the variable x
y <- 10    # y is assigned the value 10
result <- x + y   # Now result contains the sum of x and y

###Data types
num <- 5.5   # Numeric value
text <- "R is great!"   # Character string
is_true <- TRUE   # Logical value

###Data structures
numbers <- c(1, 2, 3, 4, 5)  # Create a numeric vector


#upload a data frame
# Load necessary libraries
library(tidyverse)

# Read the dataset
uga_sports_history <- read_csv("uga_sports_history.csv")
uga_sports_history <- read_csv("/Users/katherineaireland/Downloads/uga_sports_history.csv")
# View the first few rows of the dataset
head(uga_sports_history)

###basic data manipulation with dplyr
#install.packages("dplyr")
library(dplyr)

#filtering
football_games <- uga_sports_history %>%
  filter(Sport == "Football")
View(selected_data)
#select specific columns
selected_data <- uga_sports_history %>%
  select(Date, Sport, Outcome)

#mutate data
uga_sports_history <- uga_sports_history %>%
  mutate(score_diff = UGA_Score - Opponent_Score)

#TEST THIS ONE BEFORE TOMORROW!
uga_sports_history <- uga_sports_history %>%
  mutate(win_margin = abs(score_diff))
View(uga_sports_history)
#arrange data
sorted_data <- uga_sports_history %>%
  arrange(Date)

#summarize data
summary_stats <- uga_sports_history %>%
  summarise(
    avg_uga_score = mean(UGA_Score),
    avg_opponent_score = mean(Opponent_Score)
  )
View(summary_stats)
###visualize data with ggplot!
#install.packages("ggplot2")
library(ggplot2)

#plot win rate by sport
sports_summary <- uga_sports_history %>%
  group_by(Sport) %>%
  summarise(
    total_games = n(),
    win_rate = mean(Outcome == "Win")
  )

ggplot(sports_summary, aes(x = Sport, y = win_rate)) +
  geom_col(fill = "blue") +
  labs(title = "Win Rate by Sport", x = "Sport", y = "Win Rate") +
  theme_minimal()

#plot performance over time
uga_sports_history <- uga_sports_history %>%
  mutate(Year = lubridate::year(Date))

performance_by_year <- uga_sports_history %>%
  group_by(Year) %>%
  summarise(avg_score_diff = mean(score_diff))

ggplot(performance_by_year, aes(x = Year, y = avg_score_diff)) +
  geom_line(color = "red") +
  geom_point() +
  labs(title = "UGA Sports Performance Over Time", x = "Year", y = "Average Score Difference") +
  theme_minimal()

###reading and writing data
#reading in
#uga_sports_history <- read_csv("uga_sports_history.csv")
###Note: there are several options/alternatives for specifying the file path(s),
###depending on your OS (operating system),the full file path will be specified differently:
#for mac: read.csv("C:\\Users\\username\\Documents\\uga_sports_history.csv")
#for pc: read.csv("C:\\Users\\username\\Documents\\uga_sports_history.csv")

#A bit more about directories: the full path is specified
#in the above examples for mac and for pc, but the uga_sports_history
#object is currently defined by a relative file path.
#getwd() (get working directory)
#setwd()


#writing data
write_csv(uga_sports_history, "uga_sports_history_modified.csv")