"""
Clinical Trial Data Analysis
Author: Alexandria Noikovitch

Description:
This project analyses clinical trial and protein concentration data
using Python, pandas, and matplotlib.

The workflow includes:
- Data cleaning
- Duplicate removal
- Missing value handling
- BMI calculation
- Dataset merging
- Treatment response analysis
- Data visualisation
"""

# Import libraries
import pandas as pd
import matplotlib.pyplot as plt


# -----------------------------
# Load datasets
# -----------------------------

clinical = pd.read_excel("clinical-study.xlsx")
protein = pd.read_excel("protein-levels.xlsx")


# -----------------------------
# Initial data inspection
# -----------------------------

print("\nClinical Dataset Overview")
print(clinical.info())

print("\nProtein Dataset Overview")
print(protein.info())


# -----------------------------
# Data cleaning
# -----------------------------

# Remove duplicate records
clinical = clinical.drop_duplicates()

# Keep only adult patients
clinical = clinical[clinical["age"] >= 18]

# Remove missing values
clinical = clinical.dropna()
protein = protein.dropna()


# -----------------------------
# Feature engineering
# -----------------------------

# Calculate BMI
clinical["BMI"] = clinical["weight"] / (clinical["height"] ** 2)

# Merge protein dataset with clinical dataset
clinical = clinical.merge(
    protein,
    left_on="subject_id",
    right_on="participant_id",
    how="left"
)

# Create readable response labels
clinical["response_label"] = clinical["RESPONSE"].map({
    "Y": "Responder",
    "N": "Non-Responder"
})


# -----------------------------
# Treatment response analysis
# -----------------------------

response_table = pd.crosstab(
    clinical["trt_grp"],
    clinical["response_label"]
)

response_table["Total"] = response_table.sum(axis=1)
response_table.loc["Total"] = response_table.sum()

print("\nTreatment Response Table")
print(response_table)


# -----------------------------
# Response rate analysis
# -----------------------------

response_rate = pd.crosstab(
    clinical["trt_grp"],
    clinical["response_label"],
    normalize="index"
) * 100

print("\nTreatment Response Rates (%)")
print(response_rate.round(2))


# -----------------------------
# Protein concentration analysis
# -----------------------------

protein_summary = clinical.groupby(
    "response_label"
)["protein_concentration"].mean()

print("\nAverage Protein Concentration")
print(protein_summary.round(2))


# -----------------------------
# Age analysis
# -----------------------------

age_summary = clinical.groupby(
    "response_label"
)["age"].mean()

print("\nAverage Age")
print(age_summary.round(2))


# -----------------------------
# BMI analysis
# -----------------------------

bmi_summary = clinical.groupby(
    "response_label"
)["BMI"].mean()

print("\nAverage BMI")
print(bmi_summary.round(2))


# -----------------------------
# Visualisations
# -----------------------------

# 1. Treatment response chart
response_chart = response_table.drop("Total").drop(
    columns="Total"
)

response_chart.plot(
    kind="bar",
    color=["#808080", "#F57C00"]
)

plt.title("Response by Treatment Group")
plt.xlabel("Treatment Group")
plt.ylabel("Number of Patients")
plt.xticks(rotation=0)
plt.tight_layout()
plt.show()


# 2. Protein concentration chart
clinical.groupby("response_label")[
    "protein_concentration"
].mean().plot(
    kind="bar",
    color=["#808080", "#F57C00"]
)

plt.title("Average Protein Concentration by Response")
plt.xlabel("Response")
plt.ylabel("Average Protein Concentration")
plt.xticks(rotation=0)
plt.tight_layout()
plt.show()


# 3. Age comparison chart
clinical.groupby("response_label")[
    "age"
].mean().plot(
    kind="bar",
    color=["#808080", "#F57C00"]
)

plt.title("Average Age of Responders vs Non-Responders")
plt.xlabel("Response")
plt.ylabel("Average Age")
plt.xticks(rotation=0)
plt.tight_layout()
plt.show()


# 4. BMI comparison chart
clinical.groupby("response_label")[
    "BMI"
].mean().plot(
    kind="bar",
    color=["#808080", "#F57C00"]
)

plt.title("Average BMI of Responders vs Non-Responders")
plt.xlabel("Response")
plt.ylabel("Average BMI")
plt.xticks(rotation=0)
plt.tight_layout()
plt.show()
