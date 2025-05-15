SET FOREIGN_KEY_CHECKS=0;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;


CREATE TABLE `asistencia` (
  `id` int(11) NOT NULL,
  `usuario` int(11) DEFAULT NULL,
  `fechaentrada` date DEFAULT NULL,
  `horaentrada` time DEFAULT NULL,
  `ipentrada` varchar(45) DEFAULT NULL,
  `bssidentrada` varchar(45) DEFAULT NULL,
  `uuidentrada` varchar(250) DEFAULT NULL,
  `fechasalida` date DEFAULT NULL,
  `horasalida` time DEFAULT NULL,
  `ipsalida` varchar(250) DEFAULT NULL,
  `bssidsalida` varchar(250) DEFAULT NULL,
  `uuidsalida` varchar(250) DEFAULT NULL,
  `actividades` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
CREATE TABLE `asistencialistado` (
`id` int(11)
,`idusuario` int(11)
,`usuario` varchar(50)
,`fechaentrada` date
,`horaentrada` time
,`ipentrada` varchar(45)
,`bssidentrada` varchar(45)
,`uuidentrada` varchar(250)
,`fechasalida` date
,`horasalida` time
,`ipsalida` varchar(250)
,`bssidsalida` varchar(250)
,`uuidsalida` varchar(250)
,`actividades` varchar(250)
);

CREATE TABLE `usuariosapp` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `clave` varchar(250) DEFAULT NULL,
  `estatus` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

INSERT INTO `usuariosapp` (`id`, `nombre`, `clave`, `estatus`) VALUES
(1, 'admin', '1234', 1);

CREATE TABLE `usuariosweb` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `clave` varchar(250) DEFAULT NULL,
  `estatus` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
DROP TABLE IF EXISTS `asistencialistado`;

CREATE OR REPLACE VIEW `asistencialistado`  AS SELECT `id` AS `id`, `usuario` AS `idusuario`, `usuariosapp`.`nombre` AS `usuario`, `fechaentrada` AS `fechaentrada`, `horaentrada` AS `horaentrada`, `ipentrada` AS `ipentrada`, `bssidentrada` AS `bssidentrada`, `uuidentrada` AS `uuidentrada`, `fechasalida` AS `fechasalida`, `horasalida` AS `horasalida`, `ipsalida` AS `ipsalida`, `bssidsalida` AS `bssidsalida`, `uuidsalida` AS `uuidsalida`, `actividades` AS `actividades` FROM (`asistencia` left join `usuariosapp` on(`usuario` = `usuariosapp`.`id`)) ;


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
