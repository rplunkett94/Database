--Ryan Plunkett
--Lab 8
--Normalization 2

DROP TABLE IF EXISTS actors;
DROP TABLE IF EXISTS persons;
DROP TABLE IF EXISTS movies;
DROP TABLE IF EXISTS directors;
DROP TABLE IF EXISTS alink;
DROP TABLE IF EXISTS dlink;

--create tables--
CREATE TABLE persons(
	pid serial not null,
	name TEXT,
	address VARCHAR(50),
	birthdate DATE,
	PRIMARY KEY(pid)
);

CREATE TABLE directors(
	did INT,
	film_school TEXT,
	directors_guild_anniversary_date DATE,
	PRIMARY KEY(did)
);

CREATE TABLE actors(
	aid INT REFERENCES persons(pid),
	hair_color VARCHAR(20),
	eye_color VARCHAR(20),
	height_inches INT,
	weight INT,
	actors_guild_anniversity_date DATE,
	PRIMARY KEY(aid)
);

CREATE TABLE movies (
	mid serial,
	name TEXT,
	year DATE,
	domestic_box_office INT,
	foreign_box_office INT,
	dvd_sales INT,
	PRIMARY KEY(mid)
);

CREATE TABLE dlink(
	did INT REFERENCES directors(did),
	mid INT REFERENCES movies,
	PRIMARY KEY(did,mid)
);

CREATE TABLE alink(
	aid INT REFERENCES actors(aid),
	mid INT REFERENCES movies,
	PRIMARY KEY(aid,mid)
);

INSERT INTO persons(name, address, birthdate)
VALUES	('Sean Connery', '100 Curchhill Rd', '08/25/1930'),
	('Nicholas Cage', '98 Hyde Drive', '01/07/1964' ),
	('Sean Bean', '20 North St', '04/17/1959' ),
	('John Belushi', '1 Fame Place', '01/24/1949'),
	('Kevin Bacon', '10 Bacon St', '07/08/1968'),
	('Peter Jackson', '210 Hobbit Hole', '10/31/1961'),
	('John Landis', '21 Glory Hole', '12/09/1951'),
	('Michael Bay', '1 one way', '4/04/1970');

INSERT INTO directors(did, film_school, directors_guild_anniversary_date)
VALUES 	((select pid
	from persons
	where name= 'Nicholas Cage'),'Hardvard', '01/01/2010'),
	((select pid
	from persons
	where name= 'John Landis'),'School', '02/08/2000'),
	((select pid
	from persons
	where name= 'Michael Bay'),'Broadway', '07/28/1969'),
	((select pid
	from persons
	where name= 'Peter Jackson'),'Marist', '04/22/1999');

INSERT INTO actors(aid, hair_color, eye_color, height_inches, weight,
		actors_guild_anniversity_date)
VALUES	((select pid
	from persons
	where name= 'Sean Connery'),'grey', 'blue', 72, 160, '09/07/2000'),
	((select pid
	from persons
	where name= 'Nicholas Cage'),'brown', 'black', 69, 150,'12/25/2005'),
	((select pid
	from persons
	where name= 'Sean Bean'),'red', 'brown', 71, 180,'01/01/2002'),
	((select pid
	from persons
	where name= 'John Belushi'), 'black', 'blue', 70, 200, '02/05/1978'),
	((select pid
	from persons
	where name= 'Kevin Bacon'), 'blonde', 'blue', 70, 160, '06/10/1980');
	
INSERT INTO movies(name, year, domestic_box_office, foreign_box_office,
		dvd_sales)
VALUES	('Animal House', '06/01/1978', 500000, 10000, 50000),
	('The Lord of The Rings', '12/19/2001', 1000000, 500000, 30000),
	('The Rock', '06/07/1996', 250000, 5000, 2500),
	('National Treasure', '11/19/2004', 25000, 2000, 10);

INSERT INTO dlink(did, mid)
VALUES	((select pid
	from persons
	where name= 'Nicholas Cage'),(select mid 
					from movies
					where name= 'The Rock')),
	((select pid
	from persons
	where name= 'John Landis'),(select mid 
					from movies
					where name= 'Animal House')),
	((select pid
	from persons
	where name= 'Michael Bay'),(select mid 
					from movies
					where name= 'The Rock')),
	((select pid
	from persons
	where name= 'Peter Jackson'),(select mid 
					from movies
					where name= 'The Lord of The Rings'));
				

INSERT INTO alink(aid, mid)
VALUES	((select pid
	from persons
	where name= 'Sean Connery'),(select mid 
					from movies
					where name= 'The Rock')),
					
	((select pid
	from persons
	where name= 'Sean Bean'),(select mid 
					from movies
					where name= 'The Lord of The Rings')),

	((select pid
	from persons
	where name= 'Nicholas Cage'),(select mid 
					from movies
					where name= 'The Rock')),
	((select pid
	from persons
	where name= 'John Belushi'),(select mid 
					from movies
					where name= 'Animal House')),
	((select pid
	from persons
	where name= 'Kevin Bacon'),(select mid 
					from movies
					where name= 'Animal House'));

SELECT * FROM persons;
SELECT * FROM directors;
SELECT * FROM actors;
SELECT * FROM movies;

SELECT DISTINCT persons.name FROM
	persons,
	directors,
	movies,
	dlink
	
	WHERE dlink.did = directors.did 
	AND directors.did = persons.pid 
	AND movies.mid = dlink.mid 
	AND dlink.mid
		IN (SELECT movies.mid FROM
			persons,
			actors,
			movies,
			alink 

			WHERE persons.pid = actors.aid 
			AND actors.aid = alink.aid 
			AND movies.mid = alink.mid 
			AND persons.name = 'Sean Connery' 
			);





