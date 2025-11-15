-- Counts
SELECT 'airports' tbl, COUNT(*) FROM airline.airports UNION ALL
SELECT 'airlines', COUNT(*) FROM airline.airlines UNION ALL
SELECT 'routes', COUNT(*) FROM airline.routes UNION ALL
SELECT 'flights', COUNT(*) FROM airline.flights UNION ALL
SELECT 'passengers', COUNT(*) FROM airline.passengers UNION ALL
SELECT 'bookings', COUNT(*) FROM airline.bookings UNION ALL
SELECT 'payments', COUNT(*) FROM airline.payments UNION ALL
SELECT 'loyalty_accounts', COUNT(*) FROM airline.loyalty_accounts UNION ALL
SELECT 'miles_transactions', COUNT(*) FROM airline.miles_transactions;

-- No duplicate flight instances (enforced by uq_flight_instance)
SELECT airline_id, flight_number, flight_date, COUNT(*)
FROM airline.flights GROUP BY 1,2,3 HAVING COUNT(*) > 1;

-- Orphan checks
SELECT COUNT(*) AS orphan_bookings
FROM airline.bookings b
LEFT JOIN airline.flights f ON f.flight_id=b.flight_id
LEFT JOIN airline.passengers p ON p.passenger_id=b.passenger_id
WHERE f.flight_id IS NULL OR p.passenger_id IS NULL;

SELECT COUNT(*) AS missing_payments
FROM airline.bookings b
LEFT JOIN airline.payments p ON p.booking_id=b.booking_id
WHERE p.booking_id IS NULL;
