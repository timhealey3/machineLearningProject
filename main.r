# Machine Learning Project
# read in data - split between pages
library(readxl)
excel_file <- "C:/Users/avhea/Downloads/use_energy_source.xlsx"
coal <- read_excel(excel_file, sheet = "Coal")
gas <- read_excel(excel_file, sheet = "Natural Gas")
petro <- read_excel(excel_file, sheet = "Petroleum")
nuclear <- read_excel(excel_file, sheet = "Nuclear")
renew <- read_excel(excel_file, sheet="Total Renewable Energy")
# clean data

fixed_data <- function(df) {
  cleaned_df <- na.omit(df)
  colnames(cleaned_df) <- cleaned_df[1,]
  cleaned_df <- cleaned_df[-1, ] 
}

coal <- fixed_data(coal)
gas <- fixed_data(gas)
petro <- fixed_data(petro)
nuclear <- fixed_data(nuclear)
renew <- fixed_data(renew)

# Linear Regression
