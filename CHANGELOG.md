# Changelog
### 2025-11-11 - Initial setup
## Phase 1 – Design & Setup (2025-11-11)
### Completed
- Created PostgreSQL `airline` schema
- Implemented tables: airports, airlines, aircraft, routes, flights, passengers, bookings, payments, loyalty_accounts, miles_transactions, flight_changes
- Added primary keys, foreign keys, uniqueness, and check constraints
- Exported ERD_v1.pdf


## Phase 2 — ETL Pipeline Build (2025-11-14)
### Completed
- Added ETL scripts:
  - `etl/load_openflights.py`
  - `etl/load_bts_performance.py`
  - `etl/synth_flights.py`
  - `etl/synth_customers.py`
  - `etl/synth_revenue.py`
- Loaded OpenFlights airport + airline reference data.
- Generated 5,000 synthetic flights.
- Loaded BTS On-Time Performance data (22,595 rows).
- Generated:
  - 5,000 passengers
  - 3,000 loyalty accounts
  - 10,576 miles transactions
  - 20,000 bookings
  - 20,000 payments
- Integrity checks: **All foreign keys resolved (0 missing)**.
- Added proof-of-pipeline PNG: `docs/pipeline_row_counts.png`.
- Updated Phase 2 notebook with validation SQL and charts.

## Phase 3 – SQL Data Cleaning & Constraints (2025-11-15)
### Completed 

- Add DML cleanup in `sql/03_dml_cleanup.sql` to:
  - standardize codes and status fields,
  - normalize `\N` / blank strings to NULL,
  - trim and clean text data.
- Add constraints & indexes in `sql/04_constraints_indexes.sql`:
  - stricter NOT NULL and CHECK constraints,
  - unique keys where appropriate,
  - indexes on common joins and filters.
- Validate with `notebooks/02_data_quality_checks.ipynb`:
  - row counts and null profiles by table,
  - FK integrity checks,
  - simple visual proof of data quality.

## Phase 4 – Analytical Query Development & Testing (2025-11-16)
### Completed

- Added analytical development notebook:
  - `notebooks/03_analytics_queries.ipynb`
  - includes SQLAlchemy engine, `run_sql()` helper, and visualization utilities.

- Implemented **15 advanced analytical SQL queries** covering:
  - **CTEs**: busiest airports, on-time performance, monthly passenger trends, loyalty tier transitions, revenue by fare class.
  - **Window functions**: airline delay rankings, running revenue totals, monthly delay percentages, CLV model, dense-rank route distance analysis.
  - **Recursive queries**: airport connectivity graph, multi-hop route exploration.
  - **Complex joins & aggregations**: payment success by channel, worst routes, top 5% loyalty members.

- Added backfill + support scripts:
  - `etl/backfill_routes_aircraft_changes.py`  
  - populated `routes`, `aircraft`, and supported recursive network queries.

- Performed performance testing using:
  - `EXPLAIN` and `EXPLAIN ANALYZE`,
  - validation of index usage (leveraging Phase 3 indexes),
  - checks for CTE inlining and execution efficiency.

- Produced BI visual proofs:
  - flight status distribution,
  - revenue by fare class,
  - delay distribution histogram.
  - Exported to: `docs/phase_4_analytics.png`

- Created full analytical documentation:
  - `docs/phase_4_query_catalog.md` (business question mapping, SQL, outputs, BI value)
  - `docs/phase_4_notes.md` (technical write-up of the analytical layer)

- All analytical outputs verified against live query results.
- Phase 4 closes with a complete BI-ready SQL analytics layer for use in Phase 5 dashboards and materialized views.

## Phase 5 – Python Integration & Analytics (2025-11-17)
### Completed

- Added Python analytics notebook:
  - `notebooks/04_python_analytics.ipynb`
  - includes SQLAlchemy connection helpers, reusable query functions, plotting defaults, and BI-ready analysis sections.

- Implemented **database helper utilities**:
  - `get_engine()` for PostgreSQL connection using `.env`  
  - `get_df()` wrapper for safe SQL execution and DataFrame retrieval  
  - centralized visualization styling (Airline BI theme: navy palette, bold titles, thicker axes)

- Added **SQL-to-Python analytics layer**:
  - data-access functions for busiest airports, airline punctuality, monthly revenue, fare-class revenue mix, payment channel success, CLV distributions, worst routes, and monthly delay performance.
  - all queries aligned with Phase 4 SQL logic and validated against the warehouse.

- Completed **Python-based business analysis**:
  - operational KPIs (delay distribution, airline reliability, monthly delay %)
  - network insights (busiest airports, problematic routes)
  - revenue trends (monthly revenue, fare-class contribution)
  - loyalty economics (CLV, high-value customer concentration)

- Generated **9 final BI visualizations**:
  - `Monthly_Revenue_Trend.png`
  - `Monthly_Revenue_Trend_Interactive.png`
  - `Revenue_by_Fare_Class.png`
  - `Flights_Delayed_by_Month.png`
  - `Average_Arrival_Delay_by_Airline.png`
  - `Distribution_of_Flight_Delay.png`
  - `Payment_Success_Rate_by_Channel.png`
  - `Customer_Lifetime.png`
  - `Top_10_Customers.png`
  - all exported to `docs/` for use in the final report and presentation.

- Added advanced network visualizations:
  - airport coordinate scatterplot (lat/long)
  - origin–destination Sankey diagram (Plotly graph_objects)
  - supplemental connectivity representation for route flows

- Created new documentation:
  - `docs/phase_5_notes.md` (executive summary, methodology, findings, visualization index, and explanation of future-dated synthetic data)

- Updated repo documentation:
  - `README.md` updated with Phase 5 overview, links to notebooks, and visualization gallery
  - `CHANGELOG.md` updated with this entry

### Notes
- Dataset includes valid future dates (2025–2026). Originates from Phase 2 synthetic generator and reflects real-world airline planning data where schedules exist months in advance. Data is fully usable for analysis and BI demonstrations.
