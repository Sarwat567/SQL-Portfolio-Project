CREATE DATABASE Churn_Analysis;

USE Churn_Analysis;
Show tables;

DESCRIBE ibm_churn_analysis;
-- Query 1: Considering the top 5 groups with the highest average monthly charges among churned customers, how can personalized offers be tailored based on age, gender, and contract type to potentially improve customer retention rates?

SELECT 
    age, 
    gender, 
    contract, 
    AVG(`Monthly Charge`) AS avg_monthly_charges
FROM 
    ibm_churn_analysis
WHERE 
    `Churn Label` = 'Yes'
GROUP BY 
    age, gender, contract
ORDER BY 
    avg_monthly_charges DESC
LIMIT 5;
-- Analysis ans Implementation of strategies
-- In the below table following is the group of male gender, including average monthly charges which are personalized offers aimed at improving customer retention rates.
-- According to age whcih show maturity and contract we can suggest the personalized offers and strategies for improving customer retention rates in future.
-- Several offers can be made base on the Loyalty with the company, health and welfare pacakage, Free primium features trails, contract upgrade incentives, feedbackloop.

-- Query 2:  What are the feedback or complaints from those churned customers?


DESCRIBE ibm_churn_analysis;
SELECT 
    `Customer ID`, 
    `Contract` AS contract_type, 
    `Monthly Charge`, 
    `Churn Label`, 
    `Churn Reason`
FROM 
    ibm_churn_analysis
WHERE 
    `Churn Label` = 'Yes' 
    AND `Churn Reason` IS NOT NULL;
    
    -- Analysis of Question no 2.
-- In the following Churn analysis in contract type 'month to month contract' is more likely to churn than compared to one-year or two year contract. as they have more flexibility to leave without penalities. 
-- Customers on shorter contract are more 'month to month' are more likely to get more benefits and offers. 
-- Customers with higher charges may expect more value from the service.  If the churn reason suggests dissatisfaction with the service or pricing, it would be useful to implement special pricing plans,
-- discounts, or offer value-added services for high-paying customers to reduce churn rates.
    
    
-- Question 3: 
SELECT 
    `Payment Method`, 
    COUNT(`Customer ID`) AS total_customers, 
    SUM(CASE WHEN `Churn Label` = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(SUM(CASE WHEN `Churn Label` = 'Yes' THEN 1 ELSE 0 END) / COUNT(`Customer ID`) * 100, 2) AS churn_rate_percentage
FROM 
    ibm_churn_analysis
GROUP BY 
    `Payment Method`
ORDER BY 
    churn_rate_percentage DESC;
    
--  Analysis of Question no 3 
-- Payment methods are associated with higher or lower churn rates. 
--  Discounts or incentives for customers using high-churn payment methods to shift to more reliable or cost-effective options. 