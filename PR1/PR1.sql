--Ejercicio 1


CREATE TABLE PARTICIPATION(
	id_actor SMALLINT NOT NULL,
	id_movie SMALLINT NOT NULL,
	character varchar(255) NOT NULL,
	role varchar(255) NOT NULL,
	CONSTRAINT PK_PARTICIPATION PRIMARY KEY(id_actor, id_movie),
	CONSTRAINT FK_ACTOR FOREIGN KEY (id_actor) REFERENCES ACTOR(id),
	CONSTRAINT FK_MOVIE FOREIGN KEY (id_movie) REFERENCES MOVIE(id),
	CONSTRAINT VALID_ROLE CHECK (role IN('Leading', 'Supporting', 'Narrator', 'Cameo', 'Unclassified')));

ALTER TABLE ACTOR
	ADD CONSTRAINT FK_PERSON FOREIGN KEY (id) REFERENCES PERSON(id),
	DROP num_awards CASCADE,
	ALTER debut_year SET NOT NULL,
	ADD CONSTRAINT MIN_DEBUT_YEAR CHECK (debut_year>=1895);
ALTER TABLE DIRECTOR
	ADD CONSTRAINT MIN_DEBUT_YEAR CHECK (debut_year>=1895);

ALTER TABLE MOVIE
	ADD id_director SMALLINT,
	ADD CONSTRAINT FK_DIRECTOR FOREIGN KEY (id_director) REFERENCES DIRECTOR(id),
	ADD CONSTRAINT VALID_GENRE CHECK (genre IN('Action', 'Adventure',
		'Comedy', 'Crime', 'Drama', 'Historical', 'Horror', 'Musical', 'Science-fiction', 'War',
		'Western')),
	ADD CONSTRAINT POSITIVE_DURATION CHECK (duration>0),
	ADD CONSTRAINT MIN_YEAR CHECK(year>=1895);
	
--Ejercicio 2
--a)

SELECT pers.name, pers.birth, pers.nationality
FROM PERSON pers JOIN MOVIE mov ON pers.id = id_director
WHERE mov.genre = 'Science-fiction' AND mov.genre<>'War' AND pers.death IS NULL

--b)

SELECT mov.genre,
	COUNT(DISTINCT pers.nationality) AS num_nation_director,
	COUNT(mov.genre) AS num_genre_movies,
	AVG(mov.budget),
	SUM(mov.incomes) AS total_incomes
FROM MOVIE mov JOIN PERSON pers ON mov.id_director = pers.id
GROUP BY mov.genre
ORDER BY total_incomes DESC;

--c)

CREATE VIEW maximum_profits_per_genre(genre, title, profits,
	director, actor_or_actress, birth, character, role) 
	AS (SELECT genre, title, profits, dir_name AS director, act_name AS actor_or_actress, birth, character, role
			FROM (SELECT mov.genre, mov.title, mov.incomes-mov.budget AS profits,
						 mov.id_director, mov.id AS id_movie
				  FROM MOVIE mov JOIN (SELECT genre, MAX(incomes-budget) AS profits
					    			  FROM MOVIE
									  GROUP BY genre) AS genre_profits 
											  ON mov.incomes-mov.budget = genre_profits.profits) AS par_mov 
				  NATURAL JOIN (SELECT dir_pers.name AS dir_name, dir_pers.id AS id_director
								FROM PERSON dir_pers) AS dir

				  NATURAL LEFT JOIN (SELECT act.name AS act_name, act.birth, part.id_movie, part.character, part.role
						FROM PERSON act JOIN PARTICIPATION part ON act.id = part.id_actor
										JOIN (SELECT MIN(act_pers.birth) AS birth, act_pers.id_movie AS id_movie
											  FROM (SELECT *
													FROM PERSON pers JOIN PARTICIPATION par ON pers.id = par.id_actor) AS act_pers
													GROUP BY act_pers.id_movie) AS old_act ON old_act.birth = act.birth AND old_act.id_movie = part.id_movie) AS old_act_bymovie
			ORDER BY profits ASC);
	  
	
	
	
	
--Ejercicio 3

UPDATE MOVIE
	SET budget = budget / 0.85
	WHERE year < 1990 AND id IN(
		SELECT mov.id
		FROM MOVIE mov JOIN PERSON pers_dir ON mov.id_director = pers_dir.id
		WHERE pers_dir.nationality <> 'American' AND
			  mov.country = 'United Kingdom');
