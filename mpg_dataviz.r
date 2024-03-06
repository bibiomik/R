## mpg dataset Data visualization in R

library(ggplot2)
library(dplyr)
library(tidyverse)

head(mpg)
View(mpg)

#Q1 Correlation between CTY and HWY
ggplot(mpg, aes(cty, hwy)) + 
  geom_point(color = "red", size = 2) +
  geom_smooth(method = "lm", fill = "pink") +
  theme_minimal() + 
  labs(
    title = "Relationship between CTY and HWY" ,
    x = "City miles per gallon" ,
    y = "Highway miles per gallon"
  )

#Q2 Count type of car
ggplot(mpg , aes(class, fill=class)) +
  geom_bar(color="black") +
  theme_minimal() +
  scale_fill_brewer(palette = "Blues") +
  labs(
    title = "Count Type of Car" ,
    x = "Class" ,
    y = "Amount"
 )

#Q3 In 2008, any manufacturer produced a lot of cars
selected_mpg <- mpg %>%
  filter(year == 2008) %>%
  group_by(manufacturer)

selected_mpg %>%
  count(manufacturer) %>%
  ggplot(data = .,aes(manufacturer, n, fill=n)) +
  geom_col() +
  theme_minimal() +
  labs(
    title = "In 2008, any manufacturer produced a lot of cars"
  )

#Q4 Distribution of Highway miles per gallon
ggplot(mpg, aes(hwy)) +
  geom_histogram(bins=10, fill = "red", alpha = 0.8) +
  theme_minimal() +
  labs(
    title = "Distribution of Highway miles per gallon",
    x = "Highway miles per gallon"
  )

#Q5 The type of power transmission or gearbox has an impact on fuel consumption for both city miles per gallon and highway miles per gallon.
mpg %>%
  ggplot(aes(x = trans, y = cty)) +
  geom_boxplot(aes(color = "City MPG")) +
  geom_boxplot(aes(x = trans, y = hwy, color = "Highway MPG")) +
  labs(title = "Distribution of City and Highway MPG Across Vehicle Classes",
       x = "Vehicle Class",
       y = "Miles Per Gallon") +
  theme_minimal()
