/* setup.sql
 * initializes the database
 */

DROP TABLE IF EXISTS Registration;
CREATE TABLE Registration (
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128) NOT NULL,
  county VARCHAR(128) NOT NULL,
  zip INTEGER NOT NULL,
  dob_day INTEGER NOT NULL,
  dob_mon INTEGER NOT NULL,
  dob_year INTEGER NOT NULL,
  UNIQUE(name,county,zip,dob_day,dob_mon,dob_year)
);

DROP TABLE IF EXISTS Election;
CREATE TABLE Election (
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  deadline_day INTEGER NOT NULL,
  deadline_mon INTEGER NOT NULL,
  deadline_year INTEGER NOT NULL,
  status INTEGER NOT NULL,
  UNIQUE(deadline_day,deadline_mon,deadline_year)
);

INSERT INTO Election (id, deadline_day, deadline_mon, deadline_year, status) 
VALUES (1, 4, 7, 2026-1900, 1), 
       (2, 31, 10, 2028-1900, 1);


DROP TABLE IF EXISTS Office;
CREATE TABLE Office (
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128) NOT NULL,
  election INTEGER REFERENCES Election (id),
  UNIQUE(name,election)
);

INSERT INTO Office (id, name, election) 
VALUES (1, 'President', 1), 
       (2, 'Vice President', 1), 
       (3, 'Treasurer', 2), 
       (4, 'Marketing', 2), 
       (5, 'Fundraising', 2);


DROP TABLE IF EXISTS AllowedZip;
CREATE TABLE AllowedZip (
  zip INTEGER NOT NULL,
  office INTEGER REFERENCES Office (id)
  -- UNIQUE(zip,office)
);

INSERT INTO AllowedZip (zip, office) 
VALUES (21218, 3),
       (21218, 4),
       (21218, 5);

DROP TABLE IF EXISTS Candidate;
CREATE TABLE Candidate (
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128) NOT NULL,
  votes INTEGER NOT NULL,
  office INTEGER REFERENCES Office(id),
  UNIQUE(name,office)
);

INSERT INTO Candidate (id, name, votes, office) 
VALUES (1, 'Alice', 0, 1),
       (2, 'Bob', 0, 1),
       (3, 'Charlie', 0, 2),
       (4, 'Dave', 0, 2),
       (5, 'Eve', 0, 2),
       (6, 'Frank', 0, 3),
       (7, 'Grace', 0, 3),
       (8, 'Heidi', 0, 4),
       (9, 'Ivan', 0, 4),
       (10, 'Judy', 0, 5),
       (11, 'Mallory', 0, 5),
       (12, 'Olivia', 0, 5);

       


DROP TABLE IF EXISTS Vote;
CREATE TABLE Vote (
  voter INTEGER REFERENCES Registration (id),
  candidate INTEGER REFERENCES Candidate (id),
  office INTEGER REFERENCES Office (id),
  UNIQUE(voter,office)
);

.quit
