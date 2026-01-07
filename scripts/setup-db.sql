-- Create user and database for inventory system
-- Run this as superuser (postgres)

-- Create the inventory user if it doesn't exist
CREATE USER inventory_user WITH PASSWORD 'inventory_pass';

-- Create the database if it doesn't exist
CREATE DATABASE inventory_db OWNER inventory_user;

-- Connect to the database and grant privileges
\c inventory_db

-- Grant all privileges on database
GRANT ALL PRIVILEGES ON DATABASE inventory_db TO inventory_user;

-- Grant schema privileges
GRANT ALL PRIVILEGES ON SCHEMA public TO inventory_user;

-- Grant default privileges for future tables
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON TABLES TO inventory_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON SEQUENCES TO inventory_user;

-- Now run the init-db.sql script
\i init-db.sql
