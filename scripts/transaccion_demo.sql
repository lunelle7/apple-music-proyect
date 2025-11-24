-- transaccion_demo.sql
USE `apple_music`;

START TRANSACTION;
INSERT INTO playlist (id_duenio, nombre) VALUES (1, 'Playlist demo');
SET @new_playlist_id = LAST_INSERT_ID();

INSERT INTO playlist_cancion (id_playlist, id_cancion, posicion) VALUES
(@new_playlist_id, 1, 1),
(@new_playlist_id, 2, 2);

COMMIT;
