setwd("C:\\Users\\Pamod Pannigala\\Desktop\\TPSM - AC")

getwd()

install.packages("ggplot2")
install.packages("dplyr")
install.packages("corrplot")
install.packages("psych")
install.packages("tidyr")
install.packages("car")

library(ggplot2)
library(dplyr)
library(corrplot)
library(psych)
library(tidyr)
library(car)

#load dataset
data <- read.csv("tourism_accommodation_dataset.csv")

View(data)
head(data)

#rows count
nrow(data)

str(data)

#====================DATA CLEANING============================

#check missing values
colSums(is.na(data))


#check negative values
sapply(data[, sapply(data, is.numeric)], function(x) any(x < 0))

#check duplicates
sum(duplicated(data))

#check outliers
find_outliers <- function(x) {
  q1 <- quantile(x, 0.25, na.rm = TRUE)
  q3 <- quantile(x, 0.75, na.rm = TRUE)
  iqr <- q3 - q1
  lower <- q1 - 1.5*iqr
  upper <- q3 + 1.5*iqr
  which(x < lower | x > upper)
}


outlier_counts <- sapply(data[, sapply(data, is.numeric)], function(x) {
  length(find_outliers(x))
})
print(outlier_counts)

length(find_outliers(data$service_quality_score))
length(find_outliers(data$service_response_time_min))

#check data types
str(data)

# Categorical variables convert into Factor
data$room_id <- as.factor(data$room_id)
data$motion_detected <- as.factor(data$motion_detected)
data$door_open <- as.factor(data$door_open)


#===================Add 2 New Columns in to data set===================

# 1.Create Timeliness_Group Column (High / Medium / Low)
data <- data %>%
  mutate(Timeliness_Group = case_when(
    service_response_time_min <= 15 ~ "High",
    service_response_time_min > 15 & service_response_time_min <= 40 ~ "Medium",
    TRUE ~ "Low"
  ))

# 2.Create Noise_Group (Quiet / Moderate / Noisy)
data <- data %>%
  mutate(Noise_Group = case_when(
    noise_level_db <= 40 ~ "Quiet",
    noise_level_db > 40 & noise_level_db <= 70 ~ "Moderate",
    TRUE ~ "Noisy"
  ))

# 3. Convert into factors and order into levels
data$Timeliness_Group <- factor(data$Timeliness_Group, 
                                levels = c("High", "Medium", "Low"))
data$Noise_Group <- factor(data$Noise_Group, 
                           levels = c("Quiet", "Moderate", "Noisy"))

#check group sizes
table(data$Timeliness_Group)
table(data$Noise_Group)


# ====================================Descriptive Analysis==========================================

#1.Descriptive Analysis for Factors

#Make Frequency Table for Factors(Categorical Variables)

table(data$motion_detected)       # 0/1
table(data$door_open)             # 0/1
table(data$Timeliness_Group)      # High / Medium / Low
table(data$Noise_Group)           # Quiet / Moderate / Noisy

# Percentage (%)
prop.table(table(data$motion_detected)) * 100
prop.table(table(data$door_open)) * 100
prop.table(table(data$Timeliness_Group)) * 100
prop.table(table(data$Noise_Group)) * 100

#2.Descriptive Analysis for Numerical Fields

# summary statistic
summary(data[, c("service_quality_score", 
                 "service_response_time_min", 
                 "temperature_c", 
                 "humidity_percent", 
                 "noise_level_db", 
                 "light_intensity_lux", 
                 "air_quality_index", 
                 "water_usage_liters", 
                 "electricity_usage_watts", 
                 "service_request_count")])

#Sd find

sapply(data[, c("service_quality_score", "service_response_time_min",
                "temperature_c", "humidity_percent", "noise_level_db", 
                "light_intensity_lux", "air_quality_index", 
                "water_usage_liters", "electricity_usage_watts", 
                "service_request_count")], sd, na.rm=TRUE)


#==========================Data Visualization Part============================

#Graph1 -  Scatter Plot – Response Time vs Confidence
ggplot(data, aes(x = service_response_time_min, y = service_quality_score)) +
  geom_point(alpha = 0.3, color = "steelblue") +
  geom_smooth(method = "lm", se = TRUE, color = "red") +
  labs(title = "Response Time vs Customer Confidence",
       x = "Service Response Time (minutes)",
       y = "Service Quality Score") +
  theme_minimal()

#Graph2 - Histogram – Distribution of Service Quality Scores by Timeliness
ggplot(data, aes(x = service_quality_score, fill = Timeliness_Group)) +
  geom_histogram(alpha = 0.6, position = "identity", bins = 30, color = "white") +
  scale_fill_manual(values = c("High" = "#66C2A5", "Medium" = "#FC8D62", "Low" = "#8DA0CB")) +
  labs(title = "Distribution of Service Quality Score by Timeliness Level",
       x = "Service Quality Score",
       y = "Frequency") +
  theme_minimal(base_size = 14)


#Graph 3 – Box Plot (External: Noise Group)
ggplot(data, aes(x = Noise_Group, y = service_quality_score, fill = Noise_Group)) +
  geom_boxplot() +
  scale_fill_manual(values = c("Quiet" = "#66C2A5", "Moderate" = "#FC8D62", "Noisy" = "#8DA0CB")) +
  labs(title = "Customer Confidence by Noise Level (External Factor)",
       x = "Noise Group",
       y = "Service Quality Score") +
  theme_minimal(base_size = 14) +
  theme(legend.position = "none")

#================================Inferential Analysis===========================

#Hypothesis Testing

# ===================1.Pearson Corelation Test
cor.test(data$service_response_time_min, data$service_quality_score, method = "pearson")

#====================2. Simple Linear Regression model
model_simple <- lm(service_quality_score ~ service_response_time_min, data = data)

# Model summary 
summary(model_simple)

#====================3.One-way Anova

# 3.1 -service_quality_score ~ Timeliness_Group

model_aov <- aov(service_quality_score ~ Timeliness_Group, data = data)

# ANOVA table view
summary(model_aov)

# Post-hoc test (The difference in within which categories)
TukeyHSD(model_aov)


# 3.2 -service_quality_score ~ Timeliness_Group

# Noise_Group ANOVA
noise_aov <- aov(service_quality_score ~ Noise_Group, data = data)
summary(noise_aov)
TukeyHSD(noise_aov)


# ==========================4.t - test

# 4.1 - T-test: door_open vs service_quality_score
t_door <- t.test(service_quality_score ~ door_open, data = data)
print(t_door)

# 4.2 - T-test: motion_detected vs service_quality_score
t_motion <- t.test(service_quality_score ~ motion_detected, data = data)
print(t_motion)

# ===========================5.Multiple Regression

model_full <- lm(service_quality_score ~ service_response_time_min + 
                   temperature_c + humidity_percent + noise_level_db + 
                   light_intensity_lux + air_quality_index + 
                   water_usage_liters + electricity_usage_watts + 
                   service_request_count + door_open + motion_detected, 
                 data = data)

summary(model_full)




model_full <- lm(service_quality_score ~ service_response_time_min + 
                   temperature_c + humidity_percent + noise_level_db + 
                   light_intensity_lux + air_quality_index + 
                   water_usage_liters + electricity_usage_watts + 
                   service_request_count + door_open + motion_detected, 
                 data = data)

vif(model_full)

# Key variables model
model_simple <- lm(service_quality_score ~ service_response_time_min + 
                     noise_level_db + door_open + motion_detected + 
                     service_request_count, data = data)

# Compare
summary(model_simple)$adj.r.squared
summary(model_full)$adj.r.squared


#Corelation Matrix -for external factors

library(corrplot)
num_cols <- data[, sapply(data, is.numeric)]
cor_mat <- cor(num_cols)
corrplot(cor_mat, method = "color", type = "upper", tl.cex = 0.6,
         title = "Correlation Matrix of Numerical Variables")

# get only numeric columns 
num_cols <- data[, sapply(data, is.numeric)]

# Correlation Matrix
cor_mat <- cor(num_cols)


print(round(cor_mat, 2))

