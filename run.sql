-- Функція, що рахує кількість закінчень гри через задану причину(мат, нічия, вийшов час, здача)
-- Функція приймає на вхід 1 аргумет - status CHAR(20) - причина закінчення гри 
CREATE OR REPLACE FUNCTION count_victory_status(status CHAR(20))
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE num_of_status INT;
BEGIN
    SELECT COUNT(game.victory_status) INTO num_of_status FROM game
    WHERE game.victory_status = status;
    RETURN num_of_status;
END; 
$$ 

-- Порахуємо скільки ігро закінчилися через здачу одного з гравців
SELECT count_victory_status('resign'); -- 4

SELECT * FROM game;
SELECT * FROM white;
SELECT * FROM black;

-- Процедура записує в таблицю game нові рядки, а також записує час додачі до таблиці(тобто час гри)
-- В таблиці game немає поля часу, тому ця процедура його додає - date_of_record
CREATE OR REPLACE PROCEDURE add_new_game(game_id CHAR(15), white_id CHAR(100), 
                     black_id CHAR(100), winner CHAR(6), turns INT, victory_status CHAR(20), 
                     white_rating INT, black_rating INT)
LANGUAGE plpgsql
AS $$
  BEGIN
    ALTER TABLE white ADD COLUMN IF NOT EXISTS date_of_record TIMESTAMP;
    ALTER TABLE black ADD COLUMN IF NOT EXISTS date_of_record TIMESTAMP;
    INSERT INTO white(white_id, white_rating, date_of_record)
    VALUES(white_id, white_rating, CURRENT_TIMESTAMP(0));
    INSERT INTO black(black_id, black_rating, date_of_record)
    VALUES(black_id, black_rating, CURRENT_TIMESTAMP(0));
    INSERT INTO game(game_id, white_player_id, black_player_id, winner, turns, victory_status) 
    VALUES(game_id, white_id, black_id, winner, turns, victory_status); 
    
END
$$

CALL add_new_game('game_id1', 'Bodya2010', 'Klots2003', 'white', 69, 'mate', 831, 690);


SELECT * FROM game;

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