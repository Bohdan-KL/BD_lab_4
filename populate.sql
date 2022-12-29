INSERT INTO white(white_id, white_rating)
VALUES('bourgris', 1500),('ischia', 1496),('daniamurashov', 1439),
('nik221107', 1523),('trelynn17', 1250),('capa_jr', 1520),
('ehabfanri', 1439),('sureka_akshat', 1141),('g-ios', 1500),('robotsmoke', 1307);

INSERT INTO black(black_id, black_rating)
VALUES('a-00',1191),('skinnerua', 1261),('adiv2003', 1454),
('a-01',1500),('adivanov2009', 1469),('franklin14532',1002),
('dani22', 1392),('shivangithegenius', 1094),('slam_ment', 1300),('ivangonzalez123', 1423);

INSERT INTO game(game_id, white_player_id, black_player_id, winner, turns, victory_status)
VALUES('TZJHLljE', 'bourgris', 'a-00', 'white', 13, 'outoftime'),
('l1NXvwaE', 'ischia', 'a-01', 'black', 16, 'resign'),
('kWKvrqYL', 'daniamurashov', 'adiv2003', 'white', 61, 'mate'),
('9tXo1AUZ', 'nik221107', 'adivanov2009', 'white', 95, 'mate'),
('MsoDV9wj', 'trelynn17', 'franklin14532', 'draw', 5, 'draw'),
('qwU9rasv', 'capa_jr', 'dani22', 'white', 33, 'resign'),
('HgKLWPsz', 'ehabfanri', 'skinnerua', 'black', 45, 'outoftime'),
('guanvMR5', 'sureka_akshat', 'shivangithegenius', 'black', 43, 'resign'),
('x31mXlvc', 'g-ios', 'slam_ment', 'draw', 21, 'draw'),
('UhXXBOMY', 'robotsmoke', 'ivangonzalez123', 'white', 36, 'resign');

SELECT * FROM white;
SELECT * FROM black;
SELECT * FROM game;