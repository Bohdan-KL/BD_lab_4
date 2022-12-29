DROP TABLE IF EXISTS changes;
CREATE TABLE changes(
	id SERIAL PRIMARY KEY,
	old_rating INT NOT NULL,
	new_rating INT NOT NULL,
	updated TIMESTAMP
);

-- Тригерна функція, яка запише в таблицю changes зміну рейтингу гравця в таблиці white,
-- а також запише час зміни
CREATE OR REPLACE FUNCTION players_update_rating() 
RETURNS trigger 
LANGUAGE plpgsql 
AS
	$$
	BEGIN
		IF NEW.white_rating <> OLD.white_rating THEN
			INSERT INTO changes(old_rating, new_rating, updated)
			VALUES(OLD.white_rating, NEW.white_rating, CURRENT_TIMESTAMP(0));
		END IF;
		RETURN NEW;
	END;
	$$ 

-- Тригер спрацьову при зміні рейтингу гравця з таблиці white(для black можна зробити аналогічний тригер)
DROP TRIGGER IF EXISTS show_update ON white;
CREATE TRIGGER show_update
BEFORE UPDATE ON white
FOR EACH ROW EXECUTE FUNCTION players_update_rating();

UPDATE white SET white_rating = 1500 WHERE white_id = 'robotsmoke';

SELECT * FROM white;

SELECT * FROM changes;