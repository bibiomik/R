## transform nycflights13

library(nycflights13)
library(openintro)
library(tidyverse) # dplr

## ask 5 questions about this data set
data("flights")
data("airlines")

## select, filter, arrange, summarise, count
----------------------------------------------------------------------------------------
## Q1. most flight carrier in Sep 2013
View(flights)
flights %>%
  filter(month == 9, year == 2013) %>%
  count(carrier) %>%
  arrange(desc(n)) %>%
  head(5) %>%
  left_join(airlines)

## Q2. Top 5 airlines the highest average arrival delay in 2013
flights %>%
  filter(year == 2013, arr_delay > 0) %>%
  group_by(carrier) %>%
  summarise(avg_arrdelay = mean(arr_delay)) %>%
  arrange(desc(avg_arrdelay)) %>%
  inner_join(airlines, by="carrier") %>%
  select(name, avg_arrdelay) %>%
  head(5)

## Q3. Find the carrier with the longest distance? average time spent in the air?
flights %>%
  filter(!is.na(dep_time)) %>%
  left_join(airlines, by="carrier") %>%
  group_by(name,carrier) %>%
  summarise(mile_dist = max(distance),
            avg_air_time = mean(air_time)) %>%
  arrange(desc(mile_dist)) %>%
  head(1)

## Q4. Top 5 carrier with the highest departure time
flights %>%
  filter(dep_delay > 0 & !is.na(dep_delay)) %>%
  group_by(carrier) %>%
  summarise(avg_mins_delay = mean(dep_delay)) %>%
  head(5) %>%
  left_join(airlines, by="carrier")

## Q5. airlines services in 2013
flights %>%
  filter(year == 2013) %>%
  count(carrier) %>%
  arrange(desc(n)) %>%
  inner_join(airlines, by="carrier") %>%
  select(name, n)
