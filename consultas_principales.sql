-- consultas_principales.sql
USE `apple_music`;

SELECT c.id_cancion, c.titulo, COUNT(r.id_reproduccion) AS plays
FROM cancion c
LEFT JOIN reproduccion r ON c.id_cancion = r.id_cancion
GROUP BY c.id_cancion, c.titulo
ORDER BY plays DESC
LIMIT 10;

SELECT a.id_artista, a.nombre, COUNT(r.id_reproduccion) AS plays
FROM artista a
JOIN album al ON al.id_artista = a.id_artista
JOIN cancion c ON c.id_album = al.id_album
LEFT JOIN reproduccion r ON r.id_cancion = c.id_cancion
GROUP BY a.id_artista, a.nombre
ORDER BY plays DESC
LIMIT 10;

SELECT p.id_playlist, p.nombre, pc.posicion, c.titulo
FROM playlist p
JOIN playlist_cancion pc ON pc.id_playlist = p.id_playlist
JOIN cancion c ON c.id_cancion = pc.id_cancion
WHERE p.id_duenio = 1
ORDER BY p.id_playlist, pc.posicion;

SELECT r.id_reproduccion, r.fecha_hora, c.titulo, u.username
FROM reproduccion r
JOIN cancion c ON c.id_cancion = r.id_cancion
JOIN usuario u ON u.id_usuario = r.id_usuario
WHERE r.id_usuario = 1
ORDER BY r.fecha_hora DESC
LIMIT 20;

SELECT g.nombre AS genero, c.titulo
FROM genero g
JOIN cancion_genero cg ON cg.id_genero = g.id_genero
JOIN cancion c ON c.id_cancion = cg.id_cancion
ORDER BY g.nombre, c.titulo;
