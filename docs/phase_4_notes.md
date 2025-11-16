# Phase 4 – Analytical Query Development & Performance Testing

## Overview

Phase 4 focused on building and validating the **core analytical layer** of the Airline Business Intelligence Database.  
This phase produced:

- 15 advanced SQL analytical queries  
- Window, CTE, recursive, and multi-join patterns  
- Performance testing using `EXPLAIN` and `EXPLAIN ANALYZE`  
- Visualizations for BI reporting  
- A complete business question catalog for all queries

All work was implemented in:

- `notebooks/03_analytics_queries.ipynb` – analytical SQL + visuals  
- `docs/phase_4_query_catalog.md` – business question mapping  
- `docs/phase_4_analytics_*.png` – analytical visual outputs

---

## 1. Analytical Query Coverage

Phase 4 delivered **15 production-quality BI queries** grouped into four categories.

### A. CTE / Aggregation Queries
1. **Top 10 busiest airports** (arrivals + departures)  
2. **Airline on-time performance summary** using BTS data  
3. **Monthly passenger counts** via bookings  
4. **Loyalty tier transitions** (current vs. miles-qualified)  
5. **Revenue per fare class** (bookings + payments)

### B. Window Function Queries
6. **Ranking airlines by average delay**  
7. **Running monthly revenue totals**  
8. **Percent of flights delayed per month**  
9. **Customer lifetime value (CLV)** window function  
10. **Dense_rank() route distance ranking**

### C. Recursive CTE Queries
11. **Airport connectivity graph from busiest origin**  
12. **Multi-hop route exploration, up to 3 hops**

### D. Complex Join + Aggregation Workloads
13. **Payment success rate by booking channel**  
14. **Worst routes by delay + cancellations**  
15. **Top 5% loyalty members** using `CUME_DIST()`

All queries and their actual outputs are documented in `docs/phase_4_query_catalog.md`.

---

## 2. Performance Testing & Observations

Performance validation used:

- `EXPLAIN`
- `EXPLAIN ANALYZE`
- Query plan inspection inside the notebook

### Key Findings

#### Q1 – Busiest Airports (CTE)
- Sequential scan on `flights` and aggregation step.  
- Small table sizes → no index required.  
- If scaled to millions of flights:  
  - **Consider index:** `(origin_airport_id, destination_airport_id)`.

#### Q5 – Revenue by Fare Class
- Hash join between `bookings` and `payments`.  
- FK indexes fully utilized.  
- Fast enough for **real-time dashboards**.

#### Q7 – Running Monthly Revenue Totals
- WindowAgg + sort on `month_start`.  
- Efficient due to limited number of calendar months.  
- For multi-year historical datasets:  
  - **Materialized view recommended** for BI tools.

#### Q11 – Recursive Connectivity Graph
- Recursive union with nested loops on airports.  
- Very performant at current dataset sizes.  
- For enterprise-scale routing networks:  
  - Add index on `routes(origin_airport_id)`  
  - Build a **precomputed connectivity view** in Phase 5.

### General Notes
- All window functions used optimized sort nodes.  
- All joins relied on proper FK indexes.  
- No query exceeded ~1.2 seconds at current dataset size.

---

## 3. Business Question Documentation

A structured mapping of **Purpose → Inputs → Outputs → BI Value** was written for all 15 queries.

Delivered in:

- `docs/phase_4_query_catalog.md`

This catalog ties every SQL block to real-world BI scenarios including:

- Delay scorecards  
- Revenue pacing  
- Loyalty tier drift  
- Route network optimization  
- Payment conversion  
- Customer lifetime value segmentation  

All outputs include **actual DataFrame results from the notebook**, ensuring traceability and reproducibility.

---

## 4. Visualizations Produced

Three BI visualizations were created using Matplotlib:

1. **Flights by Status**  
2. **Revenue by Fare Class**  
3. **Delay Distribution Histogram**

Saved under:

- `docs/phase_4_analytics_flights_status.png`  
- `docs/phase_4_analytics_revenue_fare_class.png`  
- `docs/phase_4_analytics_delay_histogram.png`

Phase 5 will expand this into dashboards (Tableau, Power BI) and materialized summaries for faster refresh cycles.

---

## 5. Artifacts Produced in Phase 4

- `notebooks/03_analytics_queries.ipynb`  
- `docs/phase_4_query_catalog.md`  
- `docs/phase_4_analytics_flights_status.png`  
- `docs/phase_4_analytics_revenue_fare_class.png`  
- `docs/phase_4_analytics_delay_histogram.png`

Optional:
- `sql/explain/` – query plans can be saved here if needed.

---

## 6. Summary

Phase 4 delivers the **analytical core** of the BI system:

- Advanced SQL queries  
- Recursive & window functions  
- Performance tuning  
- Clear BI interpretations  
- Production-ready analytical artifacts  

These outputs now feed directly into **Phase 5**, where you will:

- Build analytical dashboards  
- Add materialized views  
- Finalize BI portfolio documentation

---

_End of Phase 4 Notes._
