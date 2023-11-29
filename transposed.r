# Machine Learning Project
# read in data - split between pages
library(readxl)
library(dplyr)
library(tidyr)
excel_file <- "C:/Users/avhea/Downloads/USA_production.xlsx"
production <- read_excel(excel_file, sheet = "Data")
# clean data
production <- na.omit(production)
# important MSN:
# CLPRB Coal Production - Billion Btu
df <- production %>%
  filter(MSN == "CLPRB") %>%
  select(StateCode, `1960`:`2021`)
# Transpose the dataframe
flipped_df <- as.data.frame(t(df[, -1]))  # Transpose the data, excluding the StateCode column
colnames(flipped_df) <- df$StateCode
rownames(flipped_df) <- names(df)[-1]  # Use the year columns as row names
flipped_df <- data.frame(Year = row.names(flipped_df), flipped_df, row.names = NULL)
#production_coal$StateCode
#lm.fit <- lm(production_coal$StateCode ~ production_coal$'1960', data=production_coal)
# PAPRB Crude Oil production - Billion Btu
production_oil <- production %>%
  filter(MSN == "PAPRB") %>%
  select(StateCode, `1960`:`2021`)
head(production_oil)
# REPRB Renewable Energy prododuction - Billion btu
production_renew <- production %>%
  filter(MSN == "REPRB") %>%
  select(StateCode, `1960`:`2021`)
head(production_renew)
combined_production <- merge(production_coal, production_oil, by = "StateCode", suffixes = c("_coal", "_oil"))
production_data <- merge(combined_production, production_renew, by = "StateCode")

# Display the combined production data
# Assuming 'production_data


# Linear Regression


# linear regression for CLPRB
# Alaska AK


# responder = consumption and predictor = year
# predict the states future coal consumption based on year
