# Project-Supply-chain-analysis

---
title: "README"
author: "Theodoros Markou"
---

# Tasks

1.  **Cluster analysis** for similar products based on characteristics such as price, lead time, defect rates, production cost etc. by country. `done`

2.  **Sales and revenue analysis**: You could use the sold, Price, and Revenue generated variables to analyze sales trends over time, identify the most profitable products, and optimize pricing strategies. `done`

3.  **Supply chain performance analysis**: You could analyze the Availability, Lead times, Order quantities, Shipping times, and Shipping costs variables to assess the performance of your supply chain, identify bottlenecks, and optimize your ordering and inventory management processes.

4.  **Customer demographics analysis**: You could use the Customer demographics variable to analyze the characteristics of your customer base and identify opportunities to target specific segments with tailored marketing messages or products. `done`

5.  **Manufacturing analysis**: You could analyze the Production volumes, Manufacturing lead time, Manufacturing costs, Inspection results, and Defect rates variables to optimize your manufacturing processes, reduce defects, and improve product quality. `done`

6.  **Logistics analysis**: You could analyze the Transportation modes, Routes, and Costs variables to optimize your logistics operations, reduce transportation costs, and improve delivery times. `in progress`

7.  **Supplier analysis**: You could use the Supplier name, Location, and Lead time variables to analyze the performance of your suppliers, identify opportunities to optimize your supplier network, and negotiate better pricing and terms.

8.  **Inventory analysis**: You could analyze the Stock levels, Availability, and Order quantities variables to optimize your inventory management processes, reduce stockouts, and minimize waste.

9.  **Shipping carrier analysis**: You could use the Shipping carriers, Shipping times, and Shipping costs variables to analyze the performance of your shipping carriers, identify opportunities to reduce shipping costs, and optimize your shipping processes. `done`

10. Product analysis: You could analyze the Price, Revenue generated, and Customer demographics variables to identify your top-selling products, optimize your product mix, and develop new products that target specific customer segments.

11. **Cost analysis**: You could use the Price, Shipping costs, Manufacturing costs, and Costs variables to perform a comprehensive cost analysis of your supply chain, identify opportunities to reduce costs, and improve your bottom line. `done`

# Notes

### Subsets / sub-data frames

1.  `Subset1` is a part of the original data-frame that contains only the Shipping times,Shipping costs,Transportation modes,Routes, carrier, Location and it used for calculating the efficiency of the transportation modes and Routes on different Countries.\

2.  `Subset2` uses variables such as price, sold , type, revenue and it used for cluster analysis to be able to see the reaction between the type of products.

3.  `Subset3` contains a customer demographic part of the original data set. 1. The output that we get using this data set is firstly the demog_type1 which shows the destribution of the buyers

    1.  `demog_type1` contains for each product type, the percentage of gender type that buys these product for example, the gender "male" buys 47.6% hair care products, 19.0% cosmetics and 33.3% buys skin care products.

                      cosmetics haircare skincare   Sum
              both         21.7     30.4     47.8 100.0
              female       40.0      8.0     52.0 100.0
              male         19.0     47.6     33.3 100.0
              Unknown      22.6     48.4     29.0 100.0

    2.  `demog_type2` contains the percentage of buyers for the locations.

                      Bangalore Chennai  Delhi Kolkata Mumbai
              both        38.89   15.00  13.33   24.00  22.73
              female      27.78   20.00  40.00   24.00  18.18
              male        27.78   20.00  20.00   20.00  18.18
              Unknown      5.56   45.00  26.67   32.00  40.91
              Sum        100.00  100.00 100.00  100.00 100.00

    3.  `demog_type3` it contains the exact same information with demog_type1 but i don't use the as.table function.

    4.  

4.  `subset4`

### Models

1.  `model1` Is the model used for finding the connection between costs and the manufacturing process.
2.  `model2` Is the improved version of model1 that "stepAIC()" function sugested
3.  `model3`

# Results

1.  `result1` It shows the correlation between shipping times, shipping costs and Routes that used for the "Route Analysis".

                       Shipping costs Shipping times      Routes
        Shipping costs     1.00000000     0.04510812  0.07157776
        Shipping times     0.04510812     1.00000000 -0.10562432
        Routes             0.07157776    -0.10562432  1.00000000

2.  `result2` It shows the type of product that each "gender" prefers and the percentage of products that buys this type of product.

          gender  preferes percentage
          <fct>   <fct>         <dbl>
        1 both    skincare       47.8
        2 female  skincare       52  
        3 male    haircare       47.6
        4 Unknown haircare       48.4

3.  `result3`

4.  `result3.1` It shows in percent, the location that sold the most for each type of product.

          type      Location  total count percentage
          <chr>     <chr>     <int> <int>      <dbl>
        1 cosmetics Mumbai       22     8       36.4
        2 haircare  Bangalore    18     9       50  
        3 skincare  Kolkata      25    13       52  

5.  `result4` shows us in order the average expenses for production in descending order. The results shows us that in average the most expensive Location is Chennai with score "225.86" and on the other hand the least expensive Location is Mumbai with score "157.11" .\
    \
    To measure the sore for the average expenses by product a the following formula used :\
    `avg_cost = (Shipping costs + Production costs + Costs)/3`\

    1.  `result4.1` shows us the summary of the model that function `steAIC()` recommended , the result agree with the `result4` because both of them shows that, in order to reduce the production cost one way is to transfer the manufacturing process in different Location.

        `The interpretation :` If you move the manufacturing process in for example Mumbai which is the least expensive location, you reduce the production costs by "25.264" (having all the other parameters at the same place)\

        It's worth noting that the standard errors for the coefficients are relatively large compared to their estimates, which may indicate that the sample size is small or that there is a large amount of variation in the data.

# Graphs

# Interpretation of Models

### model1 and model2 :

1.  

        ### For model1
        Coefficients:
                              Estimate Std. Error t value Pr(>|t|)    
        (Intercept)           52.50179   15.28938   3.434 0.000905 ***
        LocationChennai      -12.44069    9.71726  -1.280 0.203778    
        LocationDelhi        -14.50106   10.37912  -1.397 0.165846    
        LocationKolkata      -24.57007    9.31531  -2.638 0.009854 ** 
        LocationMumbai       -29.12654    9.68978  -3.006 0.003440 ** 
        typehaircare           1.86839    7.84762   0.238 0.812364    
        typeskincare           5.55946    7.79130   0.714 0.477374    
        Costs                 -0.01064    0.01176  -0.904 0.368354    
        `Production volumes`   0.01264    0.01167   1.084 0.281485    
        `Shipping costs`       0.76300    1.14655   0.665 0.507466    
        `Shipping times`       0.58049    1.08714   0.534 0.594704    
        ---
        Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

        Residual standard error: 28.67 on 89 degrees of freedom
        Multiple R-squared:   0.12, Adjusted R-squared:  0.02116 
        F-statistic: 1.214 on 10 and 89 DF,  p-value: 0.2931


        ### For model2
        Coefficients:
                        Estimate Std. Error t value Pr(>|t|)    
        (Intercept)       61.995      6.655   9.315 4.81e-15 ***
        LocationChennai  -10.850      9.174  -1.183  0.23988    
        LocationDelhi    -13.115      9.872  -1.329  0.18718    
        LocationKolkata  -20.132      8.729  -2.306  0.02326 *  
        LocationMumbai   -25.264      8.974  -2.815  0.00593 ** 
        ---
        Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

        Residual standard error: 28.24 on 95 degrees of freedom
        Multiple R-squared:  0.08918,   Adjusted R-squared:  0.05083 
        F-statistic: 2.325 on 4 and 95 DF,  p-value: 0.06194

The multiple R-squared measures how well the linear regression model as a whole fits the data. It ranges from 0 to 1, where 0 indicates the model explains none of the variability in the response variable, and 1 indicates the model explains all of the variability. In the first example, the multiple R-squared is 0.12, which means that the model explains 12% of the variability in the response variable.

The adjusted R-squared is a modified version of the multiple R-squared that adjusts for the number of predictors in the model. It penalizes the multiple R-squared for including predictors that do not significantly improve the model fit. A higher adjusted R-squared indicates that a larger proportion of the variability in the response variable is explained by the model, taking into account the number of predictors. In the first model, the adjusted R-squared is 0.02116, which means that the model does not explain much of the variability in the response variable after adjusting for the number of predictors.

In the second model, the multiple R-squared is 0.08918, which indicates that the model explains 8.9% of the variability in the response variable. The adjusted R-squared is 0.05083, which means that the model does not explain much of the variability in the response variable after adjusting for the number of predictors.

In both cases, the p-values of the F-statistic suggest that the model does not provide a good fit to the data, as they are greater than the typical significance level of 0.05. This means that the predictors in the model are not significantly associated with the response variable. The coefficients for the predictors indicate the expected change in the response variable for a one-unit increase in each predictor, holding all other predictors constant. **For example, in the first model, the coefficient for Location Kolkata is -24.57007, which means that we would expect the production cost to decrease by \$24.57 if the location changes from Kolkata to the reference location. However, none of the coefficients are statistically significant at the typical significance level of 0.05, so we cannot be confident that the coefficients are different from 0**

### model5 and model6

    for model5 -> 
    Call:
    lm(formula = `Defect rates` ~ type + price + available + sold + 
        revenue + stock + shipping_lead_time + `Order quantities` + 
        `Shipping times` + carrier + `Shipping costs` + `Supplier name` + 
        Location + `Lead time` + `Production volumes` + `Manufacturing lead time` + 
        production_cost + `Inspection results` + `Transportation modes` + 
        Routes + Costs, data = data)
        
     
     
    for model6 ->   
    Call:
    lm(formula = `Defect rates` ~ price + revenue + stock + `Supplier name` + 
        `Lead time`, data = data)

    Residuals:
        Min      1Q  Median      3Q     Max 
    -2.4392 -1.0676 -0.1485  0.8863  2.7856 

    Coefficients:
                      Estimate Std. Error t value Pr(>|t|)    
    (Intercept)      2.181e+00  5.540e-01   3.936 0.000159 ***
    price           -7.049e-03  4.476e-03  -1.575 0.118669    
    revenue         -7.739e-05  5.020e-05  -1.542 0.126483    
    stock           -9.478e-03  4.433e-03  -2.138 0.035131 *  
    `Supplier name`  1.589e-01  9.419e-02   1.686 0.095025 .  
    `Lead time`      5.288e-02  1.556e-02   3.399 0.000995 ***
    ---
    Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

    Residual standard error: 1.346 on 94 degrees of freedom
    Multiple R-squared:  0.1949,    Adjusted R-squared:  0.1521 
    F-statistic: 4.551 on 5 and 94 DF,  p-value: 0.0009246
    ```

This is a linear regression analysis on the relationship between defect rates and the variables price, revenue, stock, supplier name, and lead time. The analysis indicates that the lead time has a significant positive effect on the defect rate. On the other hand, the stock level has a significant negative effect on the defect rate. The other variables, price, revenue, and supplier name, do not have a significant effect on the defect rate.

The multiple R-squared value of 0.1949 means that the model can explain about 19.5% of the variation in the defect rate. The adjusted R-squared value of 0.1521 indicates that the model accounts for only 15.2% of the variation after adjusting for the number of variables. The F-statistic of 4.551 with a p-value of 0.0009246 suggests that the overall model is statistically significant. The residual standard error of 1.346 indicates the average distance between the predicted and actual values of the dependent variable.

So, one way to improve the the `defect rates` is to reduce the Lead time (the time that the product is stationary at different places) but also we see the negative relation between stock and defect rates. This can mean that, an increase of stock product can will reduce the defect rates.
