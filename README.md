# README: GSK "Step Up" Career Challenge - Path A

## Overview

Welcome to the GSK "Step Up" Career Challenge! This repository contains the resources and instructions for Path A: **Helping the Team with Data Analysis**. This path focuses on analysing clinical trial data to evaluate the efficacy of a new cancer treatment, Miraculon-B, compared to the standard of care.

---

## Objective

Analyse the data from a Phase 3 clinical trial to determine:
1. Whether patients treated with Miraculon-B respond more effectively than those receiving the standard of care.
2. Which patient sub-groups benefit the most based on age, weight, and protein concentration?

---

## Repository Contents

- **Data Files**:
  - `clinical-study.csv`: Clinical trial data with patient demographics and treatment responses.
  - `protein-levels.csv`: Protein concentration data for patients, a potential predictive biomarker.

- **Guides and Tools**:
  - `how-to-guide.pdf`: Detailed instructions for completing the challenge.
  - `excel_cheatsheet.pptx`: A cheat sheet for performing Excel data cleaning, aggregation, and visualisation.
  - `analytical_roles.pdf`: Insights into analytical roles in the pharmaceutical industry.

- **Presentation Template**:
  - `step_up_presentation.pptx`: A template to present your findings to stakeholders.

---

## Tools

You can complete the challenge using:
- **Microsoft Excel**: For data wrangling, analysis, and visualisation.
- **R (via Posit Cloud)**: For advanced data analysis and modelling.

---

## Instructions

1. **Prepare Your Environment**:
   - Install Excel or access the free online version [here](https://www.microsoft.com/en-us/microsoft-365/free-office-online-for-the-web).
   - Set up RStudio via Posit Cloud [here](https://posit.cloud/).

2. **Understand the Data**:
   - Examine the `clinical-study.csv` and `protein-levels.csv` files.
   - Use the provided **Data Dictionary** in the `how-to-guide.pdf` for reference.

3. **Data Cleaning**:
   - Remove duplicate rows and paediatric data (patients under 18).
   - Handle missing values appropriately.

4. **Feature Engineering**:
   - Calculate BMI using the formula: `BMI = weight / (height^2)`.
   - Merge datasets by patient ID to combine clinical and protein data.

5. **Analysis Tasks**:
   - Compare:
     - Responders vs. non-responders in different treatment groups.
     - Mean age, weight, and protein concentration across groups.
   - Create visualisations to identify trends:
     - Boxplots for age, BMI, and protein concentration by response and treatment groups.

6. **Advanced Modelling (Optional)**:
   - Use logistic regression or machine learning models to predict treatment response based on available features.

7. **Report Findings**:
   - Prepare a PowerPoint presentation summarising your analysis, including visualisations and key insights.
   - Simulate presenting your findings to a non-technical audience.

---

## Submission Guidelines

1. Submit your completed work to [info@digdata.online](mailto:info@digdata.online) within **10 days**. Include:
   - Your full name.
   - University name.
   - Year group.

2. Extensions can be requested by contacting the same email address.

3. Certificates and feedback will be provided within 7 days of submission.

---

## Resources

- GSK Overview and Tools: See the `how-to-guide.pdf` and `step_up_presentation.pptx`.
- Support: For any queries, contact [info@digdata.online](mailto:info@digdata.online).

---

## Good Luck!

We hope this challenge inspires your interest in analytical roles within the pharmaceutical industry. Thank you for participating! 🎉
