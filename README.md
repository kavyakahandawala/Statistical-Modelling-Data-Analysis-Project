# 📈 Service Timeliness and Customer Satisfaction Analysis

**An R-Based Statistical Modelling Project for Hospitality Service Performance Evaluation**

---

## Overview

Customer satisfaction is a critical success factor in the tourism and hospitality industry. Service providers are expected to respond quickly to customer requests while maintaining a comfortable environment for guests.

This project applies statistical modelling and predictive analytics techniques to investigate how service response time and environmental conditions influence customer satisfaction scores. Using a real-world tourism accommodation dataset, multiple statistical methods were employed to identify significant factors affecting customer perceptions and service quality.

---

## Research Focus

The analysis was designed to examine the following research question:

> Does faster service delivery improve customer satisfaction and confidence in hospitality services?

The study evaluates the relationship between service timeliness and customer perception while considering additional environmental variables that may influence the customer experience.

---

## Objectives

* Analyze customer satisfaction patterns within tourism accommodations.
* Measure the impact of service response time on perceived service quality.
* Identify environmental factors associated with customer satisfaction.
* Perform hypothesis testing to validate statistical relationships.
* Develop predictive models capable of estimating customer satisfaction levels.
* Evaluate model performance using standard regression metrics.

---

## Dataset Description

The project utilizes a tourism accommodation dataset containing operational, environmental, and customer-related information collected from hospitality environments.

### Dataset Summary

| Category               | Details               |
| ---------------------- | --------------------- |
| Domain                 | Tourism & Hospitality |
| Data Source            | Kaggle                |
| Original Records       | ~3000                 |
| Records After Cleaning | 2957                  |
| Analysis Platform      | R & RStudio           |

### Selected Features

| Feature                   | Purpose                       |
| ------------------------- | ----------------------------- |
| service_quality_score     | Target variable               |
| service_response_time_min | Service efficiency indicator  |
| noise_level_db            | Environmental quality measure |
| air_quality_index         | Indoor comfort indicator      |
| motion_detected           | Occupancy activity signal     |
| door_open                 | Room accessibility status     |
| temperature               | Environmental condition       |
| humidity                  | Environmental condition       |

---

## Data Preparation

Before analysis, several preprocessing procedures were performed to improve data quality and model reliability.

### Data Cleaning

* Removed incomplete records
* Eliminated duplicate observations
* Checked data consistency
* Identified and handled outliers using the Interquartile Range (IQR) technique

### Feature Transformation

Additional categorical groups were created to support comparative analysis:

#### Service Timeliness Categories

* Fast Response
* Moderate Response
* Slow Response

#### Environmental Noise Categories

* Quiet Environment
* Moderate Environment
* High Noise Environment

---

## Exploratory Analysis

Exploratory Data Analysis (EDA) was conducted to understand patterns, distributions, and relationships within the dataset.

Key areas examined include:

* Distribution of customer satisfaction scores
* Service response time patterns
* Environmental quality indicators
* Correlation among numerical variables
* Customer satisfaction trends across service categories

---

## Statistical Findings

### Correlation Analysis

Correlation analysis revealed that service response time has one of the strongest relationships with customer satisfaction.

#### Major Insights

* Longer response times are associated with lower satisfaction levels.
* Poor air quality contributes to reduced customer ratings.
* Higher noise levels negatively affect perceived service quality.
* Several environmental variables exhibit weaker relationships with satisfaction scores.

---

## Hypothesis Testing

Statistical hypothesis testing was conducted to determine whether selected variables significantly influence customer satisfaction.

### Results

| Variable Tested  | Outcome                       |
| ---------------- | ----------------------------- |
| Motion Detection | Statistically Significant     |
| Door Status      | Not Statistically Significant |

The findings indicate that customer satisfaction varies significantly with occupancy-related activity but not with door status.

---

## Analysis of Variance (ANOVA)

ANOVA was applied to compare customer satisfaction across different service and environmental groups.

### Significant Factors

| Group Variable              | Significance |
| --------------------------- | ------------ |
| Service Timeliness Category | p < 0.001    |
| Noise Category              | p < 0.001    |

These results demonstrate meaningful differences in customer satisfaction across response-time and environmental conditions.

---

## Predictive Modelling

To estimate customer satisfaction scores, regression-based predictive models were developed.

### Simple Linear Regression

A baseline model was created using service response time as the primary predictor.

**Performance**

* R² = 0.36

### Multiple Linear Regression

A more comprehensive model was built using operational and environmental variables.

**Performance**

* R² = 0.884

### Most Influential Predictors

* Service Response Time
* Air Quality Index
* Noise Level
* Motion Detection Activity

The multiple regression model explained a substantial proportion of variation in customer satisfaction.

---

## Model Validation

Model accuracy was assessed using Root Mean Square Error (RMSE).

| Evaluation Metric | Value |
| ----------------- | ----- |
| RMSE              | 6.76  |

The model demonstrated strong predictive performance and acceptable error levels for customer satisfaction estimation.

---

## Business Implications

The findings provide practical insights for hospitality service providers:

* Reducing response times can significantly improve customer perceptions.
* Maintaining quieter environments contributes to higher satisfaction.
* Monitoring air quality may enhance guest experience.
* Operational efficiency should be prioritized as a key customer-retention strategy.

---

## Technologies and Tools

* R Programming Language
* RStudio
* Tidyverse
* dplyr
* ggplot2
* caret
* stats

---

## Conclusion

This project demonstrates that service responsiveness plays a critical role in shaping customer satisfaction within hospitality environments.

Statistical testing and predictive modelling consistently show that faster service responses are associated with improved customer confidence and higher service quality ratings. Environmental conditions such as noise levels and air quality also contribute to customer perceptions, though service timeliness remains the strongest predictor.

The results support the conclusion that improving operational responsiveness can lead to measurable improvements in customer satisfaction outcomes.

---

