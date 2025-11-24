-- triggers.sql
USE `apple_music`;

DELIMITER $$
CREATE TRIGGER trg_after_insert_reproduccion
AFTER INSERT ON reproduccion
FOR EACH ROW
BEGIN
  INSERT INTO log_reproduccion (id_reproduccion, id_usuario, id_cancion, accion, detalle)
  VALUES (NEW.id_reproduccion, NEW.id_usuario, NEW.id_cancion,
          'INSERT_REPRODUCCION',
          CONCAT('Reproduccion registrada para cancion ', NEW.id_cancion));
END$$
DELIMITER ;
