SET FOREIGN_KEY_CHECKS=0;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

CREATE DATABASE IF NOT EXISTS `asistencia` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;
USE `asistencia`;

DROP TABLE IF EXISTS `asistencia`;
CREATE TABLE `asistencia` (
  `id` int(11) NOT NULL,
  `usuario` int(11) DEFAULT NULL,
  `fechaentrada` date DEFAULT NULL,
  `entrada` time DEFAULT NULL,
  `ipentrada` varchar(45) DEFAULT NULL,
  `macentrada` varchar(45) DEFAULT NULL,
  `fechasalida` date DEFAULT NULL,
  `salida` time DEFAULT NULL,
  `ipsalida` varchar(45) DEFAULT NULL,
  `macsalida` varchar(45) DEFAULT NULL,
  `actividades` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
DROP VIEW IF EXISTS `asistencialistado`;
CREATE TABLE `asistencialistado` (
`id` int(11)
,`idusuario` int(11)
,`usuario` varchar(50)
,`fechaentrada` date
,`entrada` time
,`ipentrada` varchar(45)
,`macentrada` varchar(45)
,`fechasalida` date
,`salida` time
,`ipsalida` varchar(45)
,`macsalida` varchar(45)
,`actividades` varchar(250)
);

DROP TABLE IF EXISTS `usuariosapp`;
CREATE TABLE `usuariosapp` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `clave` varchar(250) DEFAULT NULL,
  `estatus` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

INSERT INTO `usuariosapp` (`id`, `nombre`, `clave`, `estatus`) VALUES
(1, 'admin', '1234', 1);

DROP TABLE IF EXISTS `usuariosweb`;
CREATE TABLE `usuariosweb` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `clave` varchar(250) DEFAULT NULL,
  `estatus` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
DROP TABLE IF EXISTS `asistencialistado`;

DROP VIEW IF EXISTS `asistencialistado`;
CREATE OR REPLACE VIEW `asistencialistado`  AS SELECT `asistencia`.`id` AS `id`, `asistencia`.`usuario` AS `idusuario`, `usuariosapp`.`nombre` AS `usuario`, `asistencia`.`fechaentrada` AS `fechaentrada`, `asistencia`.`entrada` AS `entrada`, `asistencia`.`ipentrada` AS `ipentrada`, `asistencia`.`macentrada` AS `macentrada`, `asistencia`.`fechasalida` AS `fechasalida`, `asistencia`.`salida` AS `salida`, `asistencia`.`ipsalida` AS `ipsalida`, `asistencia`.`macsalida` AS `macsalida`, `asistencia`.`actividades` AS `actividades` FROM (`asistencia` left join `usuariosapp` on(`usuario` = `usuariosapp`.`id`)) ;


ALTER TABLE `asistencia`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_UNIQUE` (`id`),
  ADD KEY `usuarioid1_idx` (`usuario`);

ALTER TABLE `usuariosapp`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_UNIQUE` (`id`),
  ADD UNIQUE KEY `nombre_UNIQUE` (`nombre`);

ALTER TABLE `usuariosweb`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_UNIQUE` (`id`),
  ADD UNIQUE KEY `nombre_UNIQUE` (`nombre`);


ALTER TABLE `asistencia`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `usuariosapp`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

ALTER TABLE `usuariosweb`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;


ALTER TABLE `asistencia`
  ADD CONSTRAINT `usuarioid1` FOREIGN KEY (`usuario`) REFERENCES `usuariosapp` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
SET FOREIGN_KEY_CHECKS=1;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
