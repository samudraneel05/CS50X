-- Keep a log of any SQL queries you execute as you solve the mystery.

-- SQL query 1
SELECT *
FROM crime_scene_reports
WHERE description LIKE "%CS50%";
-- Result: crime_scene_reports id = 295, year = 2021, month = 7, day = 28, street = Humphrey Street,
-- Description = Theft of the CS50 duck took place at 10:15am at the Humphrey Street bakery.
-- Interviews were conducted today with three witnesses who were present at the time – each of their interview transcripts mentions the bakery.


--SQL query 3
SELECT *
FROM bakery_security_logs
WHERE month = 7 AND day = 28 AND year = 2021;
--id  | year | month | day | hour | minute | activity | license_plate |
+-----+------+-------+-----+------+--------+----------+---------------+
| 261 | 2021 | 7     | 28  | 10   | 18     | exit     | 94KL13X       |

--SQL query 3
SELECT * FROM interviews WHERE year = 2021 AND month = 7 AND day = 28;
--Result:
--| 161 | Ruth|2021|7|28| Sometime within ten minutes of the theft, I saw the thief get into a car in the bakery parking lot and drive away.
-- If you have security footage from the bakery parking lot, you might want to look for cars that left the parking lot in that time frame.

--| 162 | Eugene|2021|7|28| I don't know the thief's name, but it was someone I recognized. Earlier this morning, before I arrived at Emma's bakery,
-- I was walking by the ATM on Leggett Street and saw the thief there withdrawing some money.

--| 163 | Raymond|2021|7|28| As the thief was leaving the bakery, they called someone who talked to them for less than a minute.
--In the call, I heard the thief say that they were planning to take the earliest flight out of Fiftyville tomorrow.
--The thief then asked the person on the other end of the phone to purchase the flight ticket.

--SQL query 4
SELECT *
FROM phone_calls
WHERE year = 2021 AND month = 7 AND day = 28 AND duration < 60;
--Result:
+-----+----------------+----------------+------+-------+-----+----------+
| id  |     caller     |    receiver    | year | month | day | duration |
+-----+----------------+----------------+------+-------+-----+----------+
| 233 | (367) 555-5533 | (375) 555-8161 | 2021 | 7     | 28  | 45       |
+-----+----------------+----------------+------+-------+-----+----------+


--SQL Query 5
SELECT * FROM airports;
+----+--------------+-----------------------------------------+---------------+
| id | abbreviation |                full_name                |     city      |
+----+--------------+-----------------------------------------+---------------+
| 8  | CSF          | Fiftyville Regional Airport             | Fiftyville    |
| 4  | LGA          | LaGuardia Airport                       | New York City |

--Earliest flight out of Fiftyville on the 29th:
SELECT * FROM flights WHERE year=2021 AND month=7 AND day=29;
+----+-------------------+------------------------+------+-------+-----+------+--------+
| id | origin_airport_id | destination_airport_id | year | month | day | hour | minute |
+----+-------------------+------------------------+------+-------+-----+------+--------+
| 36 | 8                 | 4                      | 2021 | 7     | 29  | 8    | 20     |

--SQL Query 6
SELECT * FROM passengers WHERE flight_id=36;
+-----------+-----------------+------+
| flight_id | passport_number | seat |
+-----------+-----------------+------+
| 36        | 5773159633      | 4A   |
+-----------+-----------------+------+

--SQL Query 7
SELECT *
  FROM atm_transactions
 WHERE year = 2021
   AND month = 7
   AND day = 28
   AND atm_location = 'Leggett Street';
   AND transaction_type = 'withdraw';
--Result:
+-----+----------------+------+-------+-----+----------------+------------------+--------+
| id  | account_number | year | month | day |  atm_location  | transaction_type | amount |
+-----+----------------+------+-------+-----+----------------+------------------+--------+
| 246 | 28500762       | 2021 | 7     | 28  | Leggett Street | withdraw         | 48     |
| 264 | 28296815       | 2021 | 7     | 28  | Leggett Street | withdraw         | 20     |
| 267 | 49610011       | 2021 | 7     | 28  | Leggett Street | withdraw         | 50     |
| 288 | 25506511       | 2021 | 7     | 28  | Leggett Street | withdraw         | 20     |
+-----+----------------+------+-------+-----+----------------+------------------+--------+

--SQL Query 8:
SELECT *
  FROM people
  JOIN bank_accounts
    ON people.id = bank_accounts.person_id
  JOIN atm_transactions
    ON bank_accounts.account_number = atm_transactions.account_number
 WHERE atm_transactions.year = 2021
   AND atm_transactions.month = 7
   AND atm_transactions.day = 28
   AND atm_transactions.atm_location = 'Leggett Street'
   AND atm_transactions.transaction_type = 'withdraw';
-- Result:
+--------+---------+----------------+-----------------+---------------+----------------+-----------+---------------+-----+--------+
|   id   |  name   |  phone_number  | passport_number | license_plate | account_number | person_id | creation_year | id  | account_number | amount |
+--------+---------+----------------+-----------------+---------------+----------------+-----------+---------------+-----+----------------+--------+
| 686048 | Bruce   | (367) 555-5533 | 5773159633      | 94KL13X       | 49610011       | 686048    | 2010          | 267 | 49610011       | 50     |

--STARTING TO COMPILE THE FACTS AND INFO:
SELECT name, bakery_security_logs.hour, bakery_security_logs.minute
  FROM people
  JOIN bakery_security_logs
    ON people.license_plate = bakery_security_logs.license_plate
 WHERE bakery_security_logs.year = 2021
   AND bakery_security_logs.month = 7
   AND bakery_security_logs.day = 28
   AND bakery_security_logs.activity = 'exit'
   AND bakery_security_logs.hour = 10
   AND bakery_security_logs.minute >= 15
   AND bakery_security_logs.minute <= 25
 ORDER BY bakery_security_logs.minute;
--Result:
+---------+------+--------+
|  name   | hour | minute |
+---------+------+--------+
| Bruce   | 10   | 18     |
+---------+------+--------+

--SQL Query 9:
SELECT name
  FROM people
 WHERE phone_number ='(375) 555-8161';
| name  |
+-------+
| Robin |