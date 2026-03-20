# Executive Summary: Olist E-Commerce Operations Analysis

**Dataset:** 100K real Brazilian e-commerce orders, 2016-2018  
**Tools:** SQL (SQLite), Tableau Public  
**Tables analyzed:** 9 relational tables across orders, customers, sellers, 
products, payments, and reviews  

---

## The Question

Where is this marketplace losing money, time, and customers?

---

## What I Did

Built a full SQL analysis pipeline from raw CSV data to a published Tableau 
dashboard. Wrote 20+ queries across 6 analysis phases covering revenue, 
delivery performance, seller quality, and customer satisfaction.

---

## What I Found

**Revenue**
Olist grew nearly 10x in one year. Health & Beauty leads at $1.26M in 
revenue but Watches & Gifts has the highest average order value at $201, 
meaning fewer buyers spending more. A Black Friday spike in November 2017 
to $987K confirms seasonal demand is significant.

**Delivery**
91.7% of orders arrive early. Olist pads estimates deliberately to manage 
expectations. But 8.05% of orders arrive late, and when they do, they tend 
to be very late (7+ days) rather than slightly late.

**The Satisfaction Cliff**
4 days late is the critical threshold. Cross it and average review scores 
drop from 4.29 to below 2.5. 37% of all 1-star reviews are linked to late 
delivery, but 63% are not, meaning product quality issues are just as 
important to fix.

**Sellers**
High volume alone does not make a great seller. The composite scorecard 
(review score + delivery + volume) surfaces hidden problems. One seller 
with nearly 1,000 orders scores below 3.5 on reviews, quietly damaging 
the platform at scale.

**Categories**
The worst rated categories (office furniture, fashion, telephony) have 
LOW late delivery rates. Their poor scores are driven by product quality 
and unmet expectations, not logistics.

---

## Recommendations

1. Flag and intervene on orders that cross 4 days late before the review 
   is submitted
2. Review or remove high volume sellers scoring below 3.5 on reviews
3. Audit product quality standards in office furniture, fashion male 
   clothing, and fixed telephony
4. Build logistics partnerships in northern states where delivery 
   predictability is lowest

---

## Links

[GitHub Repository](https://github.com/rangywulf/olist-ecommerce-analysis)  
[Tableau Dashboard](https://public.tableau.com/app/profile/jess.stubbs/viz/OlistE-commerceOperationsAnalysis/Dashboard1)