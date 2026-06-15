# Football Ticket Booking System - Database Design & SQL Queries

## Overview & Objectives

Learning and understanding of database table design, ERD relationships, and intermediate-to-advanced SQL queries. Usefule queries are covered with a simplified **Football Ticket Booking System** database.

### Tables To create

1. Users
2. Matches
3. Bookings

### 1. Users Table

| **user_id** | **full_name** | **email**       | **role**       | **phone_number** |
| ----------- | ------------- | --------------- | -------------- | ---------------- |
| 1           | Tanvir Rahman | tanvir@mail.com | Football Fan   | +8801711111111   |
| 2           | Asif Haque    | asif@mail.com   | Football Fan   | +8801722222222   |
| 3           | Sajjad Rahman | sajjad@mail.com | Ticket Manager | +8801733333333   |
| 4           | Jannat Ara    | jannat@mail.com | Football Fan   | _NULL_           |

### 2. Matches Table

| **match_id** | **fixture**              | **tournament_category** | **base_ticket_price** | **match_status** |
| ------------ | ------------------------ | ----------------------- | --------------------- | ---------------- |
| 101          | Real Madrid vs Barcelona | Champions League        | 150                   | Available        |
| 102          | Man City vs Liverpool    | Premier League          | 120                   | Selling Fast     |
| 103          | Bayern Munich vs PSG     | Champions League        | 130                   | Available        |
| 104          | AC Milan vs Inter Milan  | Serie A                 | 90                    | Sold Out         |
| 105          | Juventus vs Roma         | Serie A                 | 80                    | Available        |

### 3. Bookings Table

| **booking_id** | **user_id** | **match_id** | **seat_number** | **payment_status** | **total_cost** |
| -------------- | ----------- | ------------ | --------------- | ------------------ | -------------- |
| 501            | 1           | 101          | A-12            | Confirmed          | 150            |
| 502            | 1           | 102          | B-04            | Confirmed          | 120            |
| 503            | 2           | 101          | A-13            | Confirmed          | 150            |
| 504            | 2           | 101          | _NULL_          | _NULL_             | 150            |
| 505            | 3           | 102          | C-20            | Pending            | 120            |

## Selected question to answere varbal

### Query 1: Retrieve all upcoming football matches belonging to the 'Champions League' where the match status is 'Available'.

**Sample Output:**

| **match_id** | **fixture**              | **base_ticket_price** |
| ------------ | ------------------------ | --------------------- |
| 101          | Real Madrid vs Barcelona | 150                   |
| 103          | Bayern Munich vs PSG     | 130                   |

### Query 2: Search for all users whose full names start with 'Tanvir' or contain the phrase 'Haque' (case-insensitive).

- **Concepts used:** `LIKE`, `ILIKE`

**Sample Output:**

| **user_id** | **full_name** | **email**       |
| ----------- | ------------- | --------------- |
| 1           | Tanvir Rahman | tanvir@mail.com |
| 2           | Asif Haque    | asif@mail.com   |

### Query 3: Retrieve all booking records where the payment status is missing (`NULL`), replacing the empty result with 'Action Required'.

- **Concepts used:** `IS NULL`, `COALESCE`

**Sample Output:**

| **booking_id** | **user_id** | **match_id** | **systematic_status** |
| -------------- | ----------- | ------------ | --------------------- |
| 504            | 2           | 101          | Action Required       |

### Query 4: Retrieve match booking details along with the User's full name and the scheduled Match fixture teams.

- **Concepts used:** `INNER JOIN`

**Sample Output:**

| **booking_id** | **full_name** | **fixture**              | **total_cost** |
| -------------- | ------------- | ------------------------ | -------------- |
| 501            | Tanvir Rahman | Real Madrid vs Barcelona | 150            |
| 502            | Tanvir Rahman | Man City vs Liverpool    | 120            |
| 503            | Asif Haque    | Real Madrid vs Barcelona | 150            |
| 504            | Asif Haque    | Real Madrid vs Barcelona | 150            |
| 505            | Sajjad Rahman | Man City vs Liverpool    | 120            |

### Query 5: Display a comprehensive list of all users and their booking IDs, ensuring that fans who have _never_ bought a ticket are still listed.

- **Concepts used:** `LEFT JOIN / Full JOIN`

**Sample Output:**

| **user_id** | **full_name** | **booking_id** |
| ----------- | ------------- | -------------- |
| 1           | Tanvir Rahman | 501            |
| 1           | Tanvir Rahman | 502            |
| 2           | Asif Haque    | 503            |
| 2           | Asif Haque    | 504            |
| 3           | Sajjad Rahman | 505            |
| 4           | Jannat Ara    | _NULL_         |

### Query 6: Find all ticket bookings where the total cost is strictly higher than the average cost of all ticket bookings.

**Sample Output:**

| **booking_id** | **match_id** | **total_cost** |
| -------------- | ------------ | -------------- |
| 501            | 101          | 150            |
| 503            | 101          | 150            |
| 504            | 101          | 150            |

### Query 7: Retrieve the top 2 most expensive matches sorted by base ticket price, skipping the absolute highest premium match.

**Sample Output:**

_(Skips Real Madrid vs Barcelona at 150)_

| **match_id** | **fixture**           | **base_ticket_price** |
| ------------ | --------------------- | --------------------- |
| 103          | Bayern Munich vs PSG  | 130                   |
| 102          | Man City vs Liverpool | 120                   |

[ERD URL](https://drawsql.app/teams/uhai-mong/diagrams/footbal-ticket-booking-erd)

[Github Repo](https://github.com/UhaiMong/Footbal_Ticket_booking-system-db.git)

[Interview Video Drive Link](https://drive.google.com/file/d/1d08rJYW4ObNsP8Etx-WzStOPS_DKpwaH/view?usp=sharing)
