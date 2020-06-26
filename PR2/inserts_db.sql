SET search_path TO ubd_20182;

BEGIN WORK;
SET TRANSACTION READ WRITE;

SET datestyle = DMY;

INSERT INTO PERSON VALUES(1, 'Daniel Day-Lewis', '29-04-1957', null, 'M', 'Irish');
INSERT INTO PERSON VALUES(2, 'Tom Hanks', '09-07-1956', null, 'M', 'American');
INSERT INTO PERSON VALUES(3, 'Robert De Niro', '17-08-1943', null, 'M', 'American');
INSERT INTO PERSON VALUES(4, 'Christian Bale', '30-01-1974', null, 'M', 'British');
INSERT INTO PERSON VALUES(5, 'Meril Streep', '22-06-1949', null, 'F', 'American');
INSERT INTO PERSON VALUES(6, 'Geoffrey Rush', '06-07-1951', null, 'M', 'Australian');
INSERT INTO PERSON VALUES(7, 'Bruce Willis', '29-04-1957', null, 'M', 'Irish');
INSERT INTO PERSON VALUES(8, 'Francis Ford Coppola', '29-04-1957', null, 'M', 'American');
INSERT INTO PERSON VALUES(9, 'Marlon Brando', '03-04-1924', '01-07-2004', 'M', 'American');
INSERT INTO PERSON VALUES(10, 'Al Pacino', '25-04-1940', null, 'M', 'American');
INSERT INTO PERSON VALUES(11, 'Andy García', '12-04-1956', null, 'M', 'Cuban');
INSERT INTO PERSON VALUES(12, 'Jim Sheridan', '06-02-1949', null, 'M', 'Irish');
INSERT INTO PERSON VALUES(13, 'Christopher Nolan', '30-07-1970', null, 'M', 'British');
INSERT INTO PERSON VALUES(14, 'Steven Spilberg', '18-02-1946', null, 'M', 'American');
INSERT INTO PERSON VALUES(15, 'Brad Silberling', '08-09-1963', null, 'M', 'American');
INSERT INTO PERSON VALUES(16, 'Sergio Leone', '30-04-1929', '30-04-1989', 'M', 'Italian');
INSERT INTO PERSON VALUES(17, 'Jude Law', '29-12-1972', null, 'M', 'British');
INSERT INTO PERSON VALUES(18, 'Gore Verbinski', '16-03-1964', null, 'M', 'American');
INSERT INTO PERSON VALUES(19, 'Johnny Depp', '09-06-1963', null, 'M', 'American'); 
INSERT INTO PERSON VALUES(20, 'Clint Eastwood', '31-05-1930', null, 'M', 'American');
INSERT INTO PERSON VALUES(21, 'Ben Stiller', '30-11-1965', null, 'M', 'American');
INSERT INTO PERSON VALUES(22, 'David Bowie', '08-01-1947', '10-01-2016', 'M', 'British');
INSERT INTO PERSON VALUES(23, 'Tim Burton', '25-08-1958', null, 'M', 'American');
INSERT INTO PERSON VALUES(24, 'Helena Bonham Carter', '26-05-1966', null, 'F', 'British');
INSERT INTO PERSON VALUES(25, 'Alfred Hitchcock', '13-08-1899', '29-04-1980', 'M', 'British');
INSERT INTO PERSON VALUES(26, 'Janet Leigh', '06-07-1927', '03-10-2004', 'F', 'American');
INSERT INTO PERSON VALUES(27, 'Bernardo Bertolucci', '16-03-1941', null, 'M', 'Italian');
INSERT INTO PERSON VALUES(28, 'Franklin J. Schaffner', '30-05-1920', '02-07-1989', 'M', 'Japanese');
INSERT INTO PERSON VALUES(29, 'Aljandro Amenábar', '31-03-1972', null, 'M', 'Spanish');



INSERT INTO DIRECTOR VALUES(8, 1963, 9);
INSERT INTO DIRECTOR VALUES(12, 1989, 1);
INSERT INTO DIRECTOR VALUES(13, 1989, 4);
INSERT INTO DIRECTOR VALUES(14, 1963, 7);
INSERT INTO DIRECTOR VALUES(15, 1987);
INSERT INTO DIRECTOR VALUES(16, 1959);
INSERT INTO DIRECTOR VALUES(18, 1989, 1);
INSERT INTO DIRECTOR VALUES(20, 1971, 3);
INSERT INTO DIRECTOR VALUES(21, 1994);
INSERT INTO DIRECTOR VALUES(23, 1982, 2);
INSERT INTO DIRECTOR VALUES(25, 1919, 7);
INSERT INTO DIRECTOR VALUES(27, 1962, 1);
INSERT INTO DIRECTOR VALUES(28, 1963);
INSERT INTO DIRECTOR VALUES(29, 1992, 3);


INSERT INTO ACTOR VALUES(1);
INSERT INTO ACTOR VALUES(2);
INSERT INTO ACTOR VALUES(3);
INSERT INTO ACTOR VALUES(4);
INSERT INTO ACTOR VALUES(5);
INSERT INTO ACTOR VALUES(6);
INSERT INTO ACTOR VALUES(9);
INSERT INTO ACTOR VALUES(10);
INSERT INTO ACTOR VALUES(11);
INSERT INTO ACTOR VALUES(17);
INSERT INTO ACTOR VALUES(19);
INSERT INTO ACTOR VALUES(20);
INSERT INTO ACTOR VALUES(21);
INSERT INTO ACTOR VALUES(22);
INSERT INTO ACTOR VALUES(24);
INSERT INTO ACTOR VALUES(26);

INSERT INTO MOVIE VALUES(1, 'The Godfather', 'Crime', 1972, 'United States', 175, 7000000, 268500000, null, 8);
INSERT INTO MOVIE VALUES(2, 'The Godfather: Part II', 'Crime', 1974, 'United States', 200, 13000000, 57300000, 1, 8);
INSERT INTO MOVIE VALUES(3, 'The Godfather: Part III', 'Crime', 1990, 'United States', 162, 7000000, 268500000, 2, 8);
INSERT INTO MOVIE VALUES(4, 'In the Name of the Father', 'Drama', 1990, 'United States', 133, 13000000, 65800000, null, 12);
INSERT INTO MOVIE VALUES(5, 'Batman Begins', 'Action', 2005, 'United States', 140, 150000000, 375200000, null, 13);
INSERT INTO MOVIE VALUES(6, 'The Dark Knight', 'Action', 2008, 'United States', 152, 185000000, 1005000000, 5, 13);
INSERT INTO MOVIE VALUES(7, 'The Dark Knight Rises', 'Action', 2012, 'United States', 165, 230000000, 1085000000, 6, 13);
INSERT INTO MOVIE VALUES(8, 'Saving Private Ryan', 'War', 1998, 'United States', 169, 70000000, 481800000, null, 14);
INSERT INTO MOVIE VALUES(9, 'Lemony Snicket''s A Series of Unfortunate Events', 'Comedy', 2004, 'United States', 107, 140000000, 209100000, null, 15);
INSERT INTO MOVIE VALUES(10,'The Good, the Bad and the Ugly', 'Western', 1966, 'Italy', 177, 1200000, 25100000, null, 16);
INSERT INTO MOVIE VALUES(11,'Pirates od the Caribbean: The Curse of the Black Pearl', 'Adventure', 2003, 'United States', 142, 140000000, 653300000, null, 18);
INSERT INTO MOVIE VALUES(12,'Gran Torino', 'Drama', 2008, 'United States', 116, 33000000, 270000000, null, 20);
INSERT INTO MOVIE VALUES(13, 'Zoolander', 'Comedy', 2001, 'United States', 89, 28000000, 60800000, null, 21);
INSERT INTO MOVIE VALUES(14, 'Sweeney Todd: The Demon Barber of Fleet Street', 'Musical', 2007, 'United Kingdom', 116, 50000000, 152500000, null, 23);
INSERT INTO MOVIE VALUES(15, 'Psycho', 'Horror', 1960, 'United States', 109, 806947, 50000000, null, 25);
INSERT INTO MOVIE VALUES(16, 'The Last Emperor', 'Historical', 1987, 'United Kingdom', 163, 23800000, 44000000, null, 27);
INSERT INTO MOVIE VALUES(17, 'Planet of the Apes', 'ScienceFiction', 1968, 'United States', 112, 5800000, 33400000, null, 28);
INSERT INTO MOVIE VALUES(18, 'Last Tango in Paris', 'Drama', 1972, 'United States', 175, 5000000, 168500000, null, 27);

INSERT INTO PARTICIPATION VALUES(9, 1, 'Vito Corleone', 'Leading');
INSERT INTO PARTICIPATION VALUES(10, 1, 'Michael Corleone', 'Supporting');
INSERT INTO PARTICIPATION VALUES(10, 2, 'Michael Corleone', 'Leading');
INSERT INTO PARTICIPATION VALUES(3, 2, 'Vito Corleone', 'Supporting');
INSERT INTO PARTICIPATION VALUES(10, 3, 'Michael Corleone', 'Leading');
INSERT INTO PARTICIPATION VALUES(11, 3, 'Vincent Corleone', 'Supporting');
INSERT INTO PARTICIPATION VALUES(1, 4, 'Gerry Conlon', 'Leading');
INSERT INTO PARTICIPATION VALUES(4, 5, 'Bruce Wayne', 'Leading');
INSERT INTO PARTICIPATION VALUES(4, 6, 'Bruce Wayne', 'Leading');
INSERT INTO PARTICIPATION VALUES(4, 7, 'Bruce Wayne', 'Leading');
INSERT INTO PARTICIPATION VALUES(2, 8, 'Captain Miller', 'Leading');
INSERT INTO PARTICIPATION VALUES(5, 9, 'Josephine Anwhistle', 'Supporting');
INSERT INTO PARTICIPATION VALUES(17, 9, 'Lemony Snicket', 'Narrator');
INSERT INTO PARTICIPATION VALUES(19, 11, 'Jack Sparrow', 'Leading');
INSERT INTO PARTICIPATION VALUES(6, 11, 'Hector Barbossa', 'Supporting');
INSERT INTO PARTICIPATION VALUES(20, 12, 'Walt Kowalski', 'Leading');
INSERT INTO PARTICIPATION VALUES(20, 10, 'Blondie', 'Leading');
INSERT INTO PARTICIPATION VALUES(21, 13, 'Derek Zoolander', 'Leading');
INSERT INTO PARTICIPATION VALUES(22, 13, 'as himself', 'Cameo');
INSERT INTO PARTICIPATION VALUES(19, 14, 'Sweeney Todd', 'Leading');
INSERT INTO PARTICIPATION VALUES(24, 14, 'Nellie Lovett', 'Supporting');
INSERT INTO PARTICIPATION VALUES(26, 15, 'Marion Crane', 'Supporting');
INSERT INTO PARTICIPATION VALUES(9, 18, 'Paul', 'Leading');



COMMIT;
