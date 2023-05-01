########################### Libraries
library(tidyverse)
library(dplyr)
library(ggplot2)
library(psych)
library(lmtest)
library(readr)
library(factoextra)
library(MASS) # needed for the stepAIC function
library(tidyr)
library(forcats)
library(lmtest)
library(AIC)

data <- read_csv("data.csv")




########################### Data Exploration
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





########################### Data clean
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






########################### 1. Efficient Routes
# 1.1 The best/worst route for different categories with subset-1

unloadNamespace("MASS") # it causing some issues so we deactivate this package temporary

subset1 <- data %>% # taking account all the variables
  select(`Shipping times`,`Shipping costs`,`Transportation modes`,Routes, carrier, Location)
names(subset1)


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
result1 <- cor(subset1[, c("Shipping costs", "Shipping times",  "Routes")])
result1 <- as.table(result1)
result1



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


########################### 2. Clustering similar products for Kolkata
# 2.1 Based on price, sales, revenue,type using subset2

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





########################### 3. Demographic analysis

# 3.1 Customer demographic analysis (which type of product the different genders buy most)

unique(data$customer_demo)
table(data$customer_demo)

subset3 <- data %>% 
  mutate ( gender = recode( customer_demo,
          "Male" = "male",
          "Female" = "female",
          "Uknown" = "uknown",
          "Non-binary" = "both")) %>% 
  select(type, price, gender , revenue, Location) # (the data.frame for demographic analysis)

table(subset3$gender)
names(subset3)
size_sum(subset3)






# this table shows the percentage of the different customer demographics emphasizing:

#in the type of the product (1=product)
demog_type1 <- round(addmargins(
    prop.table(table(subset3$gender,subset3$type),1)*100,2),1)

demog_type1                               #the table that's in % sales by gender
size_sum(demog_type1)
demog_type1 <- as.data.frame(demog_type1) #it needs to be a data.frame


#in the Location (2=location)
demog_type2 <- round(addmargins(
  prop.table(table(subset3$gender, subset3$Location),2)*100,1),2) 

demog_type2
size_sum(demog_type2)
demog_type2 <- as.data.frame(demog_type2) #it needs to be a data.frame


# Changing the stracture of the demog_types and combining them

demog_type3 <- demog_type1 %>%  as.data.frame()  # Convert to a data frame

demog_type3


# reformating the table to show exactly each gender's preferences (3 = in % buyers by gender)
demog_type3 %>% 
  rename( gender = "Var1", type = "Var2", percent = "Freq") %>% 
  group_by(type) %>% 
  pivot_wider(names_from = "type" , values_from = "percent") 


demog_type3 # the data.frame in % by gender and type of product


result2 <- demog_type3 %>% 
  rename(gender = "Var1") %>% 
  filter(Freq != 100) %>% 
  group_by(gender) %>% 
  summarize(preferes = Var2[Freq == max(Freq)], 
            percentage = max(Freq))

View(result2) # Here we see the preferences in type of products by gender.


# 3.2 The location that sells the most "haircare" products to "males"
#we use the subset3 
View(subset3)
subset3
table(subset3$Location) # how many products sold by every location

total_males <- data %>% 
  filter(customer_demo == "Male") %>% 
  nrow()

result3 <- subset3 %>%     
  group_by(Location) %>%
  filter(gender == "male" & type == "haircare") %>% 
  summarise(sold = n(),
            percent = (sold/total_males)*100) %>% 
  arrange()

result3           # it is the Bangalore


# 3.3 the distribution of the products sold in every Location
#we will use the subset3 data.frame


total_prod <- subset3 %>% 
  nrow() # the total number of products is 100

subset3 <- data %>% 
  mutate ( gender = recode( customer_demo,
                            "Male" = "male",
                            "Female" = "female",
                            "Uknown" = "uknown",
                            "Non-binary" = "both")) %>% 
  select(type, price, gender , revenue, Location, sold) # (adding the sold to the data.frame)

names(subset3)

products_per_location <- as.data.frame(table(subset3$Location))
products_per_location <- products_per_location  %>%  rename(Location = "Var1") # renaming the Var1 to Location
products_per_location        # Checking that stracture of the table

result3 <- subset3 %>% 
  group_by(Location,type) %>% 
  summarise(number = n()) %>% 
  pivot_wider(names_from = type, values_from = number) %>% 
  inner_join(products_per_location, by = "Location")
  
result3                      # Checking the inner_join output for wrong values or output

result3 <- result3 %>%
  pivot_longer(cols = cosmetics:skincare, names_to = "type", values_to = "count") %>%
  group_by(type) %>%
  slice_max(count) %>%   #This Function extract rows with the maximum values of a particular column or columns
  ungroup() %>% 
  mutate( percentage = (count/Freq)*100) %>% 
  select(type, Location, total = "Freq" , count , percentage )

  
View(result3) 
  

############################ # Cost analysis
# 4.1 The most expensive Location by average cost per product
table(data$type)

subset4 <- data %>%       # Πρώτα να το δω χωρίς το recode
  #mutate(type = recode(type, skincare = 1, haircare = 2, cosmetics = 3)) %>%  #it need the library(forcats)
  select(Location, type, price, `Shipping costs`, production_cost , Costs, `Production volumes`, 
         `Shipping times`)

subset4  

result4 <- subset4 %>% 
  mutate(avg_cost = (`Shipping costs` + production_cost + Costs)/3) %>% 
  group_by(Location) %>% 
  summarise(mean_cost = round(mean(avg_cost),2)) %>% 
  arrange(desc(mean_cost))

result4

View(result4) # The average cost per location, we see that the Chennai is the most expensive.


subset4 <- subset4 %>%     #adding the average cost per product
  mutate(avg_cost = (`Shipping costs` + production_cost + Costs)/3) 

# 4.2 how does the different variables effect the average cost per product

names(subset4)
names(data)

model1 <- lm(formula = production_cost ~  Location + type + Costs + `Production volumes` +
               `Shipping costs` + `Shipping times` , data = subset4)

hist(model1$residuals)
boxplot(model1$residuals)
summary(model1)  # summarizing the first model to see the coefficients between cost variables.


stepAIC(model1) # this test suggests the formula in result4.1

result4.1 <- summary(lm(formula = production_cost ~ Location , data = subset4))
result4.1




