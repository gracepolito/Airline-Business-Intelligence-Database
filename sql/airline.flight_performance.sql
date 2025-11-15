-- Make sure we’re defaulting to the airline schema in this session
SET search_path TO airline, public;

-- Create table inside airline schema
CREATE TABLE airline.flight_performance (
    snapshot_id TEXT PRIMARY KEY,                       -- e.g., 2024_01_MQ_EWR
    year INT NOT NULL,
    month INT NOT NULL,
    airline_iata VARCHAR(5) NOT NULL,
    airport_iata VARCHAR(5) NOT NULL,
    arrivals INT,
    arrivals_delayed_15min INT,
    arr_cancelled INT,
    arr_diverted INT,
    total_arrival_delay_min DOUBLE PRECISION,
    carrier_delay DOUBLE PRECISION,
    weather_delay DOUBLE PRECISION,
    nas_delay DOUBLE PRECISION,
    security_delay DOUBLE PRECISION,
    late_aircraft_delay DOUBLE PRECISION,
    CONSTRAINT uq_fp UNIQUE (year, month, airline_iata, airport_iata),
    CONSTRAINT fk_fp_airline  FOREIGN KEY (airline_iata)  REFERENCES airline.airlines(iata_code),
    CONSTRAINT fk_fp_airport  FOREIGN KEY (airport_iata)  REFERENCES airline.airports(iata_code)
);

-- Helpful indexes for lookups
CREATE INDEX IF NOT EXISTS idx_fp_month ON airline.flight_performance (year, month);
CREATE INDEX IF NOT EXISTS idx_fp_airline ON airline.flight_performance (airline_iata);
CREATE INDEX IF NOT EXISTS idx_fp_airport ON airline.flight_performance (airport_iata);



