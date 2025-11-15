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


## Author
Grace Polito — Eastern University MSDS, DTSC 691 Capstone
