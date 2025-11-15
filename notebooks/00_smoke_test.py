from dotenv import load_dotenv
from sqlalchemy import create_engine, text
import os

load_dotenv()  # reads .env in project root
dsn = os.environ.get("AIRLINE_DB_DSN")
if not dsn:
    raise RuntimeError("AIRLINE_DB_DSN not set in .env")

engine = create_engine(dsn, pool_pre_ping=True)

with engine.begin() as con:
    print("DB:", con.execute(text("SELECT current_database();")).scalar())
    print("User:", con.execute(text("SELECT current_user;")).scalar())
    tables = con.execute(text("""
        SELECT table_name
        FROM information_schema.tables
        WHERE table_schema='airline'
        ORDER BY table_name
        LIMIT 10;
    """)).fetchall()
    print("Sample airline tables:", [t[0] for t in tables])
