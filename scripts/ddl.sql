-- ddl.sql
CREATE DATABASE IF NOT EXISTS `apple_music` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `apple_music`;

CREATE TABLE usuario (
  id_usuario INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(50) NOT NULL UNIQUE,
  email VARCHAR(150) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE artista (
  id_artista INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(150) NOT NULL UNIQUE
) ENGINE=InnoDB;

CREATE TABLE album (
  id_album INT AUTO_INCREMENT PRIMARY KEY,
  id_artista INT NOT NULL,
  titulo VARCHAR(200),
  fecha_lanzamiento DATE,
  FOREIGN KEY (id_artista) REFERENCES artista(id_artista) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE cancion (
  id_cancion INT AUTO_INCREMENT PRIMARY KEY,
  id_album INT,
  titulo VARCHAR(250) NOT NULL,
  duracion_seconds INT DEFAULT 0,
  FOREIGN KEY (id_album) REFERENCES album(id_album) ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE playlist (
  id_playlist INT AUTO_INCREMENT PRIMARY KEY,
  id_duenio INT NOT NULL,
  nombre VARCHAR(200) DEFAULT 'Mi playlist',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (id_duenio) REFERENCES usuario(id_usuario) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE playlist_cancion (
  id_playlist INT NOT NULL,
  id_cancion INT NOT NULL,
  posicion INT NOT NULL,
  PRIMARY KEY (id_playlist, id_cancion),
  UNIQUE (id_playlist, posicion),
  FOREIGN KEY (id_playlist) REFERENCES playlist(id_playlist) ON DELETE CASCADE,
  FOREIGN KEY (id_cancion) REFERENCES cancion(id_cancion) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE resena (
  id_resena INT AUTO_INCREMENT PRIMARY KEY,
  id_usuario INT NOT NULL,
  id_album INT DEFAULT NULL,
  id_cancion INT DEFAULT NULL,
  calificacion TINYINT NOT NULL,
  comentario TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CHECK (calificacion BETWEEN 1 AND 5),
  FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE,
  FOREIGN KEY (id_album) REFERENCES album(id_album) ON DELETE CASCADE,
  FOREIGN KEY (id_cancion) REFERENCES cancion(id_cancion) ON DELETE CASCADE
) ENGINE=InnoDB;

ALTER TABLE resena
  ADD CONSTRAINT chk_resena_xor CHECK (
    (id_album IS NOT NULL AND id_cancion IS NULL) OR
    (id_album IS NULL AND id_cancion IS NOT NULL)
  );

CREATE TABLE seguimiento_usuario (
  seguidor_id INT NOT NULL,
  seguido_id INT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (seguidor_id, seguido_id),
  FOREIGN KEY (seguidor_id) REFERENCES usuario(id_usuario) ON DELETE CASCADE,
  FOREIGN KEY (seguido_id) REFERENCES usuario(id_usuario) ON DELETE CASCADE,
  CHECK (seguidor_id <> seguido_id)
) ENGINE=InnoDB;

CREATE TABLE reproduccion (
  id_reproduccion INT AUTO_INCREMENT PRIMARY KEY,
  id_usuario INT NOT NULL,
  id_cancion INT NOT NULL,
  fecha_hora DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE,
  FOREIGN KEY (id_cancion) REFERENCES cancion(id_cancion) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE genero (
  id_genero INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL UNIQUE
) ENGINE=InnoDB;

CREATE TABLE cancion_genero (
  id_cancion INT NOT NULL,
  id_genero INT NOT NULL,
  PRIMARY KEY (id_cancion, id_genero),
  FOREIGN KEY (id_cancion) REFERENCES cancion(id_cancion) ON DELETE CASCADE,
  FOREIGN KEY (id_genero) REFERENCES genero(id_genero) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE mood (
  id_mood INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL UNIQUE
) ENGINE=InnoDB;

CREATE TABLE cancion_mood (
  id_cancion INT NOT NULL,
  id_mood INT NOT NULL,
  PRIMARY KEY (id_cancion, id_mood),
  FOREIGN KEY (id_cancion) REFERENCES cancion(id_cancion) ON DELETE CASCADE,
  FOREIGN KEY (id_mood) REFERENCES mood(id_mood) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE actividad (
  id_actividad INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL UNIQUE
) ENGINE=InnoDB;

CREATE TABLE cancion_actividad (
  id_cancion INT NOT NULL,
  id_actividad INT NOT NULL,
  PRIMARY KEY (id_cancion, id_actividad),
  FOREIGN KEY (id_cancion) REFERENCES cancion(id_cancion) ON DELETE CASCADE,
  FOREIGN KEY (id_actividad) REFERENCES actividad(id_actividad) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE log_reproduccion (
  id_log INT AUTO_INCREMENT PRIMARY KEY,
  id_reproduccion INT,
  id_usuario INT,
  id_cancion INT,
  accion VARCHAR(100),
  detalle TEXT,
  creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;
