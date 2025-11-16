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
