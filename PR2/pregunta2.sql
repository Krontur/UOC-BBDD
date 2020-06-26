SET search_path TO ubd_20182;

CREATE OR REPLACE FUNCTION update_total_incomes_director()
RETURNS trigger AS $$
BEGIN
	-- Si la operación que ha disparado trigger es un UPDATE
	IF (TG_OP = 'UPDATE') THEN
		-- Si el nuevo director no es el anterior, estamos cambiando de director.
		IF(NEW.id_director <> OLD.id_director) THEN
			-- Al nuevo director le sumamos a su total_incomes el incomes de la película
			UPDATE director SET total_incomes = total_incomes + NEW.incomes
				WHERE NEW.id_director = id;
			-- Al anterior director le restamos de su total_incomes el incomes de la película
			UPDATE director SET total_incomes = total_incomes - NEW.incomes
				WHERE OLD.id_director = id;
		-- Si el director es el mismo, comprobamos si el UPDATE modifica el campo incomes de la película
		ELSIF (NEW.incomes <> OLD.incomes) THEN
			-- Si lo modifica le sumamos al total_incomes del director la diferencia de el nuevo incomes menos el anterior incomes de la película
			UPDATE director SET total_incomes = total_incomes + (NEW.incomes - OLD.incomes)
				WHERE NEW.id_director = id;
		END IF;
	-- Si la operación que ha disparado trigger es un INSERT
	ELSIF (TG_OP = 'INSERT') THEN
		-- Le sumamos el incomes de la película al total_incomes de su director
		UPDATE director SET total_incomes = total_incomes + NEW.incomes
			WHERE NEW.id_director = id;
	-- Si la operación que ha disparado trigger es un DELETE
	ELSIF (TG_OP = 'DELETE') THEN
		-- Le restamos el incomes de la película al total_incomes de su director
		UPDATE director SET total_incomes = total_incomes - OLD.incomes
			WHERE OLD.id_director = id;
	END IF;
	
	RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- Creamos un trigger que ejecutará la función después de la instrucción INSERT en la tabla MOVIE
CREATE TRIGGER trigger_insert_incomes_movie_director AFTER INSERT ON MOVIE FOR EACH ROW EXECUTE PROCEDURE update_total_incomes_director();
-- Creamos un trigger que ejecutará la función después de la instrucción DELETE en la tabla MOVIE
CREATE TRIGGER trigger_delete_incomes_movie_director AFTER DELETE ON MOVIE FOR EACH ROW EXECUTE PROCEDURE update_total_incomes_director();
-- Creamos un trigger que ejecutará la función después de la instrucción UPDATE de los campos id_director e incomes en la tabla MOVIE
CREATE TRIGGER trigger_update_incomes_movie_director AFTER UPDATE OF id_director, incomes ON MOVIE FOR EACH ROW EXECUTE PROCEDURE update_total_incomes_director();
