-- Data Project
-- Ryan Plunkett
DROP TABLE IF EXISTS people CASCADE;
DROP TABLE IF EXISTS heroes CASCADE;
DROP TABLE IF EXISTS sidekicks CASCADE;
DROP TABLE IF EXISTS villains CASCADE;
DROP TABLE IF EXISTS h_link CASCADE;
DROP TABLE IF EXISTS s_link CASCADE;
DROP TABLE IF EXISTS v_link CASCADE;
DROP TABLE IF EXISTS powers CASCADE;
DROP TABLE IF EXISTS weakness CASCADE;
DROP TABLE IF EXISTS nemesis CASCADE;
DROP TABLE IF EXISTS sh_link CASCADE;
DROP TABLE IF EXISTS sv_link CASCADE;

--INSERT STTEMENTS
CREATE TABLE people(
	pid serial NOT NULL,
	alias VARCHAR(50), 
	got_power VARCHAR(100),
	motivation VARCHAR(100),
	universe VARCHAR(20),
	CHECK(universe = 'Marvel' OR universe = 'DC'),
	PRIMARY KEY(pid)
);

CREATE TABLE heroes(
	name VARCHAR(50),
	hid INT REFERENCES people(pid),
	PRIMARY KEY(hid)
	
);

CREATE TABLE sidekicks(
	name VARCHAR(50),
	sid INT REFERENCES people(pid),
	PRIMARY KEY(sid)
);


CREATE TABLE villains(
	name VARCHAR(50),
	vid INT REFERENCES people(pid),
	PRIMARY KEY(vid)
);

CREATE TABLE powers(
	po_id serial NOT NULL,
	name VARCHAR(100),
	PRIMARY KEY(po_id) 
);

CREATE TABLE weakness(
	wid serial NOT NULL,
	name VARCHAR(100),
	PRIMARY KEY(wid) 
);

CREATE TABLE h_link(
	hid INT REFERENCES heroes(hid),
	po_id INT REFERENCES powers(po_id),
	wid INT REFERENCES weakness(wid) 
);

CREATE TABLE s_link(
	sid INT REFERENCES sidekicks(sid),
	po_id INT REFERENCES powers(po_id),
	wid INT REFERENCES weakness(wid)
);

CREATE TABLE v_link(
	vid INT REFERENCES villains(vid),
	po_id INT REFERENCES powers(po_id),
	wid INT REFERENCES weakness(wid)
);

CREATE TABLE nemesis(
	hid INT REFERENCES heroes(hid),
	vid INT REFERENCES villains(vid)
);

CREATE TABLE sh_link(
	hid INT REFERENCES heroes(hid),
	sid INT REFERENCES sidekicks(sid)
);
CREATE TABLE sv_link(
	vid INT REFERENCES villains (vid),
	sid INT REFERENCES sidekicks(sid)
);

INSERT INTO people(alias, got_power, motivation, universe)
VALUES	('Bruce Wane','trained for years with the league of assassins',
		'parents were murdered', 'DC'),

	('Clark Kent','is an alien from another world',
		'Home planet was destroyed', 'DC'),

	('Jimmy Olsen','trained for years with the league of assassins',
		'parents were murdered', 'DC'),

	('Dick Grayson','trained By Batman',
		'parents were murdered', 'DC'),

	('Peter Parker','bit by a radioactive spider',
		'uncle was murdered', 'Marvel'),

	('Bruce Banner','absorbed massive amounts of gamma radiation',
		'his anger', 'Marvel'),

	('James Howlett','born a mutant',
		'self interest', 'Marvel'),

	('Anna Marie', 'born a mutant', 'equality for mutants', 'Marvel' ),

	('Red Hood', 'fell into a vat of acid and went crazy',
		'to kill batman', 'DC' ),

	('Alexander Luthor', 'is rich', 'to kill superman', 'DC' ),

	('Norman Osborn', 'ingested a syrum', 'to kill spiderman', 'Marvel' ),

	('Samuel Sterns', 'exposed to gamma radiation',
	 'take over the world','Marvel' ),

	('Andy Maguire', 'sience experiment for wrong',
	 'help people in need','Marvel' ),

	('Victor Creed', 'born a mutant', 
	'get what he wants', 'Marvel' ),

	('Dr. Harleen Quinzel', 'falls in love with the joker',
	 'to help the joker', 'Marvel' ),
	 
	 ('Kyle Gibney', 'born a mutant',
	 'loves to fight', 'Marvel' );

INSERT INTO heroes(name, hid)
VALUES	('Batman', (select pid
		from people
		where alias= 'Bruce Wane')),
	('Superman', (select pid
		from people
		where alias= 'Clark Kent')),
	('Spiderman', (select pid
		from people
		where alias= 'Peter Parker')),
	('The Hulk', (select pid
		from people
		where alias= 'Bruce Banner')),
	('Wolvarine', (select pid
		from people
		where alias= 'James Howlett'));

INSERT INTO sidekicks(name, sid)
VALUES	('Robin', (select pid
		from people
		where alias= 'Dick Grayson')),
	('Flamebird', (select pid
		from people
		where alias= 'Jimmy Olsen')),
	('Alpha', (select pid
		from people
		where alias= 'Andy Maguire')),
	('Rogue', (select pid
		from people
		where alias= 'Anna Marie')),
	('Harley Quinn', (select pid
		from people
		where alias= 'Dr. Harleen Quinzel')),
	('Wildchild', (select pid
		from people
		where alias= 'Kyle Gibney'));
	
INSERT INTO villains(name, vid)
VALUES	('The Joker', (select pid
		from people
		where alias= 'Red Hood')),
	('Lex Luthor', (select pid
		from people
		where alias= 'Alexander Luthor')),
	('Green Goblin', (select pid
		from people
		where alias= 'Norman Osborn')),
	('The Leader', (select pid
		from people
		where alias= 'Samuel Sterns')),
	('Sabretooth', (select pid
		from people
		where alias= 'Victor Creed'));

INSERT INTO powers(name)
VALUES	('super strength'),
	('flight'),
	('spider abilities'),
	('healing'),
	('claws'),
	('super intellect'),
	('money'),
	('acrobatics'),
	('death touch'),
	('kenetic energy');

INSERT INTO weakness(name)
VALUES	('kriptonite'),
	('magnets'),
	('morality'),
	('responsibility'),
	('anger'),
	('physical harm'),
	('insanity'),
	('pride');

INSERT INTO h_link(hid, po_id, wid)
VALUES	((select hid
	from heroes
	where name= 'Batman'),(select po_id 
			from powers
			where name= 'acrobatics'),(select wid 
						from weakness
						where name= 'morality')),
	((select hid
	from heroes
	where name= 'Superman'),(select po_id 
				from powers
				where name= 'super strength'),(select wid 
							from weakness
							where name= 'kriptonite')),

	((select hid
	from heroes
	where name= 'Spiderman'),(select po_id 
				from powers
				where name= 'spider abilities'),(select wid 
							from weakness
							where name= 'responsibility')),
	((select hid
	from heroes
	where name= 'The Hulk'),(select po_id 
				from powers
				where name= 'super strength'),(select wid 
							from weakness
							where name= 'anger')),
	((select hid
	from heroes
	where name= 'Wolvarine'),(select po_id 
				from powers
				where name= 'healing'),(select wid 
							from weakness
							where name= 'magnets'));

INSERT INTO s_link(sid, po_id, wid)
VALUES	((select sid
	from sidekicks
	where name= 'Robin'),(select po_id 
				from powers
				where name= 'acrobatics'),(select wid 
							from weakness
							where name= 'physical harm')),
	((select sid
	from sidekicks
	where name= 'Flamebird'),(select po_id 
				from powers
				where name= 'acrobatics'),(select wid 
							from weakness
							where name= 'physical harm')),
(	(select sid
	from sidekicks
	where name= 'Alpha'),(select po_id 
				from powers
				where name= 'kenetic energy'),(select wid 
							from weakness
							where name= 'physical harm')),
	((select sid
	from sidekicks
	where name= 'Rogue'),(select po_id 
				from powers
				where name= 'death touch'),(select wid 
							from weakness
							where name= 'physical harm')),
	((select sid
	from sidekicks
	where name= 'Harley Quinn'),(select po_id 
				from powers
				where name= 'acrobatics'),(select wid 
							from weakness
							where name= 'physical harm')),
	((select sid
	from sidekicks
	where name= 'Wildchild'),(select po_id 
				from powers
				where name= 'healing'),(select wid 
							from weakness
							where name= 'insanity'));

INSERT INTO v_link(vid, po_id, wid)
VALUES	((select vid
	from villains
	where name= 'The Joker'),(select po_id 
				from powers
				where name= 'super intellect'),(select wid 
							from weakness
							where name= 'insanity')),
	((select vid
	from villains
	where name= 'Lex Luthor'),(select po_id 
				from powers
				where name= 'money'),(select wid 
							from weakness
							where name= 'pride')),
	((select vid
	from villains
	where name= 'Green Goblin'),(select po_id 
				from powers
				where name= 'acrobatics'),(select wid 
							from weakness
							where name= 'insanity')),
	((select vid
	from villains
	where name= 'The Leader'),(select po_id 
				from powers
				where name= 'super intellect'),(select wid 
							from weakness
							where name= 'physical harm')),
	((select vid
	from villains
	where name= 'Sabretooth'),(select po_id 
				from powers
				where name= 'claws'),(select wid 
							from weakness
							where name= 'anger'));

INSERT INTO nemesis(hid, vid)
VALUES	((select hid
		from heroes
		where name= 'Batman'),(select vid
					from villains
					where name= 'The Joker')),
	((select hid
		from heroes
		where name= 'Superman'),(select vid
					from villains
					where name= 'Lex Luthor')),
	((select hid
		from heroes
		where name= 'Spiderman'),(select vid
					from villains
					where name= 'Green Goblin')),
	((select hid
		from heroes
		where name= 'The Hulk'),(select vid
					from villains
					where name= 'The Leader')),
	((select hid
		from heroes
		where name= 'Wolvarine'),(select vid
					from villains
					where name= 'Sabretooth'));
INSERT INTO sh_link(hid, sid)
VALUES	((select hid
		from heroes
		where name= 'Batman'),(select sid
					from sidekicks
					where name= 'Robin')),
	((select hid
		from heroes
		where name= 'Superman'),(select sid
					from sidekicks
					where name= 'Flamebird')),
	((select hid
		from heroes
		where name= 'Spiderman'),(select sid
					from sidekicks
					where name= 'Alpha')),
	((select hid
		from heroes
		where name= 'Wolvarine'),(select sid
					from sidekicks
					where name= 'Rogue'));
INSERT INTO sv_link(vid, sid)
VALUES	((select vid
		from villains
		where name= 'The Joker'),(select sid
					from sidekicks
					where name= 'Harley Quinn')),
	((select vid
		from villains
		where name= 'Sabretooth'),(select sid
					from sidekicks
					where name= 'Wildchild'));


select * from people;
select * from heroes;
select * from sidekicks;
select * from villains;
select * from powers;
select * from weakness;
select * from h_link;
select * from s_link;
select * from v_link;
select * from nemesis;
select * from sh_link;
select * from sv_link;

select* from powers

--REPORT
select distinct people.alias, powers.name
from people, powers, s_link, v_link, h_link
where people.pid = h_link.hid
and powers.po_id = h_link.po_id
or people.pid = s_link.sid
and powers.po_id = s_link.po_id
or people.pid = v_link.vid 
and powers.po_id = v_link.po_id
order by alias

--VIEW
select distinct heroes.name, people.alias, people.universe, people.got_power, people.motivation, powers.name
	from heroes, people, powers, h_link 
	where heroes.hid = people.pid
		and people.pid = h_link.hid
		and powers.po_id = h_link.po_id
union all
select sidekicks.name, people.alias, people.universe, people.got_power, people.motivation, powers.name
	from sidekicks, people, powers, s_link
	where sidekicks.sid = people.pid
		and people.pid = s_link.sid
		and powers.po_id = s_link.po_id
union all 
select villains.name, people.alias, people.universe, people.got_power, people.motivation, powers.name
	from villains, people, powers, v_link
	where villains.vid = people.pid
		and people.pid = v_link.vid
		and powers.po_id = v_link.po_id



--STORED PROCEDURE
CREATE OR REPLACE FUNCTION personPower(who TEXT)	
RETURNS TABLE (power TEXT) AS
 $$	
BEGIN
	select  powers.name
		FROM powers, heroes, villains, sidekicks, h_link, s_link, v_link	
		WHERE powers.po_id = h_link.po_id
			AND h_link.hid = heroes.hid
			AND heroes.name= who
		OR powers.po_id = v_link.po_id
			AND v_link.vid = villains.vid
			AND villains.name= who
		OR powers.po_id = s_link.po_id
			AND s_link.sid = sidekicks.sid
			AND sidekicks.name= who;
END;	
$$ LANGUAGE PLPGSQL;	 


--TRIGGER
CREATE OR REPLACE FUNCTION delHero()	
RETURNS	trigger	AS 
$$	
BEGIN	
	 DELETE	FROM heroes
	 WHERE NOT EXISTS( select people.pid
				from people
				);
RETURN	NULL;	
END;	
$$LANGUAGE plpgsql;

CREATE TRIGGER delHeroTrigger
AFTER DELETE ON people
	FOR EACH ROW
	EXECUTE PROCEDURE delHero();

--SECURITY
CREATE ROLE admin
GRANT SELECT, INSERT, UPDATE, ALTER
ON ALL TABLES IN SCHEMA public
TO admin
password = admin

CREATE ROLE user
GRANT SELECT
ON ALL TABLES IN SCHEMA public
TO public