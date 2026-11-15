-- MySQL dump 10.13  Distrib 26.7.0, for Win64 (x86_64)
--
-- Host: localhost    Database: tacnavetmdw
-- ------------------------------------------------------
-- Server version	26.7.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `citas`
--

DROP TABLE IF EXISTS `citas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `citas` (
  `id_cita` int NOT NULL AUTO_INCREMENT,
  `id_mascota` int NOT NULL,
  `id_servicio` int NOT NULL,
  `id_veterinario` int NOT NULL,
  `fecha_cita` datetime NOT NULL,
  `estado` varchar(15) COLLATE utf8mb4_spanish_ci NOT NULL DEFAULT 'Programada',
  `observaciones` varchar(250) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`id_cita`),
  KEY `fk_cita_mascota` (`id_mascota`),
  KEY `fk_cita_servicio` (`id_servicio`),
  KEY `fk_cita_veterinario` (`id_veterinario`),
  CONSTRAINT `fk_cita_mascota` FOREIGN KEY (`id_mascota`) REFERENCES `mascotas` (`id_mascota`) ON DELETE CASCADE,
  CONSTRAINT `fk_cita_servicio` FOREIGN KEY (`id_servicio`) REFERENCES `servicios` (`id_servicio`),
  CONSTRAINT `fk_cita_veterinario` FOREIGN KEY (`id_veterinario`) REFERENCES `usuarios` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `citas`
--

LOCK TABLES `citas` WRITE;
/*!40000 ALTER TABLE `citas` DISABLE KEYS */;
INSERT INTO `citas` VALUES (1,1,1,2,'2026-10-12 10:30:00','Programada','Chequeo general semestral'),(2,2,2,2,'2026-10-12 12:00:00','Atendida','Vacuna antirrábica aplicada'),(3,4,4,3,'2026-10-14 16:00:00','Programada','Baño y corte de pelo'),(4,3,5,2,'2026-10-15 09:00:00','Cancelada','Cliente reprogramará'),(6,10,2,7,'2026-11-05 23:35:00','CONFIRMADA','Aplazada');
/*!40000 ALTER TABLE `citas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `id_cliente` int NOT NULL AUTO_INCREMENT,
  `nombres` varchar(80) COLLATE utf8mb4_spanish_ci NOT NULL,
  `apellidos` varchar(80) COLLATE utf8mb4_spanish_ci NOT NULL,
  `dni` char(8) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `telefono` varchar(15) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `correo` varchar(100) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `direccion` varchar(150) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`id_cliente`),
  UNIQUE KEY `dni` (`dni`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (1,'Fredy','Quispe','00123456','951111222','fredy@gmail.com','Av. Bolognesi 120, Tacna'),(2,'Juana','Pérez','00789012','952222333','juana@gmail.com','Calle Zela 45, Tacna'),(3,'Laura','Gómez','00345678','953333444','laura@gmail.com','Av. San Martín 300, Tacna'),(4,'Pedro','Mamani','00901234','954444555','pedro@gmail.com','Pocollay, Tacna'),(5,'María','Flores Quispe',NULL,'952123456','maria@tacnavet.com',NULL),(6,'Carlos','Mendoza Ríos',NULL,'952654321','carlos@tacnavet.com',NULL),(7,'Rosa','Salas Álvarez',NULL,'954987654','rosa@tacnavet.com',NULL),(8,'Jared Assael ','Ellen Tello','87654321','123456789','jared@tacnavet.com',NULL),(9,'Prueba','Usuario','12345678','123456789','prueba@gmail.com',NULL),(10,'Prueba','Usuario','12345687','','pedro@gmail.com',NULL),(12,'adqwd','dwqdwq','12232211','123545545',NULL,NULL),(13,'Juan','Perez','13243456','123456789','perez@gmail.com',NULL);
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estados`
--

DROP TABLE IF EXISTS `estados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estados` (
  `id_estado` int NOT NULL AUTO_INCREMENT,
  `nombre_estado` varchar(20) COLLATE utf8mb4_spanish_ci NOT NULL,
  PRIMARY KEY (`id_estado`),
  UNIQUE KEY `nombre_estado` (`nombre_estado`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estados`
--

LOCK TABLES `estados` WRITE;
/*!40000 ALTER TABLE `estados` DISABLE KEYS */;
INSERT INTO `estados` VALUES (1,'ACTIVO'),(3,'ANULADO'),(2,'PENDIENTE');
/*!40000 ALTER TABLE `estados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mascotas`
--

DROP TABLE IF EXISTS `mascotas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mascotas` (
  `id_mascota` int NOT NULL AUTO_INCREMENT,
  `id_cliente` int NOT NULL,
  `nombre` varchar(60) COLLATE utf8mb4_spanish_ci NOT NULL,
  `especie` varchar(30) COLLATE utf8mb4_spanish_ci NOT NULL,
  `raza` varchar(50) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `sexo` char(1) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `peso_kg` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`id_mascota`),
  KEY `fk_mascota_cliente` (`id_cliente`),
  CONSTRAINT `fk_mascota_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mascotas`
--

LOCK TABLES `mascotas` WRITE;
/*!40000 ALTER TABLE `mascotas` DISABLE KEYS */;
INSERT INTO `mascotas` VALUES (1,1,'Tatto','Perro','Shih Tzu','2023-04-12','M',6.50),(2,2,'Bela','Perro','Poodle','2022-08-20','H',5.20),(3,3,'Michi','Gato','Mestizo','2024-01-05','M',4.10),(4,4,'Firulais','Perro','Labrador','2021-11-30','M',28.00),(5,1,'Luna','Gato','Siamesa','2024-06-18','H',3.80),(8,2,'Gustavo','Perro','Golden Retriever','2024-01-03','M',6.00),(9,5,'Moly','Perro','Dobberman','2020-02-03','H',4.50),(10,13,'Max','Perro','Golden Retriever','2025-03-21','M',6.40);
/*!40000 ALTER TABLE `mascotas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `perfiles`
--

DROP TABLE IF EXISTS `perfiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `perfiles` (
  `id_perfil` int NOT NULL AUTO_INCREMENT,
  `nombre_perfil` varchar(30) COLLATE utf8mb4_spanish_ci NOT NULL,
  PRIMARY KEY (`id_perfil`),
  UNIQUE KEY `nombre_perfil` (`nombre_perfil`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `perfiles`
--

LOCK TABLES `perfiles` WRITE;
/*!40000 ALTER TABLE `perfiles` DISABLE KEYS */;
INSERT INTO `perfiles` VALUES (2,'ADMINISTRADOR'),(1,'CLIENTE'),(3,'VETERINARIO');
/*!40000 ALTER TABLE `perfiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `servicios`
--

DROP TABLE IF EXISTS `servicios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `servicios` (
  `id_servicio` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(60) COLLATE utf8mb4_spanish_ci NOT NULL,
  `descripcion` varchar(200) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `precio` decimal(8,2) NOT NULL,
  PRIMARY KEY (`id_servicio`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servicios`
--

LOCK TABLES `servicios` WRITE;
/*!40000 ALTER TABLE `servicios` DISABLE KEYS */;
INSERT INTO `servicios` VALUES (1,'Consulta General','Chequeos preventivos, diagnósticos y planes de tratamiento',50.00),(2,'Vacunación','Esquemas de inmunización y control de parásitos',45.00),(3,'Cirugía','Procedimientos quirúrgicos con monitoreo constante',350.00),(4,'Peluquería & Spa','Baños medicados y cortes con productos de calidad',60.00),(5,'Laboratorio Clínico','Análisis de sangre, orina y tejidos',80.00);
/*!40000 ALTER TABLE `servicios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `nombres` varchar(80) COLLATE utf8mb4_spanish_ci NOT NULL,
  `apellidos` varchar(80) COLLATE utf8mb4_spanish_ci NOT NULL,
  `correo` varchar(100) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `contrasena` varchar(100) COLLATE utf8mb4_spanish_ci NOT NULL,
  `rol` varchar(20) COLLATE utf8mb4_spanish_ci NOT NULL,
  `telefono` varchar(15) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `fecha_registro` date NOT NULL,
  `dni` char(8) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `usuario` varchar(50) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `perfil` varchar(20) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `estado` varchar(20) COLLATE utf8mb4_spanish_ci NOT NULL DEFAULT 'PENDIENTE',
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `correo` (`correo`),
  UNIQUE KEY `uq_usuario_dni` (`dni`),
  UNIQUE KEY `uq_usuario_nombre` (`usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'Admin','TacnaVet','admin@tacnavet.com','admin123','ADMIN','993076339','2026-01-15',NULL,'admin','ADMINISTRADOR','ACTIVO'),(2,'María','Flores Quispe','maria@tacnavet.com','vet123','VETERINARIO','952123456','2026-02-01',NULL,'maria','CLIENTE','ACTIVO'),(3,'Carlos','Mendoza Ríos','carlos@tacnavet.com','vet123','VETERINARIO','952654321','2026-02-10',NULL,'carlos','CLIENTE','ACTIVO'),(4,'Rosa','Salas Álvarez','rosa@tacnavet.com','recep123','RECEPCIONISTA','954987654','2026-03-05',NULL,'rosa','CLIENTE','ACTIVO'),(5,'Jared Assael ','Ellen Tello','jared@tacnavet.com','abc123','CLIENTE','123456789','2026-10-08','87654321','Jared','CLIENTE','ACTIVO'),(6,'Prueba','Usuario','prueba@gmail.com','abc123','CLIENTE','123456789','2026-11-02','12345678','prueba123','CLIENTE','ACTIVO'),(7,'Assier Vasco','Ellen Tello','assier@gmail.com','abc123','VETERINARIO','','2026-11-03','24681357','Assier','VETERINARIO','ACTIVO'),(10,'Prueba','Usuario','pedro@gmail.com','abc123','CLIENTE','','2026-11-03','12345687','Pedrito','CLIENTE','ACTIVO'),(11,'adqwd','dwqdwq',NULL,'admin123','CLIENTE','123545545','2026-11-03','12232211','wdqddwq','CLIENTE','ANULADO'),(12,'Juan','Perez','perez@gmail.com','admin123','CLIENTE','123456789','2026-11-03','13243456','Juan','CLIENTE','ACTIVO'),(14,'Javier','Sanchez',NULL,'abc123','VETERINARIO','','2026-11-03','78654321','Javier','VETERINARIO','ACTIVO');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-07 11:42:32
