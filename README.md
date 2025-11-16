# ✈️ Airline Business Intelligence Database  
A PostgreSQL-based analytical data environment modeling airline operations, customer behavior, and commercial performance.  
The system integrates **real OpenFlights and U.S. BTS data** with **synthetic passengers, bookings, loyalty accounts, and revenue** generated using Python and SQLAlchemy.

The project is designed as a full BI pipeline: data ingestion → cleansing → transformation → integrity validation → analytics.

---

## 📁 Project Structure

```
Airline Business Intelligence Database/
│
├── sql/          # DDL & DML scripts: schema, constraints, cleaning
├── data/         # OpenFlights datasets, BTS data, synthetic exports
├── etl/          # Python ETL pipelines (OpenFlights, BTS, synthetic generation)
├── notebooks/    # Jupyter notebooks for QA, EDA, and pipeline validation
├── docs/         # ERD, proposal, PNG outputs, final deliverables
└── README.md
```

---

## 🛠️ Environment Setup

**Requirements**
- PostgreSQL 16  
- Python 3.10+  
- Packages:  
  `sqlalchemy`, `psycopg2-binary`, `pandas`, `faker`, `matplotlib`, `python-dotenv`

**Setup**
```bash
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
export $(grep -v '^#' .env | xargs)
```

---

## ✅ Phase 1 Summary — Schema Design & Setup

- Project scaffolding created: `sql/`, `data/`, `notebooks/`, `etl/`, `docs/`
- Database schema created in PostgreSQL 16
- `001_schema.sql` includes all **PK/FK**, **UNIQUE**, **CHECK**, and **ENUM** constraints
- Schema loaded and verified in pgAdmin
- ERD exported to `docs/ERD_v1.pdf`

---

## 🚀 Phase 2 Summary — ETL & Synthetic Data Pipeline

### **Real Data Loaded**
- **Airports:** 7,697 (OpenFlights)  
- **Airlines:** 5,733 (OpenFlights)  
- **BTS On-Time Performance:** 22,595 rows (cleaned & normalized)

### **Synthetic Data Generated**
- **Flights:** 5,000 realistic flights (randomized schedules, delays, causes, statuses)
- **Passengers:** 5,000
- **Loyalty Accounts:** 3,000
- **Miles Transactions:** 10,576  
- **Bookings:** 40,000 (unique passenger × flight combinations)
- **Payments:** 40,000 (one-to-one with bookings)

### **Integrity Checks Passed**
All foreign key validations returned **0 missing references**:
- Airline → Airlines  
- Airport → Airports  
- Passenger → Passengers  
- Flight → Flights  

This confirms referential integrity across all operational and commercial tables.

---

## 📊 Pipeline Proof (Phase 2 Output)

A row-count validation chart is saved at:
```
docs/pipeline_row_counts.png
```
This provides a visual verification that all production tables populated successfully.

---

### Phase 3 – SQL Cleaning, Deduplication, and Integrity

Phase 3 focused on **database-level quality**:

- Standardized key fields:
  - Upper-cased airline and airport codes
  - Trimmed names and normalized emails
  - Normalized BTS carrier/airport codes and numeric delay fields
- Removed or prevented duplicates:
  - Unique IATA/ICAO per airport and airline
  - Unique passenger email
  - At most one loyalty account per passenger
  - One `(passenger_id, flight_id)` booking pair
- Hardened integrity with:
  - Additional `NOT NULL`, `UNIQUE`, `CHECK`, and `FOREIGN KEY` constraints
  - Performance indexes for BI-style queries on flights, bookings, payments, and BTS data
- Validated the cleaned data via `sql/05_validations.sql` and
  `notebooks/02_data_quality_checks.ipynb`, including:
  - Row counts per table
  - Foreign key health (all 0 missing)
  - Key uniqueness checks
  - Summary “problem counts” visualization in `docs/pipeline_quality_checks.png`

---

## 📈 Phase 4 – Analytical Query Development & Testing

Phase 4 delivered the **full analytical layer** of the Airline BI Database.  
This included 15 advanced SQL queries, performance validation, recursive route analysis, and visual analytics artifacts.

### 🔍 Core Deliverables
- New notebook:  
  `notebooks/03_analytics_queries.ipynb`
  - SQLAlchemy engine + reusable `run_sql()` helper
  - Organized sections for CTEs, window functions, recursive queries, and aggregations  
  - Embedded charts generated with `matplotlib`

- Backfill script:
  - `etl/backfill_routes_aircraft_changes.py`  
  - Automatically populates:
    - `routes` (derived from flights)
    - `aircraft` (synthetic fleet per airline)
    - Ensures recursive network queries function correctly

- All analytical results exported to documentation:
  - `docs/phase_4_query_catalog.md` — **full business question mapping**
  - `docs/phase_4_notes.md` — **technical write-up**
  - `docs/phase_4_analytics.png` — **visual proof charts**

---

### 📊 15 Advanced SQL Queries Implemented

#### **CTE Queries**
1. **Busiest airports** (arrivals + departures)  
2. **Airline on-time performance** (BTS performance data)  
3. **Monthly passenger counts** (synthetic bookings)  
4. **Loyalty tier transitions** (current vs earned tier)  
5. **Revenue by fare class** (bookings + payments)

#### **Window Functions**
6. Airline **delay ranking**  
7. **Running monthly revenue** totals  
8. **Percent of flights delayed** by month  
9. **Customer lifetime value (CLV)**  
10. **Dense-rank** longest routes by distance

#### **Recursive Queries**
11. **Airport connectivity graph** from busiest hub  
12. **Multi-hop route paths** (up to 3 hops)

#### **Complex Joins & Aggregations**
13. **Payment success rate** by channel  
14. **Worst-performing routes** (delay + cancellation blend)  
15. **Top 5% loyalty members** by lifetime miles

All queries were executed, validated, and captured with real output samples inside the query catalog.

---

### ⚡ Performance Testing

Each query was analyzed for execution performance using:

- `EXPLAIN` / `EXPLAIN ANALYZE`
- Validation of index utilization  
- Runtime measurement and improvement where needed  
- Confirmation that synthetic indexes from Phase 3 effectively support BI workloads:
  - `flights(flight_date, airline_id)`
  - `bookings(booking_date)`
  - `payments(paid_at)`
  - `flight_performance(airport_iata)`
  - FK indexes on all join columns

Complex queries—including recursive CTEs—ran efficiently on the populated dataset.

---

### 📉 Visual Analytics (Phase 4 Outputs)

Generated charts exported to:  `docs/phase_4_analytics.png` 


Includes:
- **Flights by Status**
- **Revenue by Fare Class**
- **Flight Delay Distribution**

These figures serve as proof of analytics execution and final BI readiness.

---

### ✅ Phase 4 Outcome

Phase 4 completes the analytical layer of the project, providing:

- Query-ready analytical SQL library  
- Validated BI metrics across operations, loyalty, demand, and revenue  
- Ready-to-use network connectivity and route structure insights  
- Documentation and visual artifacts for Phase 5 dashboarding

This prepares the dataset for downstream tools such as Tableau, Power BI, or Metabase.

---

## Author
Grace Polito — Eastern University MSDS, DTSC 691 Capstone
