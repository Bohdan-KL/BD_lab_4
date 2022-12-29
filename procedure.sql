-- Процедура записує в таблицю game нові рядки, а також записує час додачі до табиці(тобто час гри)
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
SELECT * FROM white;
SELECT * FROM black;