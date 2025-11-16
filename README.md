Apple Music – Proyecto Final de Bases de Datos

Materia: Bases de Datos
Grupo: 3 – Broadway
Institución: Universidad de La Sabana
Año: 2025

Este proyecto implementa una base de datos profesional inspirada en la arquitectura utilizada por plataformas como Apple Music, gestionando usuarios, artistas, álbumes, canciones, playlists colaborativas, reproducciones (tipo “Wrapped”), reseñas, metadatos musicales y relaciones sociales entre usuarios.

Su diseño cumple con los estándares de normalización, integridad referencial, seguridad y reproducibilidad exigidos por la rúbrica del curso.

*  Tabla de Contenidos

Descripción General

Características Principales

Arquitectura de la Base de Datos

Modelo E-R y Modelo Relacional

Normalización (3FN / BCNF)

Reglas de Negocio Implementadas

Triggers Implementados

Índices y Rendimiento

Scripts SQL Incluidos

Datos de Ejemplo

Demo Técnica

Instrucciones de Instalación

Estructura del Repositorio

Conexión desde PHP

Autores

*  Descripción General

La base de datos apple_music replica componentes esenciales de un sistema real de streaming musical:

Usuarios con perfiles y roles

Artistas y álbumes

Canciones con metadatos

Playlists colaborativas

Reseñas con validación XOR

Seguimiento entre usuarios (social)

Reproducciones y estadísticas

Clasificación por género, mood y actividad

El proyecto está totalmente normalizado y pensado para escalar.

*  Características Principales

✔ Playlists colaborativas con orden personalizado
✔ Registro de auditoría con triggers
✔ Reseñas con regla estricta XOR (álbum o canción)
✔ Seguimiento entre usuarios (tipo Instagram/Spotify)
✔ Métricas de reproducciones (para análisis tipo Wrapped)
✔ Vista para consultas frecuentes
✔ Índices optimizados para EXPLAIN
✔ Transacciones reales (ACID)

*  Arquitectura de la Base de Datos

Componentes principales:

usuario – perfiles, roles y seguridad

artista / album / cancion – catálogo musical

playlist / playlist_cancion – relación N:M con atributos

resena – calificaciones con constraints

seguimiento_usuario – red social

reproduccion – historial de escuchas

mood / actividad / genero – metadatos avanzados

Motor utilizado: MariaDB 10.x

*  Modelo E-R y Modelo Relacional

*  Archivo en /docs/ → Modelo_ER.png
*  Archivo en /docs/ → ModeloRelacional.png

Incluye todas las entidades, claves primarias, claves foráneas, relaciones 1:N y N:M, cardinalidades y restricciones.

*  Normalización (3FN / BCNF)

La base cumple:

✔ 1FN

– Atributos atómicos
– PK clara

✔ 2FN

– Tablas con PK simple o compuesta
– No hay dependencias parciales

✔ 3FN

– Sin dependencias transitivas
– Tablas puente correctamente normalizadas

✔ BCNF

– En playlist_cancion todas las dependencias funcionales están completamente descompuestas

*  Reglas de Negocio Implementadas
Regla	Implementación
Un usuario no puede reseñar álbum y canción al tiempo	Trigger XOR
No puede haber dos canciones con la misma posición en una playlist	UNIQUE(id_playlist, posicion)
No autoseguirse	CHECK(id_follower <> id_followee)
Duración de una canción > 0	CHECK(duracion_seg > 0)
Calificación entre 1–5	CHECK(calificacion BETWEEN 1 AND 5)
*  Triggers Implementados
✔ Trigger 1 – XOR en reseñas

Evita que una reseña tenga álbum y canción al tiempo.

✔ Trigger 2 – Log de playlist

Guarda automáticamente registros en:

log_playlist_cancion

cada vez que se agrega o elimina una canción de una playlist.

* Índices y Rendimiento

Se crearon índices para mejorar el rendimiento de consultas críticas:

idx_usuario_username

idx_rep_usuario_fecha

idx_plc_playlist

idx_cancion_album

Utilizados en la demo con EXPLAIN.

*  Scripts SQL Incluidos
Archivo	Descripción
apple_music.sql	Script completo con creación, triggers, índices y datos

Incluye:

✔ CREATES
✔ INSERTS
✔ TRIGGERS
✔ CHECKS
✔ UNIQUE
✔ ON DELETE CASCADE
✔ TRANSACCIÓN
✔ VIEW
✔ EXPLAIN

*  Datos de Ejemplo

Incluye:

3 usuarios

2 artistas

2 álbumes

4 canciones

1 playlist colaborativa

Reproducciones reales

Sirven para demostrar:

consulta de top canciones

funcionamiento de triggers

atomicidad de transacciones

uso de índices

*  Demo Técnica

✔ Consulta real: “Top canciones más escuchadas por Andrea”.
✔ Transacción: creación de playlist + inserción de canciones → COMMIT.
✔ Trigger: registro automático en log.
✔ EXPLAIN: muestra el uso de índices.
✔ Vista recurrente: v_escuchas_recientes para ver reproducciones recientes.

*  Instrucciones de Instalación
1. Crear la Base de Datos
CREATE DATABASE apple_music;

2. Importar el script

phpMyAdmin o consola:

SOURCE apple_music.sql;

3. Crear usuario de aplicación
CREATE USER 'andrea_user'@'localhost' IDENTIFIED BY 'AndreaUser123*';
GRANT ALL PRIVILEGES ON apple_music.* TO 'andrea_user'@'localhost';
FLUSH PRIVILEGES;

4. Credenciales del proyecto

phpMyAdmin:

Usuario: andrea_admin

Contraseña: AndreaAdmin123*

Aplicación PHP:

Usuario: andrea_user

Contraseña: AndreaUser123*

*  Estructura del Repositorio
apple-music-project/
│
├── sql/
│   └── apple_music.sql
│
├── src/
│   ├── conexion.php
│   ├── login.php
│   ├── register.php
│   ├── home.php
│   └── playlist_demo.php
│
├── docs/
│   ├── Modelo_ER.png
│   ├── ModeloRelacional.png
│   ├── Presentacion.pptx
│   └── Informe.pdf
│
├── img/
│   ├── captura_trigger.png
│   ├── captura_consulta.png
│   └── captura_explain.png
│
└── README.md

*  Conexión desde PHP
$conexion = new PDO(
    "mysql:host=localhost;dbname=apple_music;charset=utf8mb4",
    "andrea_user",
    "AndreaUser123*"
);

*  Autores

Andrea Silva

Sara Montañez

Daniel Palma

Sebastián Serrano

Rafael Correa

Felipe Orjuela

*  Proyecto Finalizado

Este proyecto cumple con:

✔ Reproducibilidad
✔ Arquitectura clara
✔ Normalización correcta
✔ Código técnico sólido
✔ Demo completa
✔ Trigger + Transacción + EXPLAIN
✔ Documentación profesional
