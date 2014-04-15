--Ryan Plunkett
--Lab 9
--Normalization 3

DROP TABLE IF EXISTS persons;
DROP TABLE IF EXISTS astronauts;
DROP TABLE IF EXISTS engineers;
DROP TABLE IF EXISTS flight_control_oporators;
DROP TABLE IF EXISTS spacecraft;
DROP TABLE IF EXISTS crew;
DROP TABLE IF EXISTS space_crew;
DROP TABLE IF EXISTS suppliers;
DROP TABLE IF EXISTS parts;
DROP TABLE IF EXISTS catalog;
DROP TABLE IF EXISTS systems;
DROP TABLE IF EXISTS technology;
DROP TABLE IF EXISTS system_control;

--create tables--
CREATE TABLE persons(
	pid serial not null,
	name TEXT, 
	age INT,
	PRIMARY KEY(pid)
);

CREATE TABLE astronauts(
	aid INT REFERENCES persons(pid),
	years_flying INT,
	golf_handicap INT,
	PRIMARY KEY(aid)
);

CREATE TABLE engineers(
	eid INT REFERENCES persons(pid),
	higest_degree TEXT,
	fav_video_game TEXT,
	PRIMARY KEY(eid)
);

CREATE TABLE flight_control_operators(
	foid INT REFERENCES persons(pid),
	chair_preference INT,
	preferred_drink TEXT,
	PRIMARY KEY(foid)
);

CREATE TABLE spacecraft(
	scid INT,
	name TEXT,
	tail_number INT,
	weight INT,
	fuel_type TEXT,
	crew_cap INT,
	PRIMARY KEY(scid)
);1

CREATE TABLE crew(
	aid INT REFERENCES astronauts(aid),
	scid INT REFERENCES spacecraft(scid),
);

CREATE TABLE space_crew(
	foid INT REFERENCES field_control_operstors(foid),
	eid INT REFERENCES engineers(eid),
	scid INT REFERENCES spacecraft(scid),
);

CREATE TABLE suppliers(
	sid INT,
	name TEXT,
	address TEXT,
	payment_terms TEXT,
	PRIMARY KEY(sid)
);

CREATE TABLE parts(
	part_id INT,
	name TEXT,
	discription TEXT,
	PRIMARY KEY(part_id)
);

CREATE TABLE systems(
	system_id INT,
	name TEXT,
	description TEXT,
	PRIMARY KEY(system_id)
);

CREATE TABLE catalog(
	sid INT REFERENCES suppliers(sid),
	part_id INT REFERENCES parts(part_id),
	system_id INT REFERENCES systems(system_id)
	
);

CREATE TABLE system_control(
	scid INT REFERENCES spacecraft(scid),
	system_id INT REFERENCES systems(system_id),
	PRIMARY KEY(aid,scid)
);

INSERT INTO persons(name, age)
VALUES	('Ryan Plunkett', 20),
	('Tom McArdle', 19),
	('Nick Sibilla', 22),
	('Walter White', 52 ),
	('Darth Vader', 65),
	('Sean Connery', 72),
	('Harry Potter', 18),
	('Obiwan Kanobi' 40),
	('Liam Neesoln' 60);

INSERT INTO astronauts(aid, years_flying, golf_handicap)
VALUES	((select pid
	from persons
	where name= 'Ryan Plunkett'), 10, 5),
	((select pid
	from persons
	where name= 'Tom McArdle'), 3, 2),
	((select pid
	from persons
	where name= 'Liam Neesoln'),8, 1);

INSERT INTO engineers(eid, years_flying, golf_handicap)
VALUES	((select pid
	from persons
	where name= 'Harry Potter'),'Phd of Science', 'Call of Duty' ),
	((select pid
	from persons
	here name= 'Darth Vader'),'Masters of Science', 'Halo'),
	((select pid
	from persons
	where name= 'Sean Connery'),'G.E.D', 'pong');

INSERT INTO flight_control_operatinos(years_flying, golf_handicap)
VALUES	((select pid
	from persons
	where name= 'Nick Sibilla'),11, 'Water'),
	((select pid
	from persons
	where name= 'Walter White'),35, 'Coke'),
	((select pid
	from persons
	name= 'Obiwan Kanobi'),61,'Wiskey');

INSERT INTO spacecraft(scid, name, tail_number, weight, fuel_type, crew_cap)
VALUES	(1, 'Odyssey', 2, 20, 'moonshine', 2),
	(2, 'Pandora', 55, 6, 'electric', 8 ),
	(3, 'Top Gun', 100, 1,'air' 12),
	(4, 'Apollo24', 24, 10, 'gasoline', 10);

INSERT INTO crew(aid, scid) 
VALUES ((select pid
	from persons
	where name= 'Ryan Plunkett'),(select scid 
					from spacecraft
					where name= 'Odyssey')),
	((select pid
	from persons
	where name= 'Liam Neesoln'),(select scid 
					from spacecraft
					where name= 'Pandora')),
	((select pid
	from persons
	where name= 'Tom McArdle'),(select scid 
					from spacecraft
					where name= 'Top Gun'));

INSERT INTO space_crew(foid, eid, scid) 
VALUES ((select pid
	from persons
	where name= 'Nick Sibilla'),(select pid
					from persons
					where name= 'Harry Potter'),(select scid 
									from spacecraft
									where name= 'Apollo24')),
	((select pid
	from persons
	where name= 'Obiwan Kanobi'),(select pid
					from persons
					where name= 'Darth Vader'),(select scid 
									from spacecraft
									where name= 'Pandora')),
	((select pid
	from persons
	where name= 'Walter White'),(select pid
					from persons
					where name= 'Sean Connery'),(select scid 
									from spacedraft
									where name= 'Odyssey')),
	((select pid
	from persons
	where name= 'Walter White'),(select pid
					from persons
					where name= 'Darth Vader'),(select scid 
									from spacedraft
									where name= 'Odyssey')),
	((select pid
	from persons
	where name= 'Nick Sibilla'),(select pid
					from persons
					where name= 'Sean Connery'),(select scid 
									from spacedraft
									where name= 'Top Gun')),
	((select pid
	from persons
	where name= 'Obiwan Kanobi'),(select pid
					from persons
					where name= 'Darth Vader'),(select scid 
									from spacedraft
									where name= 'Pandora'));

INSERT INTO suppliers(sid, name, address, payment_terms) 
VALUES	(1, 'IBM', '112 MockingJay Ln', 'cash'),
	(2, 'U.S Military', 'United States' 'I.O.U');
	
INSERT INTO parts(partid, name, description) 
VALUES	(100, 'engine', 'part make vroom vroom'),
	(101, ' windshield', 'for all that space wind'),
	(102, 'trackor beem', 'brings stuff closer'),
	(103, 'anti-gravity', 'enables gravity');

INSERT INTO systems(system_id, name, description,) 
VALUES	(001, 'google', 'for research'),
	(002 'netflix', 'dor when your bored'),
	(003, 'Microsoft', 'for everything else');

INSERT INTO catalog(sid, part_id, system_id) 
VALUES	((select sid
	from suppliers
	where name= 'IBM'),(select part_id
				from parts
				where name= 'engine'),(select scid 
								from spacedraft
								where name= 'Top Gun')),
	((select sid
	from suppliers
	where name= 'IBM'),(select part_id
				from parts
				where name= 'windshield'),(select scid 
								from spacedraft
								where name= 'Pandora')),
	((select sid
	from suppliers
	where name= 'U.S Military'),(select part_id
					from parts
					where name= 'anti-gravity'),(select scid 
									from spacedraft
									where name= 'Odyssey')),
	((select sid
	from suppliers
	where name= 'IBM'),(select part_id
				from parts
				where name= 'tractor beam'),(select scid 
								from spacedraft
								where name= 'Apollo24')),
	((select sid
	from suppliers
	where name= 'IBM'),(select part_id
				from parts
				where name= 'engine'),(select scid 
								from spacedraft
								where name= 'Odyssey')),
	((select sid
	from suppliers
	where name= 'U.S Military'),(select part_id
				from parts
				where name= 'tractor beam'),(select scid 
								from spacedraft
								where name= 'Top Gun')),
	((select sid
	from suppliers
	where name= 'IBM'),(select part_id
				from parts
				where name= 'engine'),(select scid 
								from spacedraft
								where name= 'Apollo24')),

INSERT INTO system_control(scid, system_id) 
VALUES	((select scid
	from spacecraft
	where name= 'Top Gun'),(select system_id 
				from systems
				where name= 'google')),
	((select scid
	from spacecraft
	where name= 'Pandora'),(select system_id 
					from systems
					where name= 'netflix')),
	((select scid
	from spacecraft
	where name= 'Apollo24'),(select system_id 
					from systems
					where name= 'Microsoft')),
	((select scid
	from spacecraft
	where name= 'Odyssey'),(select system_id 
					from systems
					where name= 'netflix')),
	((select scid
	from spacecraft
	where name= 'Pandora'),(select system_id 
					from systems
					where name= 'google')),
	((select scid
	from spacecraft
	where name= 'Top Gun'),(select system_id 
					from systems
					where name= 'Microsoft'));