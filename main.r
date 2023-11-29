# Machine Learning Project
# read in data - split between pages
library(readxl)
library(dplyr)
library(ggplot2)
library(tidyr)
excel_file <- "C:/Users/avhea/Downloads/USA_production.xlsx"
energy_data <- read_excel(excel_file, sheet = "Data")
# transform data
energy_data <- energy_data[, c("StateCode", "MSN", "1960":"2021")]
energy_data_long <- energy_data %>%
  pivot_longer(cols = -c(StateCode, MSN), 
               names_to = "Year", values_to = "production") %>%
  mutate(Year = as.integer(Year))
# linear regression
subset_data <- energy_data_long %>%
  filter(MSN == "CLPRB" & StateCode != "US")

lm.fit <- lm(production ~ Year + StateCode, data = subset_data)
summary(lm.fit)
confint(lm.fit)

new_data <- data.frame(
  Year = c(2025, 2030, 2035),
  StateCode = rep("WI", 3)
)


prediction <- predict(lm.fit, newdata = new_data, interval = "prediction")


# plot United States energy production from 1960 to 2021
us_data_coal <- energy_data_long %>%
  filter(MSN == "CLPRB" & StateCode == "US")
us_data_oil <- energy_data_long %>%
  filter(MSN == "PAPRB" & StateCode == "US")
us_data_renew <- energy_data_long %>%
  filter(MSN == "REPRB" & StateCode == "US")
ggplot() +
  geom_point(data = us_data_coal, aes(x = Year, y = production, color = "Coal")) +
  geom_point(data = us_data_oil, aes(x = Year, y = production, color = "Crude Oil")) +
  geom_point(data = us_data_renew, aes(x = Year, y = production, color = "Renewable")) +
  labs(x = "Year", y = "Production in Btu", title = "Energy Production by Source in the United States") +
  scale_color_manual(values = c("Coal" = "blue", "Crude Oil" = "red", "Renewable" = "darkgreen"), 
                     name = "Energy Source")
