# Data Cleaning and Exploratory Data Analysis (EDA) on Global Layoffs (SQL)

## Overview
This project performs end-to-end **data cleaning** and **exploratory data analysis (EDA)** on a global layoffs dataset using **SQL**.  
The analysis covers layoffs across companies, industries, regions, and funding stages between **2020-03-11 and 2023-03-06**.

All transformations and analyses were executed using SQL scripts included in this repository.

---

## Dataset
- **Time range:** 2020-03-11 → 2023-03-06
- **Scope:** Global companies
- **Key fields:**
  - company
  - industry
  - country / region
  - total_laid_off
  - funding_stage
  - date

---

## Tools
- SQL (data cleaning, transformation, analysis)


---

## Data Cleaning
The following steps were applied to prepare the dataset:
- Remove duplicates
- Handle missing and null values
- Standardize company and industry names
- Normalize date formats
- Validate numeric fields

This step ensures consistency and reliability for analysis.

---

## Exploratory Data Analysis (EDA)

### Questions Answered
1. Companies with the most and least layoffs
2. Industries most and least affected by layoffs
3. Regions with the highest and lowest layoffs
4. Relationship between funding stage and layoffs
5. Layoff trends over time
6. Yearly ranking of companies by total layoffs

---

## Key Insights

### Companies
- **Amazon** recorded the highest layoffs (**18,150**), followed by **Google** and **Meta**.
- Large-scale organizations were disproportionately affected due to workforce size.

### Industries
- **Manufacturing** experienced the fewest layoffs.
- **Hardware, Consumer, and Fitness** industries recorded the highest layoffs.
- Increased automation and e-commerce adoption may be contributing factors.

### Regions
- The **United States** was the most affected region:
  - 1,231 companies impacted
  - 256,474 total layoffs

### Funding Stage
- **Post-IPO companies** laid off the most employees on average.
- **Series J** companies followed closely.
- **Seed-stage companies** showed higher employee retention, likely due to smaller team sizes and limited funding.

### Time Trends
- Layoffs peaked in mid-2020 (COVID-19 impact).
- A second surge occurred in 2022 during the global recession.
- Layoffs continued to rise into early 2023.

### Yearly Company Leaders
- **2020:** Uber (7,525 layoffs)
- **2021:** ByteDance (3,600 layoffs)
- **2023:** Google (~12,000 layoffs)

---

## Conclusion
This project demonstrates how **SQL can be used for structured data cleaning and analytical exploration**.  
While the analysis provides high-level insights, further visualization would improve interpretability and communication of trends.

