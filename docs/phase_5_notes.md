# Phase 5 – Python Integration & Analytics

## Overview

Phase 5 extends the Airline Business Intelligence Database into a **Python-based analytical workspace**.  
This phase connects the PostgreSQL warehouse to Pandas, Matplotlib, and Plotly, enabling:

- A reusable SQL-to-Python analytics layer  
- Operational, network, revenue, and loyalty insights  
- BI-ready visualizations exported to `docs/`  
- An integrated environment for exploratory data analysis (EDA)

All work was implemented in:

- `notebooks/04_python_analytics.ipynb` – Python analytics, summaries, and visuals  
- `docs/phase_5_notes.md` – this technical and business documentation  
- `docs/phase_5_*.png` – saved visual outputs for reports & presentation  

---

## 1. SQL-to-Python Analytics Coverage

Phase 5 implemented **production-ready Python wrappers** around the Phase 4 SQL logic.  
These helper functions provide clean DataFrames for downstream BI analysis.

### A. Operational & Delay Performance
1. **Airline punctuality summary**  
2. **Monthly percent of flights delayed**  
3. **Delay distribution** (histogram)  

### B. Network & Route Analysis
4. **Busiest airports** (arrivals + departures)  
5. **Worst routes** by delay + cancellation rate  
6. **Route flow diagram** (Plotly Sankey)  
7. **Airport geolocation map** (lat/long scatterplot)

### C. Revenue & Commercial Insights
8. **Monthly revenue trends**  
9. **Revenue by fare class**  
10. **Payment success rate** by booking channel

### D. Loyalty & Customer Economics
11. **Customer lifetime value (CLV)** distribution  
12. **Top 10 loyalty customers**  
13. **Cumulative revenue curve** (CLV concentration)

All queries were executed using the `get_df()` engine wrapper and are fully reproducible.

---

## 2. Python Execution Environment

The Python notebook includes:

- SQLAlchemy engine creation using `.env`  
- Safe SQL wrapper: `get_df(sql, params)`  
- Visualization defaults:
  - Airline BI theme  
  - White background  
  - Navy/blue palette  
  - Thick axes & bold titles  

Helper functions ensure:

- Centralized DB connectivity  
- Clean separation of SQL and EDA  
- Readable, consistent DataFrames throughout analysis

---

## 3. Analytical Insights Produced

Python analysis produced actionable BI findings across four domains:

### A. Operations
- Delay rates range from ~68–84% depending on month  
- Airlines show clear differences in average delay performance  
- Delay causes reflect synthetic patterns aligned with Phase 2 generation

### B. Network
- Busiest airports surfaced smaller regional hubs due to random synthetic routing  
- Worst-performing routes h

