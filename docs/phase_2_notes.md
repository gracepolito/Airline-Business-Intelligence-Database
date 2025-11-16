# Phase 2 – Data Acquisition, Synthesis, and Loading

## Scope

Phase 2 extends the Airline Business Intelligence warehouse with:

- **Reference data**
  - OpenFlights airports → `airline.airports`
  - OpenFlights airlines → `airline.airlines`
- **Operational flight data**
  - Synthetic schedule + status → `airline.flights`
  - BTS on-time performance → `airline.flight_performance`
- **Customer & loyalty**
  - Synthetic passengers → `airline.passengers`
  - Synthetic loyalty accounts → `airline.loyalty_accounts`
  - Synthetic miles transactions → `airline.miles_transactions`
- **Commercial / revenue**
  - Synthetic bookings → `airline.bookings`
  - Synthetic payments → `airline.payments`

All data is either **public** (OpenFlights, BTS) or **synthetic** (Faker-generated).

---

## ETL Entry Points

Python ETL scripts (run from project root, with `.venv` active and `DATABASE_URL` exported):

```bash
python etl/load_openflights.py       # airports + airlines
python etl/synth_flights.py          # synthetic flights
python etl/load_bts_performance.py   # BTS into flight_performance
python etl/synth_customers.py        # passengers + loyalty + miles
python etl/synth_revenue.py          # bookings + payments
