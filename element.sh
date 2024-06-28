#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

# Get data from the table
ELEMENT=$($PSQL "
  SELECT e.name, e.symbol, e.atomic_number, t.type, p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius
  FROM elements e
  JOIN properties p ON e.atomic_number = p.atomic_number
  JOIN types t ON p.type_id = t.type_id
  WHERE e.atomic_number::text = '$1' OR e.name = '$1' OR e.symbol = '$1';")

# When no argument is given
if [[ -z $1 ]]; then
  echo "Please provide an element as an argument."
  exit 1

else # If an argument is given, check if it's a number, symbol or name
  if [[ $1 =~ ^[0-9]+$ || $1 =~ ^[A-Za-z]+$ ]]; then
    if [ -z "$ELEMENT" ]; then # if the number, symbol or name is not found in the database
      echo "I could not find that element in the database."
      exit 1
    else # When it is found in the database
      while read -r NAME SYMBOL ATOMIC_NUMBER TYPE ATOMIC_MASS MELTING_POINT_CELSIUS BOILING_POINT_CELSIUS;
	      do echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
      done
    fi

  fi
fi