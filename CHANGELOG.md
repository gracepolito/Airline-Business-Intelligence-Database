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

### Next Steps
- Begin Phase 3 (semantic models + BI dashboards).
