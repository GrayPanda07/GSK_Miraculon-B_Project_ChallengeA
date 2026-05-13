# Clinical Trial Data Analysis
# Author: Alexandria Noikovitch
#
# Description:
# This project analyses clinical trial and protein concentration data
# using R. The workflow includes data cleaning, BMI calculation,
# dataset merging, treatment response analysis, and visualisation.

# -----------------------------
# Install packages if needed
# -----------------------------

# install.packages("readxl")
# install.packages("dplyr")
# install.packages("ggplot2")
# install.packages("janitor")

# -----------------------------
# Load libraries
# -----------------------------

library(readxl)
library(dplyr)
library(ggplot2)
library(janitor)

# -----------------------------
# Load datasets
# -----------------------------

clinical <- read_excel("clinical-study.xlsx")
protein <- read_excel("protein-levels.xlsx")

# -----------------------------
# Inspect data
# -----------------------------

glimpse(clinical)
glimpse(protein)

# -----------------------------
# Data cleaning
# -----------------------------

clinical_clean <- clinical %>%
  distinct() %>%
  filter(age >= 18) %>%
  drop_na()

protein_clean <- protein %>%
  drop_na()

# -----------------------------
# Feature engineering
# -----------------------------

clinical_clean <- clinical_clean %>%
  mutate(
    BMI = weight / (height ^ 2)
  )

# -----------------------------
# Merge datasets
# -----------------------------

clinical_merged <- clinical_clean %>%
  left_join(
    protein_clean,
    by = c("subject_id" = "participant_id")
  )

# -----------------------------
# Create response labels
# -----------------------------

clinical_merged <- clinical_merged %>%
  mutate(
    response_label = case_when(
      RESPONSE == "Y" ~ "Responder",
      RESPONSE == "N" ~ "Non-Responder",
      TRUE ~ NA_character_
    )
  )

# -----------------------------
# Treatment response table
# -----------------------------

response_table <- clinical_merged %>%
  tabyl(trt_grp, response_label) %>%
  adorn_totals("row") %>%
  adorn_totals("col")

print(response_table)

# -----------------------------
# Response rates
# -----------------------------

response_rate <- clinical_merged %>%
  tabyl(trt_grp, response_label) %>%
  adorn_percentages("row") %>%
  adorn_pct_formatting(digits = 2)

print(response_rate)

# -----------------------------
# Summary statistics
# -----------------------------

protein_summary <- clinical_merged %>%
  group_by(response_label) %>%
  summarise(
    average_protein_concentration = mean(protein_concentration, na.rm = TRUE)
  )

print(protein_summary)

age_summary <- clinical_merged %>%
  group_by(response_label) %>%
  summarise(
    average_age = mean(age, na.rm = TRUE)
  )

print(age_summary)

bmi_summary <- clinical_merged %>%
  group_by(response_label) %>%
  summarise(
    average_BMI = mean(BMI, na.rm = TRUE)
  )

print(bmi_summary)

# -----------------------------
# Chart 1: Treatment response
# -----------------------------

ggplot(clinical_merged, aes(x = trt_grp, fill = response_label)) +
  geom_bar(position = "dodge") +
  scale_fill_manual(values = c(
    "Non-Responder" = "#808080",
    "Responder" = "#F57C00"
  )) +
  labs(
    title = "Response by Treatment Group",
    x = "Treatment Group",
    y = "Number of Patients",
    fill = "Response"
  ) +
  theme_minimal()

# -----------------------------
# Chart 2: Average protein concentration
# -----------------------------

ggplot(protein_summary, aes(x = response_label, y = average_protein_concentration, fill = response_label)) +
  geom_col() +
  scale_fill_manual(values = c(
    "Non-Responder" = "#808080",
    "Responder" = "#F57C00"
  )) +
  labs(
    title = "Average Protein Concentration by Response",
    x = "Response",
    y = "Average Protein Concentration"
  ) +
  theme_minimal() +
  theme(legend.position = "none")

# -----------------------------
# Chart 3: Average age
# -----------------------------

ggplot(age_summary, aes(x = response_label, y = average_age, fill = response_label)) +
  geom_col() +
  scale_fill_manual(values = c(
    "Non-Responder" = "#808080",
    "Responder" = "#F57C00"
  )) +
  labs(
    title = "Average Age of Responders vs Non-Responders",
    x = "Response",
    y = "Average Age"
  ) +
  theme_minimal() +
  theme(legend.position = "none")

# -----------------------------
# Chart 4: Average BMI
# -----------------------------

ggplot(bmi_summary, aes(x = response_label, y = average_BMI, fill = response_label)) +
  geom_col() +
  scale_fill_manual(values = c(
    "Non-Responder" = "#808080",
    "Responder" = "#F57C00"
  )) +
  labs(
    title = "Average BMI of Responders vs Non-Responders",
    x = "Response",
    y = "Average BMI"
  ) +
  theme_minimal() +
  theme(legend.position = "none")
