-- create "Users" table 1st-- 

CREATE TABLE Users (
UserID INT AUTO_INCREMENT,
UserEmailAddress VARCHAR (25) NOT NULL,
UserFirstName VARCHAR (15) NOT NULL,
UserLastName VARCHAR (20) NOT NULL,
PRIMARY KEY (UserID)
); 

INSERT INTO Users VALUES (DEFAULT,"James.Bond@gmail.com", "James", "Bond"); 
INSERT INTO Users VALUES (DEFAULT, "Lebron.James@gmail.com", "Lebron", "James"); 
INSERT INTO Users VALUES (DEFAULT, "Sandra.Bullock@gmail.com", "Sandra", "Bullock"); 
INSERT INTO Users VALUES (DEFAULT, "Tom.Hanks@gmail.com", "Tom", "Hanks"); 
INSERT INTO Users VALUES (DEFAULT, "Kevin.Hart@gmail.com", "Kevin", "Hart"); 


-- Run table "Venues" 2nd --

CREATE TABLE Venues (
VenueID INT AUTO_INCREMENT,
VenueName VARCHAR (25) NOT NULL,
VenueCity VARCHAR (25) NOT NULL,
VenueState VARCHAR (2) NOT NULL,
PRIMARY KEY (VenueID)
);

INSERT INTO Venues VALUES (DEFAULT, "Wells Fargo Center", "Philadelphia", "PA");
INSERT INTO Venues VALUES (DEFAULT, "Citizens Bank Park", "Philadelphia", "PA");
INSERT INTO Venues VALUES (DEFAULT, "Lincoln Financial Field", "Philadelphia", "PA");
INSERT INTO Venues VALUES (DEFAULT, "MetLife Stadium", "East Rutherford", "NJ");
INSERT INTO Venues VALUES (DEFAULT, "Madison Square Garden", "New York", "NY");


-- run table "Event1" 3rd --

CREATE TABLE Event1 (
EventID INT AUTO_INCREMENT,
EventName VARCHAR (50) NOT NULL,
EventTime TIME NOT NULL,
VenueID INT NOT NULL,
EventDate DATE NOT NULL,
PRIMARY KEY (EventID),
FOREIGN KEY (VenueID) REFERENCES Venues(VenueID)
);

INSERT INTO Event1 VALUES (DEFAULT, "Bon Jovi", "07:00:00" , 1 , '2022-11-10');
INSERT INTO Event1 VALUES (DEFAULT, "Aerosmith", "06:30:00" , 2 , '2022-11-14');
INSERT INTO Event1 VALUES (DEFAULT, "Guns & Roses", "07:30:00" , 3 , '2022-11-19');
INSERT INTO Event1 VALUES (DEFAULT, "Van Halen", "08:30:00" , 4 , '2022-12-05');
INSERT INTO Event1 VALUES (DEFAULT, "Foreigner", "07:15:00" , 5 , '2022-10-05');


-- create table "Ticket Listings" 4th --

CREATE TABLE TicketListings (
TicketListingID INT AUTO_INCREMENT,
SellerID INT,
EventID INT NOT NULL,
NumTickets INT NOT NULL,
PricePerTicket VARCHAR (25) NOT NULL,
PRIMARY KEY (TicketListingID),
FOREIGN KEY (EventID) REFERENCES Event1(EventID),
FOREIGN KEY (SellerID) REFERENCES Users (UserID)
); 

INSERT INTO TicketListings VALUES (DEFAULT, 2, 4, 3, "$25.00");
INSERT INTO TicketListings VALUES (DEFAULT, 4, 2, 6, "$27.00");
INSERT INTO TicketListings VALUES (DEFAULT, 5, 1, 2, "$55.00");
INSERT INTO TicketListings VALUES (DEFAULT, 3, 3, 2, "$80.00");
INSERT INTO TicketListings VALUES (DEFAULT, 1, 5, 4, "$50.00");


-- Create "Ticket Sales" 5th --

CREATE TABLE TicketSales (
TransactionID INT AUTO_INCREMENT,
BuyerID INT NOT NULL,
TicketListingID INT NOT NULL,
PRIMARY KEY (TransactionID),
FOREIGN KEY (TicketListingID) REFERENCES TicketListings(TicketListingID),
FOREIGN KEY (BuyerID) REFERENCES Users (UserID)
);


INSERT INTO TicketSales VALUES (DEFAULT, 2, 3);
INSERT INTO TicketSales VALUES (DEFAULT, 4, 5);
INSERT INTO TicketSales VALUES (DEFAULT, 3, 1);
INSERT INTO TicketSales VALUES (DEFAULT, 1, 2);
INSERT INTO TicketSales VALUES (DEFAULT, 5, 4);