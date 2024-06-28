#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=<database_name> -t --no-align -c"

# Get data from the table
ELEMENT=$($PSQL -c "
  SELECT e.name, e.symbol, e.atomic_number, t.type, p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius
  FROM elements e
  JOIN properties p ON e.atomic_number = p.atomic_number
  JOIN types t ON p.type_id = t.type_id
  WHERE e.atomic_number::text = '$1' OR e.name = '$1' OR e.symbol = '$1';")

