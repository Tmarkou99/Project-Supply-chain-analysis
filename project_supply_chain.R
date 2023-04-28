########## libraries
library(tidyverse)
library(dplyr)
library(ggplot2)
library(psych)
library(lmtest)
library(readr)
library(factoextra)
data <- read_csv("data.csv")


########## Data Exploration
names(data)

data <- data %>% rename(price = "Price")
data <- data %>% rename(type = `Product type`)
data <- data %>% rename(sold = `Number of products sold`)
data <- data %>% rename(code = "SKU")
data <- data %>% rename(available = "Availability")
data <- data %>% rename(revenue = `Revenue generated`)
data <- data %>% rename(customer_demo = `Customer demographics`)
data <- data %>% rename(stock = `Stock levels`)
data <- data %>% rename(production_cost = `Manufacturing costs`)
data <- data %>% rename(carrier = `Shipping carriers`)


boxplot(data$Costs)
boxplot(data$production_cost)
summary(data$Costs)
unique(data$Routes)
unique(data$`Supplier name`)

table(data$type)

products_per_type <- table(data$type)

products_per_type <- data.frame(products_per_type)

data %>% 
  filter(!complete.cases(.)) %>% 
  View() # i see that my data set is balanced 

########## Data clean
data <- data %>% 
  mutate(carrier = recode(carrier, 
                          "Carrier A" = 1,
                          "Carrier B" = 2,
                          "Carrier C" = 3))
data <- data %>% 
  mutate(Routes = recode(Routes, 
                          "Route A" = 1,
                          "Route B" = 2,
                          "Route C" = 3))

data <- data %>% 
  mutate(`Supplier name` = recode(`Supplier name`, 
                          "Supplier 1" = 1,
                          "Supplier 2" = 2,
                          "Supplier 3" = 3,
                          "Supplier 4" = 4,
                          "Supplier 5" = 5))

table(data$"Transportation modes")
table(data$Routes)

cosmetics <- data %>% 
  filter(type == "cosmetics")

skincare <- data %>% 
  filter(type == "skincare")

haircare <- data %>% 
  filter(type == "haircare")

mumbai <- data %>% 
  filter(Location == "Mumbai")

kolkata <- data %>% 
  filter(Location == "Kolkata")

delhi <- data %>% 
  filter(Location == "Delhi")

bangalore <- data %>% 
  filter(Location == "Bangalore")

chennai <- data %>% 
  filter(Location == "Chennai")




# most expensive product
data %>% 
  filter(price == max(price)) %>% 
  View()


# most profitable product
data %>% 
  filter(revenue == max(revenue)) %>% 
  View()


########## Data Analysis
# 1) The best/worst route for different categories with subset-1


subset1 <- data %>% # taking account all the variables
  select(`Shipping times`,`Shipping costs`,`Transportation modes`,Routes, carrier, Location)

cost_effctv <- subset1 %>%
  mutate(effectiveness = `Shipping costs`/`Shipping times`) %>%
  group_by(Location) %>% # to see the effectiveness in every Location
  summarize(mean_effectiveness = mean(effectiveness)) 

View(cost_effctv)



route_effctv <- subset1 %>%
  mutate(effectiveness = `Shipping costs`/`Shipping times`) %>%
  group_by(Routes) %>% # to see the effectiveness in every Route
  summarize(mean_effectiveness = mean(effectiveness))

View(route_effctv)

transport_effctv <- subset1 %>%
  mutate(effectiveness = `Shipping costs`/`Shipping times`) %>%
  group_by(`Transportation modes`) %>% # to see the effectiveness in every Transport mode
  summarize(mean_effectiveness = mean(effectiveness))

View(transport_effctv)


# So, we see that based on the cost and time the most efficient route
#is the No3 because on average seems more efficient 

# testing the correlation between variables
cor(subset1[, c("Shipping costs", "Shipping times",  "Routes")])



# Using a box plot we see some outliers, so let's investigate them.
ggplot(subset1, aes(x = `Transportation modes`, y = `Shipping costs`/`Shipping times`),) +
  geom_point() +
  geom_boxplot()+
  labs(x = "Transportation modes", y = "Effectiveness")


## investigating the outliers

outliers_test <- subset1 %>% 
  mutate(effectiveness = `Shipping costs`/`Shipping times`) %>% 
  filter(effectiveness < 2) %>% 
  group_by(`Transportation modes`)

describe(outliers_test$effectiveness)
boxplot(outliers_test$effectiveness)

ggplot(outliers_test, aes(x = `Transportation modes`, y = `Shipping costs`/`Shipping times`),) +
  geom_point() +
  geom_boxplot()+
  labs(x = "Transportation modes", y = "Effectiveness") # we see that the outliers are gone


# 2) Clustering similar products for Kolkata
# based on price, sales, revenue, defect rates using subset2

subset2 <- kolkata %>% 
  select( type, price, sold, revenue)

cluster1 <- hclust(dist(subset2[, -1]), method = "ward.D2")

clusters <- cutree(cluster1, k = 3)

# adding cluster assignment to subset2 data frame
subset2$cluster <- factor(clusters, labels = c("Cluster 1", "Cluster 2", "Cluster 3"))

# exclude non-numeric columns before passing to fviz_cluster
fviz_cluster(list(data = subset2[, -c(1, 5)], cluster = subset2$cluster), 
             geom = "point", 
             main = "Cluster visualization")

