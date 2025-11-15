# Phase 3 – SQL Data Cleaning, Deduplication, and Integrity

## Overview

Phase 3 focused on **database-level data quality** using SQL:
- Standardized key text fields and codes
- Removed or prevented duplicates
- Hardened the schema with constraints and indexes
- Documented data quality checks for the final BI deliverables

All changes were implemented primarily in:

- `sql/03_dml_cleanup.sql` – standardization + deduplication
- `sql/04_constraints_indexes.sql` – constraints & indexing
- `sql/05_validations.sql` – integrity & quality checks

---

## 1. Standardization DML

**Airports**
- Trimmed whitespace and upper-cased IATA/ICAO codes.
- Normalized placeholder values (`'', ' ', 'NA', '\N'`) to `NULL`.
- Preserved 7,697 airports after cleanup.
- Ensured latitude/longitude were within reasonable world coordinate bounds.

**Airlines**
- Trimmed and upper-cased IATA/ICAO codes.
- Standardized country values where possible.
- Removed or consolidated non-meaningful carriers (e.g., “Unknown”, “Private flight”) where they conflicted with constraints.
- Final airline count: **1,108** distinct carriers with unique IATA codes.

**Flights**
- Standardized `status` to match the enum:
  - `Scheduled`, `Departed`, `Arrived`, `Cancelled`, `Diverted`
- Ensured `flight_date` is consistent with `scheduled_departure_utc::date`.
- Preserved all **5,000** synthetic flights after cleanup.

**BTS Flight Performance**
- Kept data in `airline.flight_performance` with:
  - 2024 coverage across **12 months**, **21 airlines**, and **357 airports**.
- Normalized airline and airport codes to uppercase IATA.
- Cast numeric delay and arrival fields to appropriate numeric types.

**Passengers & Loyalty**
- Trimmed `first_name` and `last_name`.
- Normalized `email` values to lowercase.
- Cleaned placeholder values (`'N/A'`, `'Unknown'`) back to `NULL` where reasonable.
- Ensured loyalty tiers are valid enum values (`Basic`, `Silver`, `Gold`, `Platinum`).
- Result: **5,000** passengers, **3,000** loyalty accounts, **10,576** miles transactions.

**Bookings & Payments**
- Normalized `fare_class`, `booking_channel`, `payment method`, and `status` values to a controlled set of labels.
- Ensured `booking_date` and `paid_at` remain valid timestamps.
- Result: **40,000** bookings and **40,000** payments after cleanup.

---

## 2. Deduplication & Key Hygiene

**Airports**
- Checked for duplicate IATA/ICAO codes; none remain after cleanup.
- Any potential duplicates would be resolved by keeping the “best” row (non-null lat/long, valid city/country).

**Airlines**
- Deduplicated based on IATA code.
- Enforced a unique constraint on `airlines(iata_code)` and `airlines(icao_code)`.

**Passengers**
- Verified that passenger email addresses are unique:
  - `5,000` non-null emails, `5,000` distinct.

**Bookings & Payments**
- Enforced and validated:
  - One `bookings` row per `(passenger_id, flight_id)` pair via `uq_booking_unique`.
  - Exactly one payment per booking in this model:
    - No bookings without payments.
    - No payments without a corresponding booking.

**Loyalty & Miles**
- Ensured each passenger has **at most one** loyalty account.
- Enforced valid references from `miles_transactions.loyalty_id` to `loyalty_accounts.loyalty_id`.

---

## 3. Constraints and Indexes

**Key constraints added or verified in Phase 3:**

- **Primary keys** on all core tables (`airlines`, `airports`, `flights`, `bookings`, `payments`, `passengers`, etc.).
- **Unique** constraints on:
  - `airlines(iata_code)`, `airlines(icao_code)`
  - `airports(iata_code)`, `airports(icao_code)`
  - `passengers(email)`
  - `loyalty_accounts(passenger_id)`
  - `flight_performance(snapshot_id)` + composite uniqueness for `(year, month, airline_iata, airport_iata)`
  - `bookings(passenger_id, flight_id)` (one booking per passenger/flight pair).
- **Foreign keys** to enforce referential integrity:
  - `flights.airline_id → airlines.airline_id`
  - `flights.origin_airport_id/destination_airport_id → airports.airport_id`
  - `bookings.passenger_id → passengers.passenger_id`
  - `bookings.flight_id → flights.flight_id`
  - `payments.booking_id → bookings.booking_id`
  - `loyalty_accounts.passenger_id → passengers.passenger_id`
  - `miles_transactions.loyalty_id → loyalty_accounts.loyalty_id`
  - `miles_transactions.flight_id → flights.flight_id`

**Indexes** (for BI-style workloads):

- `flights(flight_date, airline_id)`
- `bookings(flight_id)`
- `bookings(booking_date)`
- `payments(paid_at)`
- `flight_performance(airport_iata)`
- Indexes on FK columns to support joins.

All constraint and index DDL is in `sql/04_constraints_indexes.sql`, written to be re-runnable using `IF EXISTS` guards.

---

## 4. Validation & Quality Metrics

Final validation queries (in `sql/05_validations.sql`) confirm:

- **Row counts** (post-cleanup):

  - Airlines: **1,108**
  - Airports: **7,697**
  - Flights: **5,000**
  - Flight performance: **22,595**
  - Passengers: **5,000**
  - Loyalty accounts: **3,000**
  - Miles transactions: **10,576**
  - Bookings: **40,000**
  - Payments: **40,000**

- **Foreign key health** – no missing parent rows:

  - Flights → Airlines/Airports: 0 missing
  - Bookings → Passengers/Flights: 0 missing
  - Payments → Bookings: 0 missing

- **Key uniqueness:**

  - Airlines IATA: 1,107 non-null, 1,107 distinct.
  - Airports IATA: 6,072 non-null, 6,072 distinct.
  - Passenger email: 5,000 non-null, 5,000 distinct.
  - Loyalty: 3,000 loyalty rows, 3,000 distinct passengers.

- **BTS coverage (2024):**

  - `year` 2024 only, 12 months.
  - 21 airlines, 357 airports.
  - Delay metrics sum to realistic large values.

- **Bookings/Payments integrity:**

  - No bookings without payments.
  - No payments without bookings.
  - 4,997 out of 5,000 flights have at least one booking.

A small “problem counts” summary table (captured in `notebooks/02_data_quality_checks.ipynb`) shows zero issues for:

- Missing FK references (flights, bookings, payments)
- Duplicate IATA codes
- Duplicate passenger emails
- Multiple loyalty accounts per passenger

---

## 5. Artifacts Produced in Phase 3

- `sql/03_dml_cleanup.sql` – standardization + deduplication
- `sql/04_constraints_indexes.sql` – constraints and indexes
- `sql/05_validations.sql` – validation queries
- `notebooks/02_data_quality_checks.ipynb` – profiling + sanity checks
- `docs/pipeline_quality_checks.png` – visualization of data quality problem counts
