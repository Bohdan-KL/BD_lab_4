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