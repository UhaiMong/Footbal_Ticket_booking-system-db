-- Users table
CREATE TABLE Users (
  user_id SERIAL PRIMARY KEY,
  full_name VARCHAR(100) NOT NULL,
  email VARCHAR(50) UNIQUE NOT NULL,
  role VARCHAR(20) CHECK (role IN ('Ticket Manager', 'Football Fan')) NOT NULL,
  phone_number VARCHAR(15)
);

-- Insert users
INSERT INTO Users(full_name, email, role, phone_number)
VALUES
('Tanvir Rahman', 'tanvir@mail.com', 'Football Fan', '+8801711111111'),
('Asif Haque', 'asif@mail.com', 'Football Fan', '+8801722222222'),
('Sajjad Rahman', 'sajjad@mail.com', 'Ticket Manager', '+8801733333333'),
('Jannat Ara', 'jannat@mail.com', 'Football Fan', NULL);

-- Matches table
CREATE TABLE Matches (
  match_id SERIAL PRIMARY KEY,
  fixture VARCHAR(200) NOT NULL,
  tournament_category VARCHAR(150) NOT NULL,
  base_ticket_price NUMERIC(10,2) NOT NULL CHECK (base_ticket_price >= 0.00),
  match_status VARCHAR(20) NOT NULL CHECK (match_status IN ('Available', 'Selling Fast', 'Sold Out', 'Postponed'))
);

-- Insert matches
INSERT INTO Matches(match_id, fixture, tournament_category,base_ticket_price, match_status)
VALUES
(101, 'Real Madrid vs Barcelona', 'Champions League', 150.00, 'Available'),
(102, 'Man City vs Liverpool', 'Premier League', 120.00, 'Selling Fast'),
(103, 'Bayern Munich vs PSG', 'Champions League', 130.00, 'Available'),
(104, 'AC Milan vs Inter Milan', 'Serie A', 90.00, 'Sold Out'),
(105, 'Juventus vs Roma', 'Serie A', 80.00, 'Available');

-- Bookings table
CREATE TABLE Bookings (
  booking_id SERIAL PRIMARY KEY,
  user_id INT NOT NULL REFERENCES Users(user_id) ON DELETE CASCADE,
  match_id INT NOT NULL REFERENCES Matches(match_id) ON DELETE CASCADE,
  seat_number VARCHAR(20),
  payment_status VARCHAR(11) CHECK (payment_status IN ('Pending', 'Confirmed', 'Cancelled', 'Refunded')),
  total_cost NUMERIC(10,2) NOT NULL CHECK (total_cost >= 0.00)
);

-- Insert bookings
INSERT INTO Bookings(booking_id, user_id,match_id,seat_number,payment_status,total_cost)
VALUES 
(501, 1, 101, 'A-12', 'Confirmed', 150.00),
(502, 1, 102, 'B-04', 'Confirmed', 120.00),
(503, 2, 101, 'A-13', 'Confirmed', 150.00),
(504, 2, 101, NULL, NULL, 150.00),
(505, 3, 102, 'C-20', 'Pending', 120.00);

-- START QUERY 

-- 1. Query
SELECT * FROM matches where tournament_category='Champions League' and match_status='Available'

--2. Query
SELECT * FROM users WHERE full_name ILIKE 'Tanvir%' OR full_name ILIKE '%Haque%'

--3. Query
SELECT booking_id, user_id, match_id, COALESCE(payment_status, 'Action Required') as systematic_status FROM Bookings WHERE payment_status IS NULL

--4. Query
SELECT booking_id, full_name, fixture, total_cost FROM bookings 
INNER JOIN users on bookings.user_id = users.user_id
INNER JOIN matches on bookings.match_id = matches.match_id

--5. Query
SELECT u.user_id, u.full_name, b.booking_id 
FROM users as u
FULL JOIN bookings as b on u.user_id =  b.user_id

--6. Query
SELECT booking_id, match_id, total_cost FROM bookings 
WHERE total_cost>(SELECT AVG(total_cost) from bookings)

--7. Query
SELECT match_id, fixture, base_ticket_price as Price FROM matches 
ORDER BY base_ticket_price DESC
LIMIT 2

-- THE END

