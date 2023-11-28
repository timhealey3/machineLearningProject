# Machine Learning Project
# read in data - split between pages
library(readxl)
excel_file <- "C:/Users/avhea/Downloads/use_energy_source.xlsx"
coal <- read_excel(excel_file, sheet = "Coal")
gas <- read_excel(excel_file, sheet = "Natural Gas")
petro <- read_excel(excel_file, sheet = "Petroleum")
nuclear <- read_excel(excel_file, sheet = "Nuclear")
renew <- read_excel(excel_file, sheet="Total Renewable Energy")
