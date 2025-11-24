-- dml.sql
USE `apple_music`;

INSERT INTO usuario (username, email, password_hash) VALUES
('juan', 'juan@example.com', 'hash1'),
('maria', 'maria@example.com', 'hash2'),
('carlos', 'carlos@example.com', 'hash3');

INSERT INTO artista (nombre) VALUES ('The Marías'), ('Royal Otis'), ('Mitski');

INSERT INTO album (id_artista, titulo, fecha_lanzamiento) VALUES
(1, 'Album A', '2020-01-01'),
(2, 'Album B', '2021-03-10');

INSERT INTO cancion (id_album, titulo, duracion_seconds) VALUES
(1, 'Cancion 1', 210),
(1, 'Cancion 2', 185),
(2, 'Hit 1', 200);

INSERT INTO genero (nombre) VALUES ('indie'), ('rock'), ('alternativo');
INSERT INTO mood (nombre) VALUES ('relax'), ('energetic');
INSERT INTO actividad (nombre) VALUES ('running'), ('studying');

INSERT INTO cancion_genero VALUES (1,1),(1,2),(2,1),(3,3);

INSERT INTO playlist (id_duenio, nombre) VALUES (1, 'Top Juan'), (2, 'Alice mix');
INSERT INTO playlist_cancion (id_playlist, id_cancion, posicion) VALUES (1,1,1),(1,2,2),(2,3,1);

INSERT INTO reproduccion (id_usuario, id_cancion) VALUES (1,1),(1,2),(2,3),(3,1),(1,1);

INSERT INTO resena (id_usuario, id_cancion, calificacion, comentario) VALUES
(1,1,5,'Me encanta'),
(2,3,4,'Buena');

INSERT INTO seguimiento_usuario (seguidor_id, seguido_id) VALUES (1,2),(2,3);
