# Project-Supply-chain-analysis

---
title: "README"
author: "Theodoros Markou"
---

# Notes

### Subsets / sub-data frames 

1.  `Subset1` is a part of the original -ata frame that contains only the Shipping times,Shipping costs,Transportation modes,Routes, carrier, Location and it used for calculating the efficiency of the transportation modes and Routes on different Countries.\
2.  `Subset2`

```{=html}
<!-- -->
```
3.  `Subset3` contains a customer demographic part of the original data set. 1. The output that we get using this data set is firstly the demog_type1 which shows the destribution of the buyers

### Models

1.  `model1` Is the model used for finding the connection between costs and the manufacturing process.
2.  

# Tasks

1.  **Cluster analysis** for similar products based on characteristics such as price, lead time, defect rates, production cost etc. by country. `done`

2.  **Sales and revenue analysis**: You could use the sold, Price, and Revenue generated variables to analyze sales trends over time, identify the most profitable products, and optimize pricing strategies. `done`

3.  **Supply chain performance analysis**: You could analyze the Availability, Lead times, Order quantities, Shipping times, and Shipping costs variables to assess the performance of your supply chain, identify bottlenecks, and optimize your ordering and inventory management processes.

4.  **Customer demographics analysis**: You could use the Customer demographics variable to analyze the characteristics of your customer base and identify opportunities to target specific segments with tailored marketing messages or products. `done`

5.  **Manufacturing analysis**: You could analyze the Production volumes, Manufacturing lead time, Manufacturing costs, Inspection results, and Defect rates variables to optimize your manufacturing processes, reduce defects, and improve product quality. `in progress`

6.  **Logistics analysis**: You could analyze the Transportation modes, Routes, and Costs variables to optimize your logistics operations, reduce transportation costs, and improve delivery times.

7.  **Supplier analysis**: You could use the Supplier name, Location, and Lead time variables to analyze the performance of your suppliers, identify opportunities to optimize your supplier network, and negotiate better pricing and terms.

8.  **Inventory analysis**: You could analyze the Stock levels, Availability, and Order quantities variables to optimize your inventory management processes, reduce stockouts, and minimize waste.

9.  **Shipping carrier analysis**: You could use the Shipping carriers, Shipping times, and Shipping costs variables to analyze the performance of your shipping carriers, identify opportunities to reduce shipping costs, and optimize your shipping processes. `done`

10. Product analysis: You could analyze the SKU, Price, Revenue generated, and Customer demographics variables to identify your top-selling products, optimize your product mix, and develop new products that target specific customer segments.

11. **Cost analysis**: You could use the Price, Shipping costs, Manufacturing costs, and Costs variables to perform a comprehensive cost analysis of your supply chain, identify opportunities to reduce costs, and improve your bottom line. `done`

```{r setup, include=FALSE}

```

```{r cars}

```

```{r pressure, echo=FALSE}

```

# Results

1.  `result1`
2.  `result2`
3.  `result3`
4.  `result4` shows us in order the average expenses for production in descending order. The results shows us that in average the most expensive Location is Chennai with score "225.86" and on the other hand the least expensive Location is Mumbai with score "157.11" .\
    \
    To measure the sore for the average expenses by product a the following formula used :\
    `avg_cost = (Shipping costs + Production costs + Costs)/3`\
    1.  `result4.1` shows us the summary of the model that function `steAIC()` recommended , the result agree with the `result4` because both of them shows that, in order to reduce the production cost one way is to transfer the manufacturing process in different Location.

        `The interpretation :` If you move the manufacturing process in for example Mumbai which is the least expensive location, you reduce the production costs by "25.264" (having all the other parameters at the same place)\

        It's worth noting that the standard errors for the coefficients are relatively large compared to their estimates, which may indicate that the sample size is small or that there is a large amount of variation in the data.
