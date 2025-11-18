# ✈️ Airline Business Intelligence Database  
## Final Project Overview Document  
Grace Polito — MSDS Capstone Project  
Eastern University • 2025

---

# 1. Introduction & Problem Context

The Airline Business Intelligence Database is a full-stack analytical ecosystem modeling airline operations, commercial performance, loyalty behavior, and customer value. It integrates real aviation datasets (OpenFlights, BTS On-Time Performance) with realistically generated synthetic operational and commercial data.

The goal is to demonstrate the entire BI lifecycle: schema engineering → ETL → data cleaning → analytical SQL → Python dashboards → final insights. This document summarizes the complete project from Phase 1 through Phase 6.

---

# 2. Data Sources & Business Domain

## Real Data Sources
- **OpenFlights Airports & Airlines**
  - ~7,700 airports; ~5,700 airlines  
- **U.S. BTS On-Time Performance**
  - 22,595 historical delay records, standardized to 2024

## Synthetic Data (Generated in Phase 2)
- 5,000 flights  
- 5,000 passengers  
- 3,000 loyalty accounts  
- 10,576 miles transactions  
- 40,000 bookings  
- 40,000 payments  

Synthetic data allows complete, fully populated operational and commercial scenarios.  
*Note:* Some values extend into **2025–2026** to simulate real airline scheduling horizons and ensure full-season trend analysis.

---

# 3. Schema Design & ERD (Phase 1)

Phase 1 delivered the relational foundation of the BI system:

## Schema Features
- Core entities: airports, airlines, aircraft, routes, flights  
- Customer/commercial entities: passengers, loyalty_accounts, bookings, payments  
- Performance table: flight_performance (BTS data)
- Enforced integrity:
  - Primary keys
  - Foreign keys
  - NOT NULL / UNIQUE / CHECK constraints
  - ENUMs for controlled domains (flight_status, payment_method, loyalty_tier)

## Artifacts
- ERD diagram: `docs/ERD_v1.pdf`
- Full schema DDL: `sql/01_schema.sql`

This phase established a normalized, constraint-hardened warehouse suitable for BI queries.

---

# 4. ETL Pipeline & Data Ingestion (Phase 2)

Phase 2 implemented structured ETL pipelines to load all real and synthetic datasets into PostgreSQL.

## Achievements
- Ingested OpenFlights airport and airline data  
- Loaded BTS On-Time Performance  
- Generated synthetic flights, customers, bookings, revenue  
- Loaded all datasets with 0 FK integrity violations

## Validation
Row counts after ingestion:
- Flights: 5,000  
- Passengers: 5,000  
- Loyalty Accounts: 3,000  
- Miles Transactions: 10,576  
- Bookings: 40,000  
- Payments: 40,000  

## Artifacts
- ETL scripts: `etl/`  
- Row count visual: `docs/pipeline_row_counts.png`

This phase completed the raw data foundation that later phases transform and analyze.

---

# 5. Data Cleaning, Standardization & Constraints (Phase 3)

Phase 3 refined the warehouse into a clean, deduplicated, and constraint-enforced environment.

## Cleaning Steps
- Standardized IATA/ICAO codes  
- Normalized timestamps and status fields  
- Cleaned null placeholders  
- Lowercased and trimmed text fields  
- Removed duplicate entities (airports, airlines, bookings)

## Constraint Hardening
- Strict NOT NULL & UNIQUE constraints  
- CHECK constraints on:
  - Coordinates
  - Payment values
  - Delay logic  
- Index optimization for BI workloads:
  - `flights(flight_date, airline_id)`  
  - `bookings(booking_date)`  
  - `payments(paid_at)`

## Artifacts
- `sql/03_dml_cleanup.sql`  
- `sql/04_constraints_indexes.sql`  
- Data quality visual: `docs/pipeline_quality_checks.png`  

This phase ensured the data met production-level quality expectations.

---

# 6. Analytical SQL Development (Phase 4)

Phase 4 created the analytical SQL layer powering operational, commercial, and loyalty insights.  
A total of **15 advanced SQL queries** were built.

## Categories of Analytical Queries

### A. CTE Queries
1. Top 10 busiest airports  
2. Airline on-time performance  
3. Monthly passenger counts  
4. Loyalty tier transitions  
5. Revenue by fare class  

### B. Window Function Queries
6. Airline delay ranking  
7. Running monthly revenue  
8. Percent flights delayed  
9. Customer Lifetime Value (CLV)  
10. Route distance ranking  

### C. Recursive Queries
11. Airport connectivity graph  
12. Multi-hop route exploration  

### D. Complex Join & Aggregation Queries
13. Payment success rate  
14. Worst-performing routes  
15. Top 5% loyalty members  

## Performance Testing
- All queries analyzed with `EXPLAIN` and `EXPLAIN ANALYZE`.
- Indexes from Phase 3 fully utilized.
- All queries executed in under ~1.2 seconds.

## Artifacts
- Query notebook: `notebooks/03_analytics_queries.ipynb`  
- Query catalog: `docs/phase_4_query_catalog.md`  
- Analytical visuals: `docs/phase_4_analytics.png`  
- Detailed notes: `docs/phase_4_notes.md`

This phase completed the BI-ready SQL analytical layer.

---

# 7. Python Integration & Analytics (Phase 5)

Phase 5 translated SQL analytics into Python for visualization and narrative BI storytelling.

## 7.1 Database Integration
- `.env`-based database URL  
- `get_engine()` & `get_df()` helper functions  
- Centralized Matplotlib theme (Airline BI palette)  
- Optional Plotly integration for interactive charts

## 7.2 Python Analytical Functions
Python wrappers were built for every major Phase 4 SQL query, including:
- Monthly revenue  
- Revenue by fare class  
- Delay patterns  
- Airline reliability  
- CLV distribution  
- Payment success rates  
- Busiest airports  
- Worst routes  
- Network connectivity visualizations

## 7.3 Visualizations (Saved to `docs/`)
- `Monthly_Revenue_Trend.png`  
- `Revenue_by_Fare_Class.png`  
- `Flights_Delayed_by_Month.png`  
- `Average_Arrival_Delay_by_Airline.png`  
- `Distribution_of_Flight_Delay.png`  
- `Payment_Success_Rate_by_Channel.png`  
- `Customer_Lifetime.png`  
- `Top_10_Customers.png`  
- `Airports_in_Airline_Network.png`  
- `Network_Connectivity.png`

## 7.4 Future-Dated Records Note
Synthetic flight, payment, and booking data extends into **2025–2026**.  
This is intentional to:
- Simulate real airline scheduling horizons  
- Ensure full-year trend analysis  
- Provide smooth continuity for delay and revenue modeling  

The dataset remains valid, clean, and constraint-compliant.

---

# 8. Key Business Insights

## Operational Insights
- Delay spikes occur seasonally (March/December peaks).  
- Certain routes exhibit near-100% cancellation/delay rates.

## Network Insights
- Busiest airports in synthetic data reflect random distribution, not global hubs.  
- Connectivity graphs show sparse route networks with fragmentation.

## Commercial Insights
- Basic, Standard, and Flexible fare classes drive the majority of revenue.  
- Revenue shows mid-year peaks consistent with demand cycles.

## Payment Insights
- Payment success rates are low across all channels (~15%).  
- Opportunity exists for funnel optimization.

## Loyalty Insights
- CLV distribution is highly skewed.  
- Top 5% of customers contribute disproportionately to value.  
- Loyal customers may be misaligned with miles-earned tiers.

---

# 9. Challenges, Assumptions & Limitations

## Challenges
- Ensuring timestamp alignment between real and synthetic data  
- Avoiding FK or CHECK constraint violations  
- Creating realistic distributions for synthetic bookings & delays  

## Assumptions
- Synthetic data reflects plausible airline behavior patterns  
- Delay generation and payment probabilities approximate realistic variability  

## Limitations
- Synthetic dataset does not reflect true global route structures  
- No real pricing model or operational flight network  
- Some analyses may differ from real-world airline constraints  

---

# 10. Future Work & Enhancements

### Modeling Enhancements
- Delay prediction models  
- Revenue forecasting  
- Loyalty churn models  

### Engineering Enhancements
- Airflow-based pipeline scheduling  
- Containerization (Docker)  
- Materialized views for BI tools  

### Analytics Enhancements
- Full Tableau or Power BI dashboards  
- Real-time operational dashboards  
- Enhanced geo-visualizations  

---

# 11. Conclusion

This capstone project demonstrates the complete lifecycle of a modern BI system:

- Schema engineering  
- ETL pipeline development  
- Data cleaning and standardization  
- Advanced SQL analytics  
- Python-based visual storytelling  
- Final reporting and presentation  

The resulting Airline BI Database is a robust, scalable analytical platform suitable for operational BI dashboards, strategic decision support, and portfolio demonstration.

---

_End of Final Project Overview Document_
