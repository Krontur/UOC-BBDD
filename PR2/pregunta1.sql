SET search_path TO ubd_20182;

DROP FUNCTION update_report_dir_nat(p_nationality VARCHAR(255));
DROP TYPE report_director_nationality;

CREATE TYPE report_director_nationality AS (
	t_nationality VARCHAR (255),
	t_genre VARCHAR(255),
	t_num_movies SMALLINT,
	t_max_awards SMALLINT,
	t_total_duration SMALLINT
);

CREATE OR REPLACE FUNCTION update_report_dir_nat(p_nationality VARCHAR(255))
RETURNS SETOF report_director_nationality AS $$
DECLARE
	var_return_data report_director_nationality;
	--var_dir_found: Variable que almacena el estado de la búsqueda de un director de esa nacionalidad, que haya dirigido una película.
	var_dir_found BOOLEAN DEFAULT FALSE; 
BEGIN

IF(NOT EXISTS(SELECT nationality FROM PERSON p
	WHERE p_nationality = p.nationality)) THEN
	-- Se devuelve el mensaje de error si no se encuentra la nacionalidad en la tabla PERSON
	RAISE EXCEPTION 'ERROR: Nationality % not found', p_nationality; 
ELSE IF (NOT EXISTS(SELECT nationality FROM 
	PERSON p NATURAL JOIN DIRECTOR d
	WHERE p_nationality = p.nationality)) THEN
	-- Se devuelve el mensaje de error si habiendo personas con esa nacionalidad no se encuentra ningun director entre ellos.
	RAISE EXCEPTION 'ERROR: Director with the nationality % not found', p_nationality;
	END IF;
END IF;

FOR var_return_data IN
	-- Consulta para encontrar a los directores de la nacionalidad buscada que han dirigido una película.
	SELECT p.nationality, m.genre, COUNT(m.id) AS num_movies, MAX(d.num_awards) AS max_awards, SUM(m.duration) AS total_duration
		-- La consulta devuelve la nacionalidad, el genero de la película, el número de películas, el número máximo de premios que
		-- ha ganado un director de cada nacionalidad y género y la suma de los minutos de todas las películas de esa nacionalidad y género.
		FROM PERSON p NATURAL JOIN DIRECTOR d
					  JOIN MOVIE m ON d.id = m.id_director
		WHERE p_nationality = p.nationality
		GROUP BY genre, nationality
	LOOP
	var_dir_found := TRUE; -- Si hay como mínimo un resultado en la consulta, se pone la variable a TRUE
		-- Se comprueba si existe la nacionalidad en la tabla report_directors_nationality
		IF(NOT EXISTS (SELECT nationality FROM report_directors_nationality
					WHERE var_return_data.t_nationality = nationality
					AND var_return_data.t_genre = genre)) THEN
			-- Si no existe se insertan los datos de esa nacionalidad en la tabla.
			INSERT INTO report_directors_nationality(nationality, genre, num_movies, max_awards, total_duration)
				VALUES(var_return_data.t_nationality, var_return_data.t_genre, var_return_data.t_num_movies, var_return_data.t_max_awards, var_return_data.t_total_duration);
		ELSE
		-- Si existe la nacionalidad en la tabla se actualizan los datos en la tabla report_directors_nationality
			UPDATE report_directors_nationality
			SET num_movies = var_return_data.t_num_movies, max_awards = var_return_data.t_max_awards, total_duration = var_return_data.t_total_duration
			WHERE var_return_data.t_nationality = nationality
				AND var_return_data.t_genre = genre;
		END IF;
		RETURN NEXT var_return_data;
	END LOOP;
	-- Se comprueba si ha habido alguna coincidencia para un director con dicha nacionalidad ya existente con una película dirigida por él.
	IF(var_dir_found <> true) THEN
		RAISE EXCEPTION 'ERROR: No movie found for the nationality %', p_nationality;
	END IF;
END;
$$
LANGUAGE plpgsql;