# Olist E-Commerce Operations Analysis

SQL analysis of 100K real Brazilian e-commerce orders exploring revenue 
performance, delivery operations, seller quality, and the relationship 
between late deliveries and customer satisfaction.

---

## Executive Summary

Olist is a Brazilian e-commerce marketplace operating between 2016 and 2018. 
This analysis examines 96,476 delivered orders across 9 relational tables to 
answer one central question: where is this marketplace losing money, time, 
and customers?

The data tells a clear story. Olist grew nearly 10x in revenue in a single 
year, peaking around Black Friday 2017. Delivery performance is strong on 
paper — 91.7% of orders arrive early — but that headline masks real problems. 
When orders go wrong, they go very wrong. Orders that arrive 4+ days late see 
average review scores drop from 4.29 to below 2.5, and 37% of all 1-star 
reviews are linked to late delivery. A small number of sellers are responsible 
for a disproportionate share of those late orders, and the worst-rated product 
categories have poor scores driven by product quality issues rather than 
delivery, meaning the fix isn't just operational.

---

## Key Findings

- **Health & Beauty** is the top revenue category at $1.26M. Watches & Gifts 
  follows at $1.21M but with a much higher average order value of $201.
- **Revenue grew nearly 10x** in one year, from $111K in January 2017 to 
  $924K in January 2018, with a Black Friday spike to $987K in November 2017.
- **91.7% of orders arrive early.** Olist deliberately pads delivery estimates 
  to manage customer expectations.
- **8.05% of orders arrive late.** When they do, they tend to be very 
  late (7+ days) rather than slightly late.
- **4 days is the critical threshold.** Crossing it drops average review 
  scores by over 1 full star.
- **37% of 1-star reviews are linked to late delivery.** But 63% are not, 
  meaning product quality and unmet expectations are significant drivers too.
- **Office Furniture, Fashion, and Fixed Telephony** are the worst-rated 
  categories despite low late delivery rates. A product quality problem, 
  not a logistics one.
- **High volume sellers don't dominate the composite scorecard.** A small 
  number of high-volume sellers score below 3.5 on reviews, quietly damaging 
  platform reputation.

---

## Recommendations

- **Flag sellers who cross the 4-day late threshold** for immediate 
  intervention. This is where customer satisfaction falls off a cliff.
- **Review or remove "High Volume, Low Quality" sellers.** They drive 
  revenue but damage the platform's reputation at scale.
- **Investigate product quality standards** in Office Furniture, Fashion Male 
  Clothing, and Fixed Telephony. Late delivery is not the issue here.
- **Invest in northern state logistics partnerships.** Remote states like 
  Acre and Amazonas receive the most padded estimates because delivery is 
  genuinely unpredictable there.

---

## Dashboard

[View on Tableau Public](https://public.tableau.com/app/profile/jess.stubbs/viz/OlistE-commerceOperationsAnalysis/Dashboard1)

---

## Tech Stack

- **SQL** via SQLite and VSCode SQLTools extension
- **Tableau Public** for dashboard and visualizations
- **Git / GitHub** for version control

---

## Data Source

[Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) 
via Kaggle. Real transaction data from 2016 to 2018, 9 relational tables, 
~100K orders.

---

## Project Structure
```
olist-ecommerce-analysis/
├── data/            ← source CSVs (excluded from repo, download from Kaggle)
├── queries/         ← all SQL query files by phase
├── results/         ← exported CSV results from each analysis phase
├── notes/           ← table notes, schema diagram, findings documentation
└── README.md
```

---

## Schema

See `notes/` for the full schema diagram showing relationships across all 
9 tables.