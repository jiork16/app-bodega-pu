-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 13-02-2022 a las 18:11:09
-- Versión del servidor: 10.4.19-MariaDB
-- Versión de PHP: 8.0.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `pinturas_unidas`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `Sp_ReporInventario` ()  BEGIN
SELECT 
    (Ingreso.Total - IFNULL(Salida.Total, 0)) Total,
    Ingreso.IdProducto,
    Ingreso.cod_producto,
    Ingreso.Producto,
    Ingreso.IdMedida,
    Ingreso.Medida,
    Ingreso.IdLocalidad,
    Ingreso.Localidad,
    Ingreso.IdNivel,
    Ingreso.Nivel,
    Ingreso.IdBodega,
    Ingreso.Bodega,
    Ingreso.lote,
    Ingreso.Categoria,
    Ingreso.id
FROM
    (SELECT 
        SUM(a.cantidad) Total,
            b.id IdProducto,
            b.cod_producto,
            b.descripcion Producto,
            c.id IdMedida,
            c.descripcion Medida,
            d.id IdLocalidad,
            d.descripcion Localidad,
            e.id IdNivel,
            e.descripcion Nivel,
            bo.id IdBodega,
            bo.descripcion Bodega,
            a.lote,
            b. descripcion Categoria,
            a.id
    FROM
        pinturas_unidas.movimiento_inventarios a
    JOIN productos b ON a.id_producto = b.id
    JOIN medidas c ON a.id_medida = c.id
    JOIN bodegas bo ON a.id_bodega = bo.id
    JOIN localidades d ON a.id_localidad = d.id
    JOIN niveles e ON a.nivel = e.id
    JOIN categorias g ON b.id_categoria = g.id
    JOIN tipo_movimientos f ON a.id_tipo_movimiento = f.id
        AND f.accion = '+'
    GROUP BY b.id , b.cod_producto , b.descripcion , c.id , c.descripcion , d.id , d.descripcion , e.id , e.descripcion , bo.id , bo.descripcion
    ,a.lote, b.descripcion) Ingreso
        LEFT JOIN
    (SELECT 
        SUM(a.cantidad) Total,
            b.id IdProducto,
            b.cod_producto,
            b.descripcion Producto,
            c.id IdMedida,
            c.descripcion Medida,
            d.id IdLocalidad,
            d.descripcion Localidad,
            e.id IdNivel,
            e.descripcion Nivel,
            bo.id IdBodega,
            bo.descripcion Bodega,
            a.lote,
            b. descripcion Categoria,
            a.id
    FROM
        pinturas_unidas.movimiento_inventarios a
    JOIN productos b ON a.id_producto = b.id
    JOIN medidas c ON a.id_medida = c.id
    JOIN bodegas bo ON a.id_bodega = bo.id
    JOIN localidades d ON a.id_localidad = d.id
    JOIN niveles e ON a.nivel = e.id
    JOIN categorias g ON b.id_categoria = g.id
    JOIN tipo_movimientos f ON a.id_tipo_movimiento = f.id
        AND f.accion = '-'
    GROUP BY b.id , b.cod_producto , b.descripcion , c.id , c.descripcion , d.id , d.descripcion , e.id , e.descripcion , bo.id , bo.descripcion
    ,a.lote, b.descripcion) Salida ON Ingreso.IdProducto = Salida.IdProducto
        AND Ingreso.IdMedida = Salida.IdMedida
        AND Ingreso.IdLocalidad = Salida.IdLocalidad
        AND Ingreso.IdNivel = Salida.IdNivel
        AND Ingreso.IdBodega = Salida.IdBodega
         AND Ingreso.lote = Salida.lote;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bodegas`
--

CREATE TABLE `bodegas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `descripcion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `bodegas`
--

INSERT INTO `bodegas` (`id`, `descripcion`, `estado`, `created_at`, `updated_at`) VALUES
(1, 'A-Bodega', 1, '2022-01-20 01:42:15', '2022-01-20 01:42:15'),
(2, '1B-Bodega', 1, '2022-01-20 01:42:15', '2022-01-20 01:42:15'),
(3, '1C-Bodega', 1, '2022-01-20 01:42:15', '2022-01-20 01:42:15');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `descripcion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id`, `descripcion`, `estado`, `created_at`, `updated_at`) VALUES
(1, '1101 ESMALTE SUPREMO', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(2, '1104 METALLIC DECO E INDUSTRIAL', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(3, '1107 ESMALTE UNICO', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(4, '1108 ESMALTE BASE AGUA', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(5, '1109 BASES ESMALTE BASE AGUA', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(6, '1110 ESMALTE FERRISARIATO', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(7, '1111 BASES ESMALTE SUPREMO', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(8, '1201 LATEX SUPREMO', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(9, '1202 BASES DE LATEX SUPREMO', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(10, '1203 UNILATEX', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(11, '1205 ELASTOCRYL OPTIMA', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(12, '1206 BASES ELASTOCRYL OPTIMA', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(13, '1207 SUPREMO SATIN', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(14, '1208 BASES  SUPREMO SATIN', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(15, '1211 ELASTOMERICO HIDROREPELENTE', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(16, '1212 BASES ELASTOMERICO HIDROREPELE', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(17, '1213 UNITEJA', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(18, '1215 PINTURA DE CANCHA', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(19, '1216 LATEX ELASTOMERICO CONTRATISTA', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(20, '1217 LINEA DISNEY', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(21, '1218 NEPTUNO', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(22, '1219 BASE SUPREMO SATIN DISNEY', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(23, '1220 PINTALATEX', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(24, '1222 LATEX OBRA', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(25, '1223 REPELENTE INSECTOS', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(26, '1224 BASES SUPREMO DISNEY', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(27, '1225 OPTIMA SATINADO', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(28, '1226 COLLECTION PRO', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(29, '1301 ANTICORROSIVO INDUSTRIAL', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(30, '1302 ANTICORROSIVO MATE', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(31, '1305 ANTICORROSIVO FERRISARIATO', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(32, '1402 UNIEMPASTE', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(33, '1403 UNIFLEX', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(34, '1404 UNISEAL', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(35, '1406 UNIGARD', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(36, '1407 BLOCK FILLER', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(37, '1408 IMPERSEAL', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(38, '1409 CORRECTOR DE ENLUCIDO', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(39, '1410 EMPASTE UNIDAS SUPREMO', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(40, '1420 ALUMINIO LIQUIDO', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(41, '1430 CEMENTO CONTACTO', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(42, '1440 MBT', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(43, '1503 TINTES COLECCION SUPREMO', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(44, '1600 PINTURA EN SPRAY', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(45, '1601 BROCHAS PINTURAS UNIDAS', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(46, '2101 LACAS AUTOMOTRICES', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(47, '2103 FONDO AUTOMOTRIZ', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(48, '2106 SINTETICO SECADO EXPRESS', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(49, '2107 MULTIPRIMER', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(50, '2108 SINTETICOS PLUS SECADO RAPIDO', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(51, '2109 MASILLA PLASTICA', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(52, '2111 REMOVEDOR DE LACA', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(53, '2112 RETARDADOR DE LACAS', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(54, '2113 DESOXIDANTE - FOSFATIZANTE', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(55, '2202 RESINA', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(56, '2203 TINTES UNIVERSAL', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(57, '2204 TRANSPARENTE', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(58, '2205 CATALIZADOR', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(59, '2207 BATEPIEDRA', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(60, '2210 PASTA MATEANTE', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(61, '2212 ACCESORIOS LINEA UNITHANE', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(62, '2213 MASILLA RAPIDA UNIVERSAL', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(63, '2216 WASH PRIMER', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(64, '2402 BASE UNITHANE ADVANCE/3785', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(65, '2403 BATEPIEDRA POLIURETANO ADVANCE', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(66, '2404 BARNIZ UNITHANE ADVANCE', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(67, '2601 LIJAS 3M AGUA', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(68, '2900 PRIMER TITANIUM AUTOMOTRIZ', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(69, '2901 RESINAS TITANIUM AUTOMOTRIZ', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(70, '2903 TRANSPARENTES TITANIU AUT.', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(71, '2904 DILUYENTES TITANIUM AUTOMOTRIZ', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(72, '2905 MASILLA POLIESTER TITANIUM', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(73, '2906 PULIMENTOS', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(74, '2907 COLORES DIRECTOS TITANIUM', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(75, '2908 TRANSPARENTES DURAKROM', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(76, '2909 TRANSPARENTES PLATINUM', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(77, '3101 BARNIZ SUPREMO', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(78, '3102 LACA TRANSPARENTE BRILLANTE', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(79, '3103 LACA TRANSPARENTE MATE', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(80, '3104 LACA SELLADOR', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(81, '3105 PRESERVANTES DE MADERA', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(82, '3201 A.S. FONDO CATALIZADO', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(83, '3202 A.S. SELLADOR CATALIZADO', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(84, '3203 A.S. TRANP.  BRILLANTE CATALIZ', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(85, '3204 A.S. LACAS DE COLORES CATALIZA', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(86, '3205 A.S. CATALIZADOR', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(87, '3301 UNITINTES', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(88, '3402 MOBELLACK SELLADOR POLIURETANO', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(89, '3404 REDUCTOR PARA MADERA MOBELLACK', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(90, '3407 MASILLA PARA MADERA', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(91, '4101 DILUYENTE INDUSTRIAL', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(92, '8101 PRIMERS EPOXICO', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(93, '8102 EPOXICO POLIAMIDA', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(94, '8103 EPOXICO UNIMASTC', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(95, '8104 COALTAR EPOXICO', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(96, '8105 ESMALTES HORMEABLES', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(97, '8107 POLIURETANO ACRILICO', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(98, '8109 ACRILICO ESTIRENADO', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(99, '8110 ESMALTE ALQUIDICO', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(100, '8111 ESM. ALTA TEMPERATURA', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(101, '8112 TRAFICO ALTOS SOLIDOS', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(102, '8113 ANTIFOULING', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(103, '8115 PRODUCTOS QUIMICOS', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(104, '8117 CATALIZADOR LINEA INDUSTRIAL', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(105, '8121 UNIPOX BASE AGUA', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(106, '8200 COMPOSITES', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(107, '8300 TINTES INDUSTRIALES', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(108, '8400 EPOXICOS', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(109, '8600 POLIURETANO', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(110, '999  VARIOS', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(111, 'AFIC AFICHES', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(112, 'ART  ARTICULO DE PROMOCION', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(113, 'CAMI CAMISETAS', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(114, 'ENV  ENVASES', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(115, 'MARQ MAQUINARIA LINEA ARQUITECTONIC', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(116, 'MAUT MAQUINARIA LINEA AUTOMOTRIZ', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(117, 'MPI  MATERIA PRIMA IMPORTADA', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(118, 'RALF RESINAS ALFA', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(119, 'SB04 BROCHAS', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(120, 'SE02 ENVASES', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(121, 'SL02 LIJAS', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(122, 'SR02 RODILLOS', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15'),
(123, 'TUNI TINTES UNIVERSALES EN GRAMOS', 1, '2022-01-19 20:18:15', '2022-01-19 20:18:15');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `localidades`
--

CREATE TABLE `localidades` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `descripcion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `localidades`
--

INSERT INTO `localidades` (`id`, `descripcion`, `estado`, `created_at`, `updated_at`) VALUES
(1, 'A-Localidad', 1, '2022-01-20 01:42:15', '2022-01-20 01:42:15'),
(2, 'B-Localidad', 1, '2022-01-20 01:42:15', '2022-01-20 01:42:15'),
(3, 'C-Localidad', 1, '2022-01-20 01:42:15', '2022-01-20 01:42:15'),
(4, 'D-Localidad', 1, '2022-01-20 01:42:15', '2022-01-20 01:42:15'),
(5, 'E-Localidad', 1, '2022-01-20 01:42:15', '2022-01-20 01:42:15'),
(6, 'F-Localidad', 1, '2022-01-20 01:42:15', '2022-01-20 01:42:15'),
(7, 'G-Localidad', 1, '2022-01-20 01:42:15', '2022-01-20 01:42:15'),
(8, 'H-Localidad', 1, '2022-01-20 01:42:15', '2022-01-20 01:42:15'),
(9, 'I-Localidad', 1, '2022-01-20 01:42:15', '2022-01-20 01:42:15'),
(10, 'J-Localidad', 1, '2022-01-20 01:42:15', '2022-01-20 01:42:15'),
(11, 'K-Localidad', 1, '2022-01-20 01:42:15', '2022-01-20 01:42:15'),
(12, 'L-Localidad', 1, '2022-01-20 01:42:15', '2022-01-20 01:42:15'),
(13, 'M-Localidad', 1, '2022-01-20 01:42:15', '2022-01-20 01:42:15'),
(14, 'N-Localidad', 1, '2022-01-20 01:42:15', '2022-01-20 01:42:15');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `medidas`
--

CREATE TABLE `medidas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `codigo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `medidas`
--

INSERT INTO `medidas` (`id`, `codigo`, `descripcion`, `estado`, `created_at`, `updated_at`) VALUES
(1, 'A', 'GALON', 1, '2022-01-20 01:42:15', '2022-01-20 01:42:15'),
(2, 'B', 'LITRO', 1, '2022-01-20 01:42:15', '2022-01-20 01:42:15'),
(3, 'C', 'CUARTO DE LITO', 1, '2022-01-20 01:42:15', '2022-01-20 01:42:15'),
(4, 'D', 'OCTAVO DE LITRO', 1, '2022-01-20 01:42:15', '2022-01-20 01:42:15');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(122, '2022_01_16_151337_create_sessions_table', 1),
(171, '2014_10_12_000000_create_users_table', 2),
(172, '2014_10_12_100000_create_password_resets_table', 2),
(173, '2014_10_12_200000_add_two_factor_columns_to_users_table', 2),
(174, '2014_10_12_300000_create_sessions_table', 2),
(175, '2019_08_19_000000_create_failed_jobs_table', 2),
(176, '2019_12_14_000001_create_personal_access_tokens_table', 2),
(177, '2022_01_16_161600_create_categorias_table', 2),
(178, '2022_01_16_161601_create_productos_table', 2),
(179, '2022_01_16_162243_create_bodegas_table', 2),
(180, '2022_01_16_162514_create_localidades_table', 2),
(181, '2022_01_16_162529_create_niveles_table', 2),
(182, '2022_01_16_162654_create_tipo_movimientos_table', 2),
(183, '2022_01_16_162804_create_medidas_table', 2),
(184, '2022_01_16_163948_create_movimiento_inventarios_table', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `movimiento_inventarios`
--

CREATE TABLE `movimiento_inventarios` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `cantidad` decimal(8,2) NOT NULL,
  `fecha_movimiento` date NOT NULL,
  `lote` int(11) NOT NULL,
  `id_producto` bigint(20) UNSIGNED NOT NULL,
  `id_medida` bigint(20) UNSIGNED NOT NULL,
  `id_bodega` bigint(20) UNSIGNED NOT NULL,
  `id_localidad` bigint(20) UNSIGNED NOT NULL,
  `id_tipo_movimiento` bigint(20) UNSIGNED NOT NULL,
  `nivel` bigint(20) UNSIGNED NOT NULL,
  `id_usuario_ing` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `movimiento_inventarios`
--

INSERT INTO `movimiento_inventarios` (`id`, `cantidad`, `fecha_movimiento`, `lote`, `id_producto`, `id_medida`, `id_bodega`, `id_localidad`, `id_tipo_movimiento`, `nivel`, `id_usuario_ing`, `created_at`, `updated_at`) VALUES
(1, '10000.00', '2022-01-20', 32014576, 43, 1, 1, 1, 1, 1, 1, '2022-01-20 22:06:40', '2022-01-20 22:06:40'),
(2, '58996.00', '2022-01-21', 32014575, 1, 1, 1, 1, 2, 1, 1, '2022-01-20 22:48:54', '2022-01-20 22:48:54'),
(3, '9606.00', '2022-01-21', 32014575, 1, 1, 1, 1, 1, 1, 1, '2022-01-20 23:16:40', '2022-01-20 23:16:40'),
(4, '3000.00', '2022-01-22', 32014575, 1, 1, 1, 1, 3, 1, 1, '2022-01-20 23:21:39', '2022-01-20 23:21:39'),
(5, '58563.00', '2022-01-23', 32014577, 1, 1, 1, 1, 1, 1, 1, '2022-01-21 20:48:24', '2022-01-21 20:48:24'),
(6, '10000.00', '2022-01-24', 32014576, 43, 1, 1, 1, 1, 1, 1, '2022-01-25 01:00:10', '2022-01-25 01:00:10'),
(7, '10000.00', '2022-01-24', 32014576, 43, 1, 1, 1, 1, 1, 1, '2022-01-25 01:00:26', '2022-01-25 01:00:26'),
(8, '10000.00', '2022-01-24', 32014576, 43, 1, 1, 1, 1, 1, 1, '2022-01-25 01:02:00', '2022-01-25 01:02:00'),
(9, '58996.00', '2022-01-24', 32014575, 1, 1, 1, 1, 2, 1, 1, '2022-01-25 01:05:30', '2022-01-25 01:05:30'),
(10, '5896.00', '2022-01-24', 32014575, 1, 1, 1, 1, 4, 1, 1, '2022-01-25 02:13:12', '2022-01-25 02:13:12'),
(11, '962.00', '2022-01-24', 32014575, 1, 1, 1, 1, 3, 1, 1, '2022-01-25 02:15:21', '2022-01-25 02:15:21'),
(12, '962.00', '2022-01-24', 32014575, 1, 1, 1, 1, 3, 1, 1, '2022-01-25 02:15:48', '2022-01-25 02:15:48'),
(13, '38.00', '2022-01-24', 32014575, 1, 1, 1, 1, 3, 1, 1, '2022-01-25 02:17:36', '2022-01-25 02:17:36'),
(14, '740.00', '2022-01-24', 32014575, 1, 1, 1, 1, 3, 1, 1, '2022-01-25 02:41:18', '2022-01-25 02:41:18'),
(15, '740.00', '2022-01-24', 32014575, 1, 1, 1, 1, 3, 1, 1, '2022-01-25 02:41:27', '2022-01-25 02:41:27'),
(16, '260.00', '2022-01-24', 32014575, 1, 1, 1, 1, 3, 1, 1, '2022-01-25 02:43:33', '2022-01-25 02:43:33'),
(17, '65.00', '2022-01-24', 32014577, 1, 1, 1, 1, 3, 1, 1, '2022-01-25 02:52:00', '2022-01-25 02:52:00'),
(18, '65.00', '2022-01-24', 32014577, 1, 1, 1, 1, 3, 1, 1, '2022-01-25 02:52:33', '2022-01-25 02:52:33'),
(19, '65.00', '2022-01-24', 32014577, 1, 1, 1, 1, 3, 1, 1, '2022-01-25 02:56:21', '2022-01-25 02:56:21'),
(20, '65.00', '2022-01-24', 32014577, 1, 1, 1, 1, 3, 1, 1, '2022-01-25 02:56:32', '2022-01-25 02:56:32'),
(21, '65.00', '2022-01-25', 32014577, 1, 1, 1, 1, 3, 1, 1, '2022-01-25 18:54:33', '2022-01-25 18:54:33'),
(22, '38.00', '2022-01-25', 32014577, 1, 1, 1, 1, 4, 1, 1, '2022-01-25 18:57:56', '2022-01-25 18:57:56'),
(23, '200.00', '2022-01-25', 32014577, 1, 1, 1, 1, 3, 1, 1, '2022-01-25 18:58:25', '2022-01-25 18:58:25'),
(24, '1.00', '2022-01-25', 32014575, 1, 1, 1, 1, 4, 1, 1, '2022-01-25 19:34:20', '2022-01-25 19:34:20'),
(25, '2.00', '2022-01-25', 32014575, 1, 1, 1, 1, 3, 1, 1, '2022-01-25 19:36:21', '2022-01-25 19:36:21'),
(26, '7.00', '2022-01-25', 32014575, 1, 1, 1, 1, 3, 1, 1, '2022-01-25 19:36:41', '2022-01-25 19:36:41'),
(27, '90.00', '2022-01-25', 32014575, 1, 1, 1, 1, 4, 1, 1, '2022-01-25 19:47:16', '2022-01-25 19:47:16'),
(28, '5.00', '2022-01-25', 32014576, 43, 1, 1, 1, 5, 1, 1, '2022-01-25 19:47:57', '2022-01-25 19:47:57'),
(29, '8.00', '2022-01-25', 32014577, 1, 1, 1, 1, 5, 1, 1, '2022-01-25 19:48:21', '2022-01-25 19:48:21'),
(30, '92.00', '2022-01-27', 32014577, 1, 1, 1, 1, 4, 1, 1, '2022-01-27 06:43:46', '2022-01-27 06:43:46'),
(31, '6.00', '2022-01-27', 32014576, 43, 1, 1, 1, 3, 1, 2, '2022-01-27 06:46:58', '2022-01-27 06:46:58'),
(32, '80.00', '2022-01-27', 32014576, 43, 1, 1, 1, 3, 1, 2, '2022-01-27 06:49:11', '2022-01-27 06:49:11');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `niveles`
--

CREATE TABLE `niveles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `descripcion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `niveles`
--

INSERT INTO `niveles` (`id`, `descripcion`, `estado`, `created_at`, `updated_at`) VALUES
(1, 'Nivel-1', 1, '2022-01-20 01:42:15', '2022-01-20 01:42:15'),
(2, 'Nivel-2', 1, '2022-01-20 01:42:15', '2022-01-20 01:42:15'),
(3, 'Nivel-3', 1, '2022-01-20 01:42:15', '2022-01-20 01:42:15'),
(4, 'Nivel-4', 1, '2022-01-20 01:42:15', '2022-01-20 01:42:15'),
(5, 'Nivel-5', 1, '2022-01-20 01:42:15', '2022-01-20 01:42:15');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `cod_producto` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_categoria` bigint(20) UNSIGNED NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id`, `cod_producto`, `descripcion`, `id_categoria`, `estado`, `created_at`, `updated_at`) VALUES
(1, '5000', 'ESM SUP BLANCO POLAR', 1, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(2, '531', 'ESM.  GRIS CLARO', 1, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(3, '571', 'ESM. ALUMINIO ESPECIAL', 1, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(4, '589', 'ESM. AMARILLO', 1, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(5, '521', 'ESM. AMARILLO TOPACIO', 1, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(6, '521', 'ESM. AMARILLO TOPACIO.', 1, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(7, '552', 'ESM. ARENA', 1, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(8, '530', 'ESM. AZUL CIELO', 1, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(9, '532', 'ESM. AZUL FRANCES', 1, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(10, '529', 'ESM. AZUL MALIBU', 1, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(11, '903', 'ESM. AZUL MAR', 1, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(12, '551', 'ESM. BEIGE', 1, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(13, '581', 'ESM. BLANCO ANTIGUO', 1, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(14, '520', 'ESM. BLANCO HUESO', 1, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(15, '580', 'ESM. BLANCO MATE', 1, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(16, '584', 'ESM. DAMASCO', 1, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(17, '533', 'ESM. DURAZNO', 1, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(18, '531', 'ESM. GRIS CLARO', 1, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(19, '526', 'ESM. GRIS INTENSO', 1, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(20, '507', 'ESM. MANDARINA', 1, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(21, '506', 'ESM. NARANJA AVENTURERO', 1, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(22, '550', 'ESM. NEGRO', 1, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(23, '585', 'ESM. NEGRO MATE', 1, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(24, '534', 'ESM. ROBLE CLARO', 1, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(25, '513', 'ESM. ROJO FIESTA', 1, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(26, '513', 'ESM. ROJO FIESTA.', 1, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(27, '509', 'ESM. ROJO VINO', 1, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(28, '5051', 'ESM. SUP. GRIS CLARO DISENSA', 1, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(29, '5053', 'ESM. SUP. ROJO DISENSA', 1, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(30, '545', 'ESM. TIFFANY', 1, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(31, '547', 'ESM. VERDE CRAYOLA.', 1, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(32, '516', 'ESM. VERDE ESMERALDA', 1, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(33, '525', 'ESM. VERDE INTENSO', 1, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(34, '518', 'ESMALTE AZUL', 1, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(35, '530', 'ESMALTE AZUL CIELO', 1, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(36, '524', 'ESMALTE CAOBA', 1, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(37, '526', 'ESMALTE GRIS INTENSO', 1, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(38, '510', 'ESMALTE MARFIL', 1, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(39, '527', 'ESMALTE ORANGE', 1, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(40, '523', 'ESMALTE ROJO', 1, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(41, '522', 'ESMALTE TURQUESA', 1, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(42, '522', 'ESMALTE TURQUESA.', 1, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(43, '375', 'DORADO', 2, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(44, '570', 'ESM. ALUMINIO', 2, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(45, '702', 'ESM. MARTILLADO AZUL', 2, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(46, '705', 'ESM. MARTILLADO GRIS', 2, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(47, '703', 'ESM. MARTILLADO VERDE', 2, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(48, '380', 'ORO ANTIGUO', 2, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(49, '370', 'VERDE BRONCE', 2, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(50, '786', 'ESM. GRIS  ARMADA', 3, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(51, '786', 'ESM. GRIS ARMADA', 3, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(52, '721', 'ESM. UNICO AMARILLO', 3, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(53, '752', 'ESM. UNICO ARENA', 3, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(54, '733', 'ESM. UNICO AZUL  GALES', 3, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(55, '754', 'ESM. UNICO AZUL ELECTRICO', 3, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(56, '733', 'ESM. UNICO AZUL GALES', 3, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(57, '751', 'ESM. UNICO BEIGE', 3, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(58, '720', 'ESM. UNICO BL. HUESO', 3, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(59, '700', 'ESM. UNICO BLANCO', 3, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(60, '780', 'ESM. UNICO BLANCO MATE', 3, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(61, '700', 'ESM. UNICO BLANCO.', 3, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(62, '724', 'ESM. UNICO CAOBA', 3, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(63, '788', 'ESM. UNICO DURAZNO', 3, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(64, '731', 'ESM. UNICO GRIS', 3, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(65, '717', 'ESM. UNICO GRIS CLARO', 3, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(66, '790', 'ESM. UNICO GRIS MATE', 3, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(67, '726', 'ESM. UNICO MARFIL', 3, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(68, '750', 'ESM. UNICO NEGRO', 3, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(69, '785', 'ESM. UNICO NEGRO MATE', 3, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(70, '723', 'ESM. UNICO ROJO', 3, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(71, '753', 'ESM. UNICO ROJO CANDY', 3, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(72, '713', 'ESM. UNICO ROJO FIESTA', 3, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(73, '760', 'ESM. UNICO TOQUE DE SOL', 3, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(74, '747', 'ESM. UNICO VERDE KRAYOLA', 3, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(75, '725', 'ESM. VERDE INTENSO', 3, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(76, '782', 'ESM. VERDE TROPICO', 3, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(77, '732', 'ESM.UNICO  AZUL FRANCES', 3, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(78, '732', 'ESM.UNICO AZUL FRANCES', 3, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(79, '718', 'ESM.UNICO AZUL INTENSO', 3, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(80, '728', 'ESM.UNICO NARANJA POMELO', 3, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(81, 'AQ1000', 'ESM. ACQUA  BLANCO', 4, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(82, 'AQ1001', 'ESM.ACQUA BL. ANTIGUO', 4, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(83, 'AQ1999', 'ESM.ACQUA GENER. ESPEC.', 4, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(84, 'AQ1002', 'ESM.ACQUA MARFIL', 4, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(85, 'AQA1000', 'BASE ACQUA ACCENT', 5, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(86, 'AQD1000', 'BASE ACQUA DEEP', 5, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(87, 'AQP1000', 'BASE ACQUA PASTEL', 5, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(88, 'AQP1000', 'BASE ACQUA PASTEL .', 5, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(89, 'AQU1000', 'SUPR.ACQUA BASE ULTRA PROF', 5, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(90, '112889', 'ESM. FERRISAR. GL.NEGRO MATE', 6, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(91, '112889', 'ESM. FERRISAR. LT.NEGRO MATE', 6, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(92, '112890', 'ESM. FERRISARIATO GL. BL. MATE', 6, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(93, '112880', 'ESM. FERRISARIATO GL. BLANCO', 6, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(94, '112897', 'ESM. FERRISARIATO GL. CAOBA', 6, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(95, '112882', 'ESM. FERRISARIATO GL. CREMA', 6, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(96, '112893', 'ESM. FERRISARIATO GL. NEGRO', 6, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(97, '112884', 'ESM. FERRISARIATO GL. TRIGO', 6, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(98, '112890', 'ESM. FERRISARIATO LT. BL. MATE', 6, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(99, '112880', 'ESM. FERRISARIATO LT. BLANCO', 6, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(100, '112897', 'ESM. FERRISARIATO LT. CAOBA', 6, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(101, '112893', 'ESM. FERRISARIATO LT. NEGRO', 6, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(102, '112884', 'ESM. FERRISARIATO LT. TRIGO', 6, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(103, '112882', 'ESM.FERRISARIATO LT. CREMA', 6, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(104, 'ESA5000', 'BASE  ESM.  SUPREMO ACCENT', 7, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(105, 'ESD5000', 'BASE  ESM.  SUPREMO DEEP', 7, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(106, 'ESP5000', 'BASE  ESM.  SUPREMO PASTEL', 7, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(107, 'EST5000', 'BASE  ESM.  SUPREMO TINT', 7, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(108, 'ESU5000', 'BASE  ESM.  SUPREMO ULTRA', 7, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(109, 'ESA5000', 'BASE ESM. SUPREMO ACCENT', 7, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(110, 'ESD5000', 'BASE ESM. SUPREMO DEEP', 7, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(111, 'ESP5000', 'BASE ESM. SUPREMO PASTEL', 7, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(112, 'EST5000', 'BASE ESM. SUPREMO TINT', 7, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(113, 'ESU5000', 'BASE ESM. SUPREMO ULTRA', 7, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(114, 'LS1063', 'LATEX SUP.  SOL POSITANO', 8, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(115, 'LS1021', 'LATEX SUP.  TOQUE DE SOL', 8, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(116, 'LS1080', 'LATEX SUP. AMARILLO DISENSA', 8, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(117, 'LS1004', 'LATEX SUP. ARENA', 8, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(118, 'LS1048', 'LATEX SUP. ARENA SAHARA', 8, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(119, 'LS1007', 'LATEX SUP. AZUL ENSENADA', 8, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(120, 'LS1041', 'LATEX SUP. AZUL MALIBU', 8, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(121, 'LS1008', 'LATEX SUP. BAMBU', 8, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(122, 'LS1000', 'LATEX SUP. BLANCO', 8, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(123, 'LS1001', 'LATEX SUP. BLANCO ANTIGUO', 8, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(124, 'LS1054', 'LATEX SUP. BLANCO APACIBLE', 8, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(125, 'LS1010', 'LATEX SUP. BLANCO HUESO', 8, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(126, 'LS1005', 'LATEX SUP. BLANCO OSTRA', 8, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(127, 'LS1047', 'LATEX SUP. BRISA BEIGE', 8, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(128, 'LS1036', 'LATEX SUP. CAFE CATALAN', 8, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(129, 'LS1046', 'LATEX SUP. CREMA', 8, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(130, 'LS1064', 'LATEX SUP. CREMA SANTORINI', 8, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(131, 'LS1009', 'LATEX SUP. DAMASCO', 8, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(132, 'LS1081', 'LATEX SUP. GRIS CLARO DISENSA', 8, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(133, 'LS1055', 'LATEX SUP. HUESO CLARO', 8, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(134, 'LS1014', 'LATEX SUP. LADRILLO ESPANOL', 8, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(135, 'LS1061', 'LATEX SUP. LILA MAGICO', 8, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(136, 'LS1011', 'LATEX SUP. MAGNOLIA', 8, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(137, 'LS1056', 'LATEX SUP. MAIZ TOSTADO', 8, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(138, 'LS1002', 'LATEX SUP. MARFIL', 8, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(139, 'LS1057', 'LATEX SUP. NARANJA CHICK', 8, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(140, 'LS1045', 'LATEX SUP. ROJO ATREVIDO', 8, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(141, 'LS1083', 'LATEX SUP. ROJO DISENSA', 8, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(142, 'LS1058', 'LATEX SUP. ROJO ILUSION', 8, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(143, 'LS1038', 'LATEX SUP. ROJO SALMON', 8, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(144, 'LS1035', 'LATEX SUP. ROSA SUAVE', 8, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(145, 'LS1006', 'LATEX SUP. TABACO', 8, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(146, 'LS1020', 'LATEX SUP. TANGERINE', 8, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(147, 'LS1040', 'LATEX SUP. TECA', 8, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(148, 'LS1022', 'LATEX SUP. TERRACOTA', 8, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(149, 'LS1003', 'LATEX SUP. TERRANOVA', 8, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(150, 'LS1044', 'LATEX SUP. TIFFANY', 8, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(151, 'LS1021', 'LATEX SUP. TOQUE DE SOL', 8, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(152, 'LS1013', 'LATEX SUP. TRIGO', 8, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(153, 'LS1012', 'LATEX SUP. VERDE BOSQUE', 8, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(154, 'LS1024', 'LATEX SUP. VERDE CEIBO', 8, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(155, 'LS1017', 'LATEX SUP. VERDE KRAYOLA', 8, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(156, 'LS1015', 'LATEX SUP. VERDE OLIVO', 8, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(157, 'LS1048', 'LATEX SUP.ARENA SAHARA', 8, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(158, 'LS1007', 'LATEX SUP.AZUL ENSENADA', 8, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(159, 'LS1054', 'LATEX SUP.BLANCO APACIBLE', 8, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(160, 'LS1047', 'LATEX SUP.BRISA BEIGE', 8, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(161, 'LS1062', 'LATEX SUP.CAFE NAPOLITANO', 8, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(162, 'LS1046', 'LATEX SUP.CREMA', 8, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(163, 'LS1064', 'LATEX SUP.CREMA SANTORINI', 8, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(164, 'LS1061', 'LATEX SUP.LILA MAGICO', 8, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(165, 'LS1059', 'LATEX SUP.NARANJA AVENTURERO', 8, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(166, 'LS1021', 'LATEX SUP.TOQUE DE SOL', 8, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(167, 'LS1060', 'LATEX SUP.VIOLETA ENCANTADO', 8, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(168, 'LSM199', 'LATEX SUPREMO ESPECIAL', 8, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(169, 'SA300', 'BASE SUPREMO ACCENT', 9, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(170, 'SD300', 'BASE SUPREMO DEEP', 9, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(171, 'SP300', 'BASE SUPREMO PASTEL', 9, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(172, 'ST300', 'BASE SUPREMO TINT', 9, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(173, 'SU300', 'BASE SUPREMO ULTRA PROF', 9, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(174, 'SP300', 'BASE SUPRMO PASTEL', 9, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(175, 'SU300', 'BASE SUPRMO ULTRA PROF', 9, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(176, '281', 'UNICOLAT.AMAR.REFLEJO', 10, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(177, '282', 'UNICOLAT.VERDE TROPICO', 10, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(178, '293', 'UNICOLATEX AMARILLO', 10, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(179, '280', 'UNICOLATEX AZUL OCEANO', 10, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(180, '291', 'UNICOLATEX BLAN. HUESO', 10, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(181, '290', 'UNICOLATEX BLANCO', 10, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(182, '291', 'UNICOLATEX BLANCO HUESO', 10, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(183, '284', 'UNICOLATEX BRISA', 10, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(184, '298', 'UNICOLATEX DURAZNO', 10, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(185, '283', 'UNICOLATEX MANDARINA', 10, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(186, '292', 'UNICOLATEX MARFIL', 10, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(187, '297', 'UNICOLATEX PALO ROSA', 10, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(188, '286', 'UNICOLATEX ROJO CENIZO', 10, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(189, '294', 'UNICOLATEX VERDE CLARO', 10, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(190, '282', 'UNICOLATEX VERDE TROPICO', 10, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(191, 'LO9004', 'ELASTOC. OPTIMA AMAR.MAGICO', 11, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(192, 'LO9001', 'ELASTOC. OPTIMA BLANCO ANTIGUO', 11, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(193, 'LO9013', 'ELASTOC. OPTIMA TERRACOTA', 11, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(194, 'LO9012', 'ELASTOC. OPTIMA VERDE HADA', 11, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(195, 'LO9007', 'ELASTOC.OPTIMA AZUL PIRATA', 11, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(196, 'LO9001', 'ELASTOC.OPTIMA BLANCO ANTIGUO', 11, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(197, 'LO9016', 'ELASTOC.OPTIMA CELESTE CARIBE', 11, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(198, 'LO9014', 'ELASTOC.OPTIMA LADRILLO ESPAÑO', 11, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(199, 'LO9019', 'ELASTOC.OPTIMA LILA BOREAL', 11, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(200, 'LO9020', 'ELASTOC.OPTIMA NARANJA OTOÑAL', 11, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(201, 'LO9008', 'ELASTOC.OPTIMA PISTACHO', 11, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(202, 'LO9017', 'ELASTOC.OPTIMA VERDE PRIMAVERA', 11, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(203, 'LO9003', 'ELASTOCRYL OPTIMA  DURZNO', 11, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(204, 'LO9002', 'ELASTOCRYL OPTIMA  MARFIL', 11, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(205, 'LO9006', 'ELASTOCRYL OPTIMA AVELLANA', 11, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(206, 'LO9010', 'ELASTOCRYL OPTIMA BL. HUESO', 11, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(207, 'LO9005', 'ELASTOCRYL OPTIMA BL. OSTRA', 11, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(208, 'LO9000', 'ELASTOCRYL OPTIMA BLANCO', 11, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(209, 'LO9003', 'ELASTOCRYL OPTIMA DURAZNO', 11, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(210, 'LO9018', 'ELASTOCRYL OPTIMA FANTASIA', 11, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(211, 'LO9009', 'ELASTOCRYL OPTIMA MANDARINA', 11, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(212, 'LO9002', 'ELASTOCRYL OPTIMA MARFIL', 11, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(213, 'LO9011', 'ELASTOCRYL OPTIMA MELON', 11, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(214, 'LO9015', 'ELASTOCRYL OPTIMA MENTA', 11, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(215, 'LO9013', 'ELASTOCRYL OPTIMA TERRACOTA', 11, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(216, 'LOU9000', 'BASE ELASTOC.OPTIM.ULTRA PROF', 12, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(217, 'LOA9000', 'BASE ELASTOC.OPTIMA  ACCENT', 12, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(218, 'LOA9000', 'BASE ELASTOC.OPTIMA ACCENT', 12, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(219, 'LOT9000', 'BASE ELASTOC.OPTIMA TINT', 12, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(220, 'LOU9000', 'BASE ELASTOC.OPTIMA ULTRA PROFUNDA', 12, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(221, 'LOD9000', 'BASE ELASTOCR.OPTIMA  DEEP', 12, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(222, 'LOD9000', 'BASE ELASTOCR.OPTIMA DEEP', 12, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(223, 'LOT9000', 'BASE ELASTOCR.OPTIMA TINT', 12, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(224, 'LOD9000', 'BASE ELASTOCRYL OPTIMA DEEP', 12, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(225, 'LOP9000', 'BLANCO ACABADO/BASE PASTEL', 12, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(226, 'SS1004', 'LATEX SAT. ARENA', 13, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(227, 'SS1001', 'LATEX SAT. BLANCO ANTIGUO', 13, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(228, 'SS1010', 'LATEX SAT. BLANCO HUESO', 13, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(229, 'SS1002', 'LATEX SAT. MARFIL', 13, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(230, 'SS1001', 'LATEX SAT.BL.ANTIGUO', 13, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(231, 'SS1002', 'LATEX SATIN  MARFIL.', 13, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(232, 'SS1004', 'LATEX SATIN ARENA', 13, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(233, 'SS1008', 'LATEX SATIN BAMBU', 13, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(234, 'SS1010', 'LATEX SATIN BL. HUESO', 13, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(235, 'SS1010', 'LATEX SATIN BLANCO HUESO', 13, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(236, 'SS1002', 'LATEX SATIN MARFIL', 13, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(237, 'SS1013', 'LATEX SATIN TRIGO', 13, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(238, 'SS1000', 'LATEX SUP.SAT.BLANCO', 13, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(239, 'SS1000', 'LATEX SUP.SAT.BLANCO.', 13, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(240, 'SS1042', 'LATEX SUP.SAT.PRIMROSE', 13, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(241, 'SS1058', 'LATEX SUP.SAT.ROJO ILUSION', 13, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(242, 'SS1060', 'SATIN.VIOLETA ENCANTADO', 13, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(243, 'SS1067', 'SUP.SATIN ALMENDRA', 13, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(244, 'SS1067', 'SUP.SATIN. ALMENDRA', 13, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(245, 'SS1000', 'SUPREMO SATIN BLANCO.', 13, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(246, 'SSU3000', 'BASE SUPR SATIN ULT PROF', 14, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(247, 'SSA3000', 'SUPREMO SATIN ACCENT', 14, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(248, 'SSA3000', 'SUPREMO SATIN ACCENT.', 14, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(249, 'SSD3000', 'SUPREMO SATIN DEEP', 14, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(250, 'SSP3000', 'SUPREMO SATIN PASTEL', 14, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(251, 'SST3000', 'SUPREMO SATIN TINT', 14, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(252, 'SPEL199', 'ELASTOMER.ESPECIAL LISO/CANECA', 15, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(253, 'SPEL199', 'SUP. ELASTOMER.ESPEC.LISO GL.', 15, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(254, 'SPE1030', 'SUP.ELAST.BLANCO ROMA', 15, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(255, 'SPE1000', 'SUP.ELAST.HIDROR. BLANCO', 15, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(256, 'SPE1032', 'SUP.ELAST.HIDROR. BRISSA FORTE', 15, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(257, 'SPE1034', 'SUP.ELAST.HIDROR.CREMA RIMINI', 15, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(258, 'SPE1000', 'SUP.ELAST.HIDROREPEL.BLANCO', 15, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(259, 'SPE1031', 'SUP.ELASTOM. HIDROREP.SOLE MIO', 15, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(260, 'SPE1031', 'SUP.ELASTOM.HDROREP. SOLE MIO', 15, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(261, 'SPE1030', 'SUP.PREM.ELAST.BLANCO ROMA', 15, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(262, 'SPED1000', 'BASE SUP.ELAST. HIDROR. DEEP', 16, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(263, 'SPED1000', 'BASE SUP.ELAST. HIDROREP  DEEP', 16, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(264, 'SPET1000', 'BASE SUP.ELAST.HIDROR TINT', 16, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(265, 'SPEA1000', 'BASE SUP.ELAST.HIDROR.  ACCENT', 16, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(266, 'SPEA1000', 'BASE SUP.ELAST.HIDROR. ACCENT', 16, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(267, 'SPEP1000', 'BASE SUP.ELAST.HIDROR. PASTEL', 16, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(268, 'SPET1000', 'BASE SUP.ELASTOM.HIDROR. TINT', 16, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(269, 'SPEP1000', 'BASE SUP.ELASTOM.HIDROR.PASTEL', 16, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(270, 'SPEU1000', 'SUP.ELAST.HIDROR. ULTRA PROFUNDA', 16, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(271, '170', 'BASE UNITEJA', 17, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(272, '160', 'UNITEJA AZUL', 17, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(273, '152', 'UNITEJA NARANJA', 17, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(274, '151', 'UNITEJA NARANJA VIVO', 17, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(275, '164', 'UNITEJA NEGRO', 17, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(276, '153', 'UNITEJA ROJO CLASICO', 17, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(277, '150', 'UNITEJA ROJO INTENSO', 17, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(278, '180', 'UNITEJA TECHO FRIO', 17, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(279, '157', 'UNITEJA TEJA COLONIAL', 17, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(280, '157', 'UNITEJA TEJA COLONIAL.', 17, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(281, '155', 'UNITEJA TEJA ESPAÑOLA', 17, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(282, '158', 'UNITEJA VERDE', 17, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(283, '1107', 'AZUL CANCHA DEPORTIVA', 18, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(284, '1118', 'BASE CANCHA DEPORTIVA', 18, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(285, '1115', 'BLANCO CANCHA DEPORTIVA', 18, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(286, '1106', 'NARANJA CANCHA DEPORTIVA', 18, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(287, '1108', 'VERDE CANCHA DEPORTIVA', 18, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(288, 'EC1055', 'ELASTOM.CONTR.CREMA RIMINI-TERRENOVA/JOS', 19, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(289, 'EC1099', 'ELASTOMER. CONTRATISTA ESP./5G', 19, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(290, 'EC1000', 'ELASTOMER.CONTRAT.BLANCO/50GL', 19, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(291, 'EC1099', 'ELASTOMER.CONTRATISTA ESP/3785', 19, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(292, 'SD20', 'AVENTURA CONGELADA', 20, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(293, 'SD25', 'BLANCO FANTASIA', 20, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(294, 'SD11', 'BOSQUE DE LOS 100 ACRES', 20, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(295, 'SD16', 'CELESTE CENICIENTA', 20, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(296, 'SD06', 'GRIS COPA PISTON', 20, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(297, 'SD17', 'INVIERNO MAGICO', 20, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(298, 'SD19', 'LIBRE SOY LIBRE SOY', 20, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(299, 'SD01', 'MISKA MUSKA', 20, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(300, 'SD23', 'PASARELLA FASHION', 20, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(301, 'SD21', 'PINK BOUTIQUE', 20, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(302, 'SD07', 'POLE POSITION', 20, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(303, 'SD24', 'POM PON', 20, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(304, 'SD12', 'POTE DE MIEL', 20, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(305, 'SD08', 'RADIADOR SPRINGS', 20, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(306, 'SD02', 'ROJO MICKEY', 20, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(307, 'SD05', 'ROJO RAYO MCQUEEN', 20, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(308, 'SD14', 'ROSA ARIEL', 20, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(309, 'SD22', 'ROSA MINNIE', 20, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(310, 'SD13', 'VIOLETA RAPUNZEL', 20, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(311, '1152', 'NEPTUNO AZUL MAR', 21, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(312, '1151', 'NEPTUNO AZUL NIEBLA', 21, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(313, '1150', 'NEPTUNO BLANCO', 21, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(314, 'DSB1', 'DISNEY SATIN BASE BLANCA', 22, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(315, 'DSF1', 'DISNEY SATIN BASE FUERTE', 22, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(316, 'DSI1', 'DISNEY SATIN BASE INTENSA', 22, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(317, 'DSM1', 'DISNEY SATIN BASE MEDIA', 22, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(318, 'PL5009', 'PINTALATEX AMARILLO', 23, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(319, 'PL5019', 'PINTALATEX AMARILLO INTENSO', 23, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(320, 'PL5018', 'PINTALATEX AZUL INTENSO', 23, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(321, 'PL5000', 'PINTALATEX BLANCO', 23, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(322, 'PL5001', 'PINTALATEX BLANCO HUESO', 23, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(323, 'PL5016', 'PINTALATEX CANELA', 23, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(324, 'PL5010', 'PINTALATEX CELESTE', 23, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(325, 'PL5022', 'PINTALATEX LILA INTENSO', 23, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(326, 'PL5021', 'PINTALATEX MANDARINA INTENSO', 23, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(327, 'PL5012', 'PINTALATEX NARANJA INTENSO', 23, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(328, 'PL5013', 'PINTALATEX TERRANOVA', 23, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(329, 'PL5023', 'PINTALATEX TURQUESA PROFUNDO', 23, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(330, 'EOP1000', 'ELASTOMERICO  OBRA BASE PASTEL', 24, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(331, 'EO1000', 'ELASTOMERICO  OBRA BLANCO', 24, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(332, 'EOA1000', 'ELASTOMERICO OBRA BASE ACCENT', 24, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(333, 'EOD1000', 'ELASTOMERICO OBRA BASE DEEP', 24, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(334, 'EOT1000', 'ELASTOMERICO OBRA BASE TINT', 24, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(335, 'EO1000', 'ELASTOMERICO OBRA BLANCO', 24, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(336, 'EO1099', 'ELASTOMÉRICO OBRA COLOR ESPECIAL', 24, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(337, 'LOBP1000', 'LATEX OBRA BASE  PASTEL', 24, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(338, 'LOBP1000', 'LATEX OBRA BASE PASTEL', 24, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(339, 'LOB1000', 'LATEX OBRA BLANCO', 24, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(340, 'LOB1001', 'LATEX OBRA BLANCO ANTIGUO', 24, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(341, 'LOB1010', 'LATEX OBRA BLANCO HUESO', 24, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(342, 'OT1000', 'OBRA BLANCO TUMBADO Y GYPSUM', 24, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(343, '496', 'UNISEAL OBRA', 24, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(344, 'UOE496', 'UNISEAL OBRA ESPECIAL', 24, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(345, 'SI100', 'LATEX SUP. REPELENTE INSECTOS', 25, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(346, 'SDB300', 'BASE SUPREMO DISNEY BLANCA', 26, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(347, 'SDI300', 'BASE SUPREMO DISNEY INTENSA', 26, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(348, 'SOA1000', 'OPTIMA SATINADO BASE ACCENT', 27, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(349, 'SOD1000', 'OPTIMA SATINADO BASE DEEP', 27, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(350, 'SOP1000', 'OPTIMA SATINADO BASE PASTEL', 27, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(351, 'SOT1000', 'OPTIMA SATINADO BASE TINT', 27, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(352, 'SOU1000', 'OPTIMA SATINADO BASE ULTRA PROFUNDA', 27, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(353, 'SO1000', 'OPTIMA SATINADO BLANCO', 27, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(354, 'ELCA1000', 'ELASTOMERICO COLLECTION PRO BASE ACCENT', 28, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(355, 'ELCD1000', 'ELASTOMERICO COLLECTION PRO BASE DEEP', 28, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(356, 'ELCP1000', 'ELASTOMERICO COLLECTION PRO BASE PASTEL', 28, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(357, 'ELCT1000', 'ELASTOMERICO COLLECTION PRO BASE TINT', 28, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(358, 'ELC1000', 'ELASTOMERICO COLLECTION PRO BLANCO', 28, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(359, 'LC1000', 'LATEX COLLECTION PRO BLANCO', 28, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(360, '497', 'SELLADOR COLLECTION PRO', 28, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(361, '608', 'ANT. GRIS CLARO', 29, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(362, '606', 'ANTIC. CATERPILLAR', 29, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(363, '605', 'ANTIC. GRIS', 29, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(364, '603', 'ANTIC. NARANJA PLUS', 29, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(365, '604', 'ANTIC. VERDE', 29, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(366, '615', 'ANTICORROSIVO BLANCO', 29, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(367, 'BAB600', 'BASE ANTICORROSIVO BRILLANTE', 29, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(368, 'BAM1000', 'BASE ANTICORROSIVO MATE', 29, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(369, '1040', 'BLANCO MATE', 30, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(370, '1030', 'GRIS CLARO  MATE', 30, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(371, '1030', 'GRIS CLARO MATE', 30, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(372, '1020', 'GRIS MATE', 30, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(373, '1025', 'NARANJA MATE', 30, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(374, '1015', 'NEGRO MATE', 30, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(375, '1010', 'OXIDO ROJO MATE', 30, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(376, '1010', 'OXIDO ROJO MATE/', 30, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(377, '112872', 'ANTIOX.FERRISARIATO GL.BLANCO', 31, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(378, '112871', 'ANTIOX.FERRISARIATO GL.GRIS', 31, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(379, '112870', 'ANTIOX.FERRISARIATO GL.NEGRO', 31, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(380, '112872', 'ANTIOX.FERRISARIATO LT.BLANCO', 31, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(381, '112871', 'ANTIOX.FERRISARIATO LT.GRIS', 31, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(382, '112870', 'ANTIOX.FERRISARIATO LT.NEGRO', 31, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(383, '475', 'UNI EMPASTE', 32, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(384, '475', 'UNIEMPASTE', 32, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(385, '480', 'UNIFLEX', 33, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(386, '489', 'EMULSION FIJADORA', 34, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(387, '476', 'UNISEAL FIBRA', 34, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(388, '472', 'UNIGARD SUNSHIELD', 35, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(389, '473', 'BLOCK FILLER  FIBRA', 36, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(390, '473', 'BLOCK FILLER FIBRA', 36, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(391, '479', 'IMPERMEABILIZANTE', 37, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(392, '498', 'UNIFILL  500 FIBRA GRIS', 37, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(393, '1088', 'UNIFILL 1000 DD BLANCO', 37, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(394, '1098', 'UNIFILL 1000 DD GRIS', 37, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(395, '498', 'UNIFILL 500  FIBRA GRIS', 37, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(396, '488', 'UNIFILL 500 FIBRA BLANCO', 37, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(397, '498', 'UNIFILL 500 FIBRA GRIS', 37, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(398, '483', 'CORRECTOR ENLUCIDO SUPREMO', 38, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(399, '483', 'RESINA CORRECTOR ENLUCIDO SUPR', 38, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(400, '470', 'EMPASTE SUPREMO EXTERIOR', 39, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(401, '481', 'EMPASTE SUPREMO INTERIOR', 39, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(402, '4810', 'EMPASTE SUPREMO INTERIOR BLANCO 1000', 39, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(403, '470', 'RESINA EMP. SUP. EXTERIOR 4KG', 39, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(404, '482', 'RESINA EMPASTE SUPREMO INT', 39, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(405, 'AR200', 'ALUMINIO REFLECTIVO CAPA 2', 40, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(406, 'MA100', 'MEMBRANA ASFALTICA CAPA 1', 40, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(407, 'CCA01', 'CEMENTO DE CONTACTO ALEMAN', 41, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(408, 'U50249555', 'MasterCast 104 / 77  - 1kg', 42, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(409, 'U55318685', 'MFlow 928 GROUT 25KG 5H4', 42, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(410, 'U50570707', 'MKure 135 205', 42, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(411, 'U50655546', 'MProtect FL 600 Fisuras 3', 42, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(412, 'U50655545', 'MProtect P 105 Sellador 3', 42, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(413, 'U50494485', 'MSeal 500 Grey 25KG IP22', 42, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(414, 'U51081336', 'MSEAL 510 GRAY 25KG 5H4', 42, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(415, 'U45228588', 'MSeal 965 RM  Rollo 1.10 x 100M', 42, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(416, 'U50655571', 'MSeal C77 - 3A (FIBER) 19L IP22', 42, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(417, 'U50655578', 'MSeal C780 -10A (FIBER) 19L IP22', 42, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(418, 'U50452193', 'MSeal NP 1 gray LAN 8', 42, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(419, 'U50452194', 'MSeal NP 1 white LAN 8', 42, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(420, 'U50140998', 'Ucrete Parte 1 IF/MT/TZ+AS/UD+SR 2', 42, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(421, 'U51361441', 'Ucrete Parte 2 COMMON V2 2', 42, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(422, '50271661', 'Ucrete Pigmento Líquido Gris (0', 42, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(423, 'AMC', 'AMC AMARILLO CLARO', 43, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(424, 'AMI', 'AMI AMARILLO INTENSO', 43, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(425, 'AZC', 'AZC AZUL CLARO', 43, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(426, 'AZI', 'AZI AZUL INTENSO', 43, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(427, 'BLN', 'BLN BLANCO', 43, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(428, 'MGT', 'MGT MAGENTA', 43, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(429, 'NGR', 'NGR NEGRO', 43, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(430, 'NRJ', 'NRJ NARANJA', 43, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(431, 'OCR', 'OCR OCRE', 43, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(432, 'OXR', 'OXR OXIDO ROJO', 43, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(433, 'RJI', 'RJI ROJO INTENSO', 43, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(434, 'VRD', 'VRD VERDE', 43, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(435, 'PS1200', 'PINT.SPRAY 1200 ALTA TEMP.NEGR', 44, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(436, 'PS1300', 'PINT.SPRAY 1300 ALTA TEMP.GRIS', 44, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(437, 'PS1007', 'PINTUR.EN SPRAY 1007 BL. MATE', 44, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(438, 'PS125', 'PINTUR.EN SPRAY 125 GS PLATEAD', 44, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(439, 'PS27', 'PINTUR.EN SPRAY 27 VER TREBOL', 44, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(440, 'PS29', 'PINTUR.EN SPRAY 29 CAFE OSCURO', 44, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(441, 'PS33', 'PINTUR.EN SPRAY 33 AMAR. CREMA', 44, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(442, 'PS335', 'PINTUR.EN SPRAY 335 GRIS CLARO', 44, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(443, 'PS35', 'PINTUR.EN SPRAY 35 ORO METALIC', 44, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(444, 'PS350', 'PINTUR.EN SPRAY 350 ROJO CAOBA', 44, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(445, 'PS382', 'PINTUR.EN SPRAY 382 AZUL DUCAL', 44, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(446, 'PS39', 'PINTUR.EN SPRAY 39 GLOSS BLACK', 44, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(447, 'PS40', 'PINTUR.EN SPRAY 40 GLOSS WHITE', 44, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(448, 'PS19', 'PINTURA EN SPRAY  19 CELESTE', 44, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(449, 'PS14', 'PINTURA EN SPRAY 14 NARNAJA', 44, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(450, 'PS22', 'PINTURA EN SPRAY 22 GRIS MEDIO', 44, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(451, 'PS315', 'PINTURA EN SPRAY 315 AMAR.MAIZ', 44, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(452, 'PS328', 'PINTURA EN SPRAY 328 ROSA', 44, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(453, 'PS36', 'PINTURA EN SPRAY 36 PLATEADO', 44, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(454, 'PS360', 'PINTURA EN SPRAY 360 ROJO FUKO', 44, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(455, 'PS37', 'PINTURA EN SPRAY 37 VERDE HOJA', 44, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(456, 'PS4', 'PINTURA EN SPRAY 4 MATT BLACK', 44, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(457, 'PS6', 'PINTURA EN SPRAY 6 ROJO VIVO', 44, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(458, 'PS68', 'PINTURA EN SPRAY 68 NAR. AMAR.', 44, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(459, 'PS21', 'PINTURA EN SPRAY AZUL FRANCIA', 44, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(460, 'PS318', 'PINTURA EN SPRAY CROMADO', 44, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(461, 'PS1881', 'PINTURA EN SPRAY ORO 18K', 44, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(462, 'PS1023', 'PINTURA SPRAY 1023 AMAR.INTENS', 44, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(463, 'BPPU1', 'BROCHA PROFESIONAL UNIDAS GRIS 1\"\"', 45, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(464, 'BPPU2', 'BROCHA PROFESIONAL UNIDAS GRIS 2', 45, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(465, 'BPPU2', 'BROCHA PROFESIONAL UNIDAS GRIS 2\"\"', 45, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(466, 'BPPU4', 'BROCHA PROFESIONAL UNIDAS GRIS 4\"\"', 45, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(467, 'BPPU5', 'BROCHA PROFESIONAL UNIDAS GRIS 5\"\"', 45, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(468, 'BMPU1', 'BROCHA UNIDAS MULTIUSO GRIS 1\"\"', 45, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(469, 'BMPU2', 'BROCHA UNIDAS MULTIUSO GRIS 2', 45, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(470, 'BMPU2', 'BROCHA UNIDAS MULTIUSO GRIS 2\"\"', 45, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(471, 'BMPU3', 'BROCHA UNIDAS MULTIUSO GRIS 3\"\"', 45, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(472, 'BMPU4', 'BROCHA UNIDAS MULTIUSO GRIS 4\"\"', 45, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(473, 'BMPU5', 'BROCHA UNIDAS MULTIUSO GRIS 5\"\"', 45, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(474, 'U1806', 'CINTA ENMASCA SPRAY FLASH 90 45MX18MM', 45, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(475, 'U1757', 'FELPA ECOBLOCK 40 MICROFIBRA EXCEL 9', 45, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(476, 'U1751', 'FELPA ECOBLOCK O 40 CUBRIX REVO 9', 45, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(477, 'UFMD29G', 'FELPA POLIESTER MEDIA DENSIDAD 9 X 3/4\"\"', 45, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(478, 'UMSP', 'MANGO 4 SEMIPROFESIONAL S/MARCA', 45, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(479, 'UMSP9S', 'MANGO 9 SEMIPROFESIONAL S/MARCA', 45, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(480, 'U785', 'MANGO/VARILLA ECOBLOCK 40.9\" MPP\"', 45, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(481, 'U0785', 'MANGO/VARILLA ECOBLOCK 50', 45, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(482, 'U811', 'PLASTICO CUBRETODO 4X25 M FINO', 45, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(483, 'U1750', 'REC.ECOBLOCK 50 CUBRIX REVOLUTION 22CM', 45, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(484, 'U706', 'RODILLO BRICO O 40 ANTIGOTA 22CM C/3065', 45, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(485, '858', 'LACA ALUMINIO FINO', 46, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(486, '860', 'LACA ALUMINIO GRUESO', 46, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(487, '800', 'LACA AMARILLO OSCURO', 46, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(488, '809', 'LACA AZUL BASE', 46, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(489, '870', 'LACA BLANCO  MEZCLA', 46, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(490, '852', 'LACA BLANCO MATE', 46, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(491, '850', 'LACA BLANCO PROFUNDO', 46, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(492, '807', 'LACA GOLD TONER', 46, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(493, '812', 'LACA GOLD TONER ROJIZO', 46, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(494, '854', 'LACA NEGRO PROFUNDO', 46, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(495, '803', 'LACA OCRE', 46, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(496, '804', 'LACA ORANGE', 46, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(497, '805', 'LACA OXIDO ROJO', 46, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(498, '806', 'LACA ROJO F5RK', 46, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(499, '808', 'LACA ROJO INDIGO', 46, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(500, '810', 'LACA VERDE BASE', 46, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(501, '303', 'FONDO BLANCO', 47, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(502, '301', 'FONDO GRIS', 47, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(503, '301', 'FONDOS GRIS', 47, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(504, '5021', 'SINT. AMARILLO SECADO EXPRESS', 48, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(505, '5018', 'SINT. AZUL SECADO EXPRESS', 48, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(506, '5070', 'SINT. BLANCO SECADO EXPRESS', 48, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(507, '5074', 'SINT. NEGRO SECADO EXPRESS', 48, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(508, '5023', 'SINT. ROJO SECADO EXPRESS', 48, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(509, '998', 'MULTIPRIMER  VERDE', 49, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(510, '990', 'MULTIPRIMER GRIS', 49, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(511, '9095', 'MULTIPRIMER HIERRO NEGRO', 49, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(512, '9090', 'MULTIPRIMER PLUS', 49, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(513, '998', 'MULTIPRIMER VERDE', 49, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(514, '7111', 'BASE SINTETICO INDURA', 50, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(515, '9075', 'RESINA  TRANSPARENTE', 50, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(516, '9056', 'SINT.  ROJO F5RK', 50, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(517, '9078', 'SINT. ALUMINIO', 50, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(518, '9091', 'SINT. AMARILLO CLARO', 50, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(519, '9059', 'SINT. AZUL BASE', 50, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(520, '9070', 'SINT. BLANCO', 50, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(521, '9050', 'SINT. INDUSTRIAL  AMARILLO MEDIO', 50, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(522, '9054', 'SINT. INDUSTRIAL ORANGE', 50, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(523, '9074', 'SINT. NEGRO', 50, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(524, '9055', 'SINT. OXIDO ROJO', 50, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(525, '9060', 'SINT. PLUS  VERDE BASE', 50, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(526, '9053', 'SINT. PLUS AMARILLO OCRE', 50, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(527, '9066', 'SINT. PLUS BLANCO MATE', 50, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(528, '9058', 'SINT. PLUS MARRON', 50, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(529, '9065', 'SINT. PLUS NEGRO MATE', 50, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(530, '9081', 'SINT. ROJO MEGA', 50, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(531, '355', 'UNIPLAST', 51, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(532, '880', 'REMOVEDOR TITANIUM', 52, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(533, '450', 'RETARDADOR DE LACA', 53, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(534, '1490', 'CONVERTIDOR OXI. BASE AGUA', 54, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(535, '1490', 'CONVERTIDOR OXI.BASE AGUA', 54, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(536, '490', 'DESOX/FOSFATIZANTE ADVANCE', 54, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(537, '490', 'DESOX/FOSFATIZANTE TITANIUM', 54, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(538, 'PUID850', 'RESINA POLIESTER BICAPA', 55, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(539, 'PUCC650', 'RESINA POLIURETANO 8 A 1', 55, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29');
INSERT INTO `productos` (`id`, `cod_producto`, `descripcion`, `id_categoria`, `estado`, `created_at`, `updated_at`) VALUES
(540, 'BA00', 'ADITIVO DE EFECTO', 56, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(541, 'BA27', 'BASE  ADVANCE PERLA SG VERDE', 56, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(542, 'BA31', 'BASE ADV. VERDE BRONCE', 56, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(543, 'BA86', 'BASE ADV. XIRALLIC AZUL', 56, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(544, 'BA83', 'BASE ADV. XIRALLIC BRONCE', 56, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(545, 'BA89', 'BASE ADV. XIRALLIC COBRE', 56, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(546, 'BA91', 'BASE ADV. XIRALLIC DIAMANTE', 56, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(547, 'BA90', 'BASE ADV. XIRALLIC DORADA', 56, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(548, 'BA84', 'BASE ADV. XIRALLIC ROJO', 56, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(549, 'BA87', 'BASE ADV. XIRALLIC VERDE', 56, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(550, 'BA85', 'BASE ADV. XIRALLIC VIOLETA', 56, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(551, 'BA52', 'BASE ADV.PERLA ORANGE', 56, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(552, 'BA33', 'BASE ADV.ROJO PERMANENTE', 56, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(553, 'BA3455', 'BASE ADVAN.ALUMINIO EXTRAFINO', 56, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(554, 'BA3255', 'BASE ADVAN.MARRON LIMPIO', 56, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(555, 'BA11RS', 'BASE ADVANCE  AMARILLO INTENS', 56, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(556, 'BA12', 'BASE ADVANCE  AZUL VERDOSO', 56, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(557, 'BA45', 'BASE ADVANCE ALUM.EXTRA GRUE', 56, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(558, 'BA3955', 'BASE ADVANCE ALUMINIO BRILLA', 56, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(559, 'BA80', 'BASE ADVANCE ALUMINIO DORADO', 56, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(560, 'BA2355', 'BASE ADVANCE ALUMINIO FINO', 56, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(561, 'BA2255', 'BASE ADVANCE ALUMINIO GRUESO', 56, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(562, 'BA2155', 'BASE ADVANCE ALUMINIO MEDIO', 56, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(563, 'BA81', 'BASE ADVANCE ALUMINIO ORANGE', 56, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(564, 'BA17EL', 'BASE ADVANCE AMARILLO MEDIO', 56, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(565, 'BA04', 'BASE ADVANCE AMARILLO OCRE', 56, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(566, 'BA70', 'BASE ADVANCE AZUL', 56, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(567, 'BA06', 'BASE ADVANCE AZUL ENTONADOR', 56, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(568, 'BA37', 'BASE ADVANCE AZUL INDIGO', 56, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(569, 'BA18', 'BASE ADVANCE AZUL LAGO', 56, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(570, 'BA16', 'BASE ADVANCE AZUL PURPURA', 56, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(571, 'BA36', 'BASE ADVANCE AZUL ZAFIRO', 56, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(572, 'BA01', 'BASE ADVANCE BLANCO', 56, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(573, 'BA19', 'BASE ADVANCE GOLD TONER', 56, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(574, 'BA20', 'BASE ADVANCE GOLD TONER ROJO', 56, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(575, 'BA44', 'BASE ADVANCE MAGENTA', 56, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(576, 'BA60', 'BASE ADVANCE NARANJA TOPACIO', 56, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(577, 'BA02', 'BASE ADVANCE NEGRO', 56, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(578, 'BA69', 'BASE ADVANCE NEGRO AZABACHE', 56, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(579, 'BA53', 'BASE ADVANCE OCEAN BLUE', 56, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(580, 'BA05', 'BASE ADVANCE OXIDO ROJO', 56, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(581, 'BA25', 'BASE ADVANCE PERLA  AZUL FIN', 56, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(582, 'BA29', 'BASE ADVANCE PERLA AZUL GRUE', 56, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(583, 'BA30', 'BASE ADVANCE PERLA BLANCA FI', 56, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(584, 'BA48', 'BASE ADVANCE PERLA BLANCA GR', 56, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(585, 'BA03', 'BASE ADVANCE PERLA BLANCO MI', 56, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(586, 'BA24', 'BASE ADVANCE PERLA BRONCE', 56, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(587, 'BA50', 'BASE ADVANCE PERLA DORADA', 56, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(588, 'BA47', 'BASE ADVANCE PERLA ORO', 56, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(589, 'BA28', 'BASE ADVANCE PERLA ROJA FINA', 56, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(590, 'BA26', 'BASE ADVANCE PERLA ROJA GRUE', 56, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(591, 'BA46', 'BASE ADVANCE PERLA VIOLETA', 56, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(592, 'BA40', 'BASE ADVANCE ROJO BRONCE', 56, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(593, 'BA64', 'BASE ADVANCE ROJO FERRARI', 56, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(594, 'BA51', 'BASE ADVANCE ROJO FUERTE', 56, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(595, 'BA41', 'BASE ADVANCE ROJO MONASTRAL', 56, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(596, 'BA59', 'BASE ADVANCE ROJO RUBI', 56, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(597, 'BA68', 'BASE ADVANCE ROJO SK359', 56, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(598, 'BA07', 'BASE ADVANCE ROJO VINO TINTO', 56, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(599, 'BA54', 'BASE ADVANCE SKY BLUE', 56, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(600, 'BA09', 'BASE ADVANCE VERDE ENTONADOR', 56, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(601, 'BA08', 'BASE ADVANCE VERDE THALO', 56, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(602, 'BA15', 'BASE ADVANCE VIOLETA', 56, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(603, 'BA42', 'BASE ADVANCE.AMARILLO ENTONA', 56, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(604, 'BA74', 'CROMALUM FINO BRILLANTE', 56, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(605, 'BA73', 'CROMALUM GRUESO BRILLANTE', 56, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(606, 'BA72', 'CROMALUM MEDIO BRILLANTE', 56, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(607, 'PU10429', 'BARNIZ POLIURETANO 8 A 1', 57, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(608, 'PU10430', 'BARNIZ POLIURETANO CLIMA FRIO 8 A 1', 57, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(609, 'PU550', 'CATALIZADOR SISTEMA 8 A 1', 58, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(610, 'PU6099', 'BATEPIEDRA BASE AGUA TITANIUM', 59, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(611, 'PM1', 'PASTA MATEANTE TITANIUM', 60, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(612, 'PU3100', 'ADIT.CORRECTOR FLIP-FLOP TITAN', 61, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(613, 'PU8B', 'ADITIV.ANTICRATER TITANIUM', 61, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(614, 'PU1139', 'PROM. ADHERENCIA P\' PL.TITANIU', 61, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(615, 'PU3000', 'MASILLA RAPIDA TITANIUM', 62, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(616, 'PU040', 'ACTIVADOR WASH PRIMER TITANIUM', 63, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(617, 'PU400', 'WASH PRIMER TITANIUM', 63, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(618, 'PU9500', 'RESINA POLIURETANO 2 A 1', 64, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(619, 'PU9501', 'RESINA POLIURETANO CLIMA FRIO 2 A 1', 65, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(620, 'PU9080', 'BASE BATEPIEDRA TITANIUM', 65, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(621, 'PU9098', 'BATEPIEDRA TITANIUM/3785', 66, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(622, 'PU9098', 'BATEPIEDRA TITANIUM/946', 66, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(623, 'PU098', 'CATALIZ. BATEPIEDRA TITANIUM', 66, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(624, 'PU90155', 'BARNIZ POLIURETANO 2 A 1', 66, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(625, 'PU097', 'CATALIZADOR CLIMA FRIO SISTEMA 2 A 1', 67, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(626, 'PU095', 'CATALIZADOR SISTEMA 2 A 1', 67, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(627, 'P10', 'LIJA AL AGUA 3M # 100', 67, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(628, 'P100', 'LIJA AL AGUA 3M # 1000', 68, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(629, 'P12', 'LIJA AL AGUA 3M # 120', 68, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(630, 'P120', 'LIJA AL AGUA 3M # 1200', 68, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(631, 'P22', 'LIJA AL AGUA 3M # 220', 68, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(632, 'P24', 'LIJA AL AGUA 3M # 240', 68, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(633, 'P28', 'LIJA AL AGUA 3M # 280', 68, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(634, 'P32', 'LIJA AL AGUA 3M # 320', 68, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(635, 'P36', 'LIJA AL AGUA 3M # 360', 68, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(636, 'P60', 'LIJA AL AGUA 3M # 600', 68, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(637, 'PU076', 'CAT.PRIMER TITAN.ACAB H.S GRIS', 68, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(638, 'PU555', 'CATALIZ. PRIMER TITANIUM/', 69, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(639, 'PU760', 'PRIMER TITANIUM ACAB.H.S. GRIS', 69, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(640, 'PU650', 'PRIMER TITANIUM BEIGE', 69, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(641, 'PU651', 'PRIMER TITANIUM BLANCO', 69, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(642, 'PU654', 'PRIMER TITANIUM GRIS', 69, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(643, 'PU658', 'PRIMER TITANIUM NEGRO', 69, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(644, 'RP702', 'REDUCTOR EFECTO', 69, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(645, 'RP701', 'RESINA DE EFECTO', 70, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(646, 'PU551', 'ACELERADOR DE REACCION TITANIUM', 70, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(647, 'PU90000M', 'BARNIZ H.S. TITANIUM MATE', 71, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(648, 'PU900', 'CATALIZADOR TITANIUM', 71, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(649, 'PU5B', 'REDUC. POLIURET.AUTOM.TITANIUM', 71, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(650, 'PU5B', 'REDUC.POLIURETANO AUT.TITANIUM', 72, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(651, 'PU3880', 'REDUCT POLIURETANO', 72, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(652, 'PU3B', 'REDUCTOR  RAPIDO TITANIUM', 72, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(653, 'PU6B', 'REDUCTOR  TITANIUM UNIDAS', 72, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(654, 'PU3B', 'REDUCTOR RAPIDO TITANIUM', 72, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(655, 'TP300', 'MASILLA POLIESTER TITANIUM', 72, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(656, 'P3', 'ABRILLANTADOR TITANIUM  PASO 3', 73, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(657, 'P1', 'PULIMENTO TITANIUM PASO 1', 74, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(658, 'P2', 'PULIMENTO TITANIUM PASO 2', 74, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(659, 'TD1028', 'AMARILLO TAXI RAL 1028 POLIURETANO', 74, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(660, 'TD06', 'AZUL POLIURETANO', 75, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(661, 'TD02', 'NEGRO POLIURETANO', 75, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(662, 'PD06', 'POLIURETANO DIRECTO AZUL', 75, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(663, 'PD01', 'POLIURETANO DIRECTO BLANCO', 75, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(664, 'PD10', 'POLIURETANO DIRECTO NARANJA', 75, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(665, 'PD02', 'POLIURETANO DIRECTO NEGRO', 75, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(666, 'PD08', 'POLIURETANO DIRECTO VERDE', 75, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(667, 'K5', 'DURAKROM CLEAR COATING 1L', 75, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(668, 'K5S', 'DURAKROM CLEAR COATING EXPRESS 1L', 76, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(669, 'HARDK5', 'DURAKROM HARDENER 0.5L', 76, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(670, 'HARDK5S', 'DURAKROM HARDENER EXPRESS 0.5L', 76, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(671, 'THIK5S', 'THINNER K5  EXPRESS 0.5L', 76, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(672, 'THIK5', 'THINNER K5 1L', 76, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(673, 'PU801', 'CATALIZ.PLATINUM CLIMA FRIO', 76, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(674, '690', 'BARNIZ ALPINO', 77, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(675, '690M', 'BARNIZ ALPINO MATE', 78, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(676, '690M', 'BARNIZ ALPINO MATE/.', 78, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(677, '690', 'BARNIZ ALPINO/', 78, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(678, '590', 'BARNIZ SUPREMO', 78, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(679, '831', 'LACA BRILLANTE PLASTI UNIVERSAL', 78, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(680, '821', 'LACA BRILLO PROFUNDO', 79, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(681, '830', 'LACA TRANSPARENTE MATE', 79, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(682, '840', 'LACA SELLADOR', 80, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(683, '873', 'LACA SELLADOR BLANCO', 81, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(684, '874', 'LACA SELLADOR CAOBA', 81, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(685, '875', 'LACA SELLADOR NEGRO', 81, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(686, '876', 'LACA SELLADOR OCRE', 81, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(687, '872', 'LACA SELLADOR OXIDO ROJO', 81, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(688, '878', 'LACA SELLADOR WENGUE', 81, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(689, '874', 'LACASELLADOR CAOBA', 81, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(690, 'NC420', 'SELLADOR PARA MDF/RH', 81, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(691, 'NC420', 'SELLADOR PARA MDF/RH-5 GLNS', 81, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(692, '877', 'PRESERVANTE PARA MADERA KL3', 81, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(693, '84090', 'A.S. FONDO  CATALIZ. BLANCO', 82, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(694, '84090', 'A.S. FONDO BLANCO CATALIZADO', 83, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(695, '84090', 'A.S. FONDO CATALIZADO BLANCO', 83, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(696, '84050', 'A.S. FONDO CATALIZADO CAFE', 83, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(697, '84040', 'A.S. FONDO CATALIZADO ROJO', 83, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(698, '84050', 'A.S.FONDO CATALIZADO CAFE', 83, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(699, '84040', 'A.S.FONDO CATALIZADO ROJO', 83, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(700, '84100BO', 'A.S. SELLADOR BAJO OLOR', 83, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(701, '8540', 'A.S.  SEMI MATE EXTERIOR', 84, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(702, '8519', 'A.S. ALTO BRILLO EXTERIOR', 85, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(703, '8419', 'A.S. BRILLANTE', 85, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(704, '8415BO', 'A.S. MATE   BAJO OLOR', 85, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(705, '8415BO', 'A.S. MATE  BAJO OLOR', 85, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(706, '8405BO', 'AS SEMIMATE  BAJO OLOR', 85, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(707, '8405BO', 'AS SEMIMATE BAJO OLOR', 85, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(708, '8413', 'A.S BLANCO BRILL.NO AMARILLABL', 85, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(709, '8413M', 'A.S BLANCO MATE NO AMARILLABLE', 86, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(710, '8420', 'A.S. BLANCO', 86, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(711, '8413', 'A.S. BLANCO BRILL.NO AMARILLAB', 86, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(712, '8420M', 'A.S. BLANCO MATE', 86, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(713, '8422', 'A.S. CAOBA', 86, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(714, '8855', 'A.S. CARAMELO', 86, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(715, '8856', 'A.S. MIEL', 86, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(716, '8424', 'A.S. NEGRO', 86, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(717, '8429', 'A.S. NOGAL', 86, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(718, '8858', 'A.S. ROJO INGLES', 86, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(719, '8805', 'A.S. VINO TINTO', 86, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(720, 'DC057', 'CAT. A.S. PARA EXTERIOR', 86, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(721, 'DC057', 'CATAL.A.S. PARA EXTERIOR/200CM', 87, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(722, 'DC017', 'CATAL.ALTOS SOLIDOS/200CM', 87, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(723, 'DC017', 'CATALIZADOR ALTOS SOLIDOS', 87, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(724, 'DC027', 'CATALIZADOR CLIMA FRIO', 87, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(725, '824AC', 'UNITINTE AMARILLO', 87, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(726, '835AC', 'UNITINTE AZUL', 88, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(727, '832AC', 'UNITINTE BURDEO', 88, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(728, '832AC', 'UNITINTE BURDEOS', 88, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(729, '828AC', 'UNITINTE CAFE', 88, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(730, '838AC', 'UNITINTE CARAMELO', 88, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(731, '823AC', 'UNITINTE CEDRO', 88, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(732, '829AC', 'UNITINTE CHERR', 88, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(733, '829AC', 'UNITINTE CHERRY', 88, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(734, '833AC', 'UNITINTE COCO', 88, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(735, '827AC', 'UNITINTE NEGRO', 88, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(736, '825AC', 'UNITINTE PARDO', 88, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(737, '826AC', 'UNITINTE ROJO', 88, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(738, '834AC', 'UNITINTE WENGUE', 88, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(739, 'PU4028', 'CATALIZ. PRIMER PARA MADERA RESINOSA', 88, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(740, 'PU4027', 'PRIMER PARA MADERA RESINOSA', 89, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(741, 'DT446', 'DILUY. POLIURETANO MADERA', 89, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(742, 'TM406', 'THINNER POLIURETANO MADERA', 90, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(743, '385', 'UNIPLAST MADERA', 90, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(744, '403', 'DILUYENTE UNIVERSAL', 91, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(745, '1170', 'REDUCTOR  EPOXICO', 92, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(746, '401', 'REDUCTOR ALQUIDICO', 92, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(747, '1195', 'REDUCTOR HORNEABLE', 92, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(748, '1198', 'REDUCTOR POLIURETANO', 92, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(749, '1437', 'PRIMER EPOXICO GRIS', 92, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(750, '1431', 'PRIMER EPOXICO OXIDO ROJO', 93, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(751, '1436', 'ZINC RICH EPOXI PRIMER', 93, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(752, '4050', 'BASE ACCENT POLIAMIDA', 93, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(753, '4999', 'EPOX.GENER.POLIAMIDA ESPEC /GL', 94, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(754, '4040', 'EPOXICO BLANCO HORNEABLE', 94, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(755, '4032', 'EPOXICO POLIAMIDA BLANCO', 94, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(756, '4033', 'EPOXICO POLIAMIDA GRIS', 94, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(757, '4000', 'BASE ACCENT UNIMASTIC', 94, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(758, 'INT999', 'INTERSWIFT 6600 NEGRO', 95, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(759, '4021', 'UNIMASTIC  ROJO (GALON)', 95, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(760, '4020', 'UNIMASTIC BLANCO', 95, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(761, '7800', 'UNICOALTAR EPOXICO NEGRO', 95, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(762, '8019', 'ESM. HORNEABLE LILA QUICORNAC', 96, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(763, '8092', 'ESM.HORN AZUL FUTURC FILARET', 97, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(764, '8099', 'ESM.HORN. GENERICO', 97, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(765, '8096', 'ESM.HORNEABLE AMARILLO BORJA', 97, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(766, '8097', 'ESM.HORNEABLE AZUL VALVOLINE', 97, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(767, '8091', 'ESM.HORNEABLE BLANCO', 97, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(768, '1800', 'POLIURETANO BLANCO / GALON', 97, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(769, '1899', 'POLIURETANO GENE. ESPECIAL', 98, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(770, '9099', 'ACRYL.ESTIRENADO GENERICO ESP.', 98, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(771, '9099', 'ACRYL.ESTIRENADO GENERICO/CN', 99, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(772, '6013', 'ALQ. MODIFICADO VERDE MAQUINA', 99, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(773, '554', 'ESMALTE  AMARILLO EXOFRUIT', 100, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(774, '568', 'ESMALTE AZUL BIOFACTOR', 100, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(775, '548', 'ESMALTE AZUL GULF', 100, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(776, '553', 'ESMALTE BLANCO EXOFRUIT', 100, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(777, '596', 'ESMALTE GRIS PERLA', 100, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(778, '557', 'ESMALTE NARANJA GULF', 100, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(779, '610', 'ESMALTE NARANJA UBX', 100, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(780, '902', 'ESMALTE ROJO BERMELLON', 100, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(781, '555', 'ESMALTE ROJO TOTAL', 100, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(782, '539', 'ESMALTE UNIGAS NARANJA COSTA/T', 100, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(783, 'ESM599', 'MARINE ENAMEL COLOR ESPECIAL', 100, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(784, 'ESM1499', 'MARINE PRIMER GENERICO/3785GLS', 100, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(785, 'ESM1499', 'MARINE PRIMER GENERICO/50 GLS', 100, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(786, '5030', 'UNITHERM ALUMINIO', 100, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(787, '5032', 'UNITHERM ALUMINIO  600', 101, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(788, '1999', 'TRAFICO ACRIL', 101, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(789, '1123', 'TRAFICO ACRILICO NEGRO', 102, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(790, '1102', 'TRAFICO AMARILLO TIPO I BASE AGUA', 102, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(791, '1121', 'TRAFICO AMARILLO TIPO II BASE SOLV.', 102, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(792, '1128', 'TRAFICO AZUL DISCAPACIDAD', 102, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(793, '1120', 'TRAFICO BLANCO TIPO II BASE SOLV.', 102, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(794, '5010', 'ANCLA ANTIFOULING', 102, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(795, '5020', 'ANT.AUTOPULIMENT VINIL. ROJO', 103, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(796, '460', 'UNITOL', 103, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(797, 'DC009', 'CAT.EPOX.POLIAMIDA 4032/4035', 104, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(798, 'DC020', 'CATAL.EPOX.BLANCO HORN.', 105, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(799, 'DC015', 'CATALIZ. COALTAR EPOXICO 7800', 105, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(800, 'DC003', 'CATALIZ. POLIURET. ACRILICO', 105, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(801, 'DC001', 'CATALIZ.EPOXICO  UNIMASTIC', 105, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(802, 'DC010', 'CATALIZADOR PRIMER EPOXICO', 105, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(803, 'DC070', 'CATALIZ. UNIPOX BASE AGUA', 105, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(804, '7030', 'UNIPOX BASE AGUA BLANCO', 106, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(805, '4599', 'BASE AUTONIVELANTE ESPECIA/2GL', 106, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(806, '4511', 'EPOX.AUTONIVELANTE GRIS/2GLS', 107, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(807, '4535', 'UNIFLOOR 200 GRIS RAL 7035', 107, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(808, 'BL', 'TINTE AZUL INDUSTRIAL', 107, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(809, 'MAG', 'TINTE MAGENTA INDUSTRIAL', 108, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(810, 'ORA', 'TINTE NARANJA INDUSTRIAL', 108, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(811, 'OXY', 'TINTE OCRE INDUSTRIAL', 108, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(812, 'GRN', 'TINTE VERDE INDUSTRIAL', 108, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(813, 'INT204', 'INTERSEAL 670 HS WHITE', 108, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(814, 'INT203', 'INTERTUF 203 BRONCE', 109, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(815, 'INT902', 'INTERTHANE 990 BLACK', 109, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(816, 'INTC910', 'INTERTHANE 990 COMP. B', 110, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(817, 'INT901', 'INTERTHANE 990 RAL 5003', 110, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(818, 'INT900', 'INTERTHANE 990 WHITE', 110, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(819, 'ADAPMASTRO', 'ADAPTADORES 5/8                                 ', 110, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(820, 'ZB10', 'BOINA ESPU PRETA SUPER MACIA7\"\"', 111, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(821, 'ZB10', 'BOINA ESPUMA BRANCA MACIA7PULG', 111, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(822, 'BWB', 'BROCHA WILSON C. BLANCO 5', 111, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(823, 'BRO13', 'BROCHAS WILSON 2\" C. BLANCO\"', 111, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(824, 'FERRICOM', 'COMPRESOR 24P 18 LBS DE 110V', 111, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(825, 'ZP10', 'FELPA/PAÑO HILO BLANCA8\"DOSCAR\"', 111, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(826, 'DM9111', 'CUADRO ACUARELA Y PLUMILLA', 111, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(827, 'DM1000', 'COMPRESOR SSR 1251 AACC7 32HP', 112, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(828, 'RODILLO001', 'RODILLO PENTRILO                              ', 113, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(829, 'BOLS003', 'BOLSO PROMOCIÓN', 113, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(830, 'DM804', 'CAMISETA CUELLO REDONDO UNIDAS', 114, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(831, 'CARS0', 'KIT ADHESIVO-PLANTILLA CARS 02', 114, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(832, 'FROZEN0', 'KIT ADHESIVO-PLANTILLA FROZEN-02', 114, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(833, 'MICKEY0', 'KIT ADHESIVO-PLANTILLA MICKEY 01', 114, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(834, 'POOH0', 'KIT ADHESIVO-PLANTILLA POOH 02', 114, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(835, '998', 'TAMBOR VACIO BOCA ANCHA 355G', 114, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(836, '997', 'TAMBORES METALICOS DE 55 GLS', 115, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(837, 'CLR306', 'TAPA DISPENSADORA-ENVIROBASE', 115, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(838, '830010', 'TAPA GALON PERFITALL MIXING MA', 116, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(839, '830007', 'TAPA LITRO PERFITALL MIXING MA', 117, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(840, '820010', 'TAPAS PARA GALONES PSL3T 5UNI.', 117, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(841, '820007', 'TAPAS PARA LITROS PSLIT 10U. C', 117, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(842, 'C19', 'MICROESFERAS TIPO DROP On', 117, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(843, 'VAP1244', 'RESINA ALQUIDICAS', 118, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(844, 'BRO9717', 'BROCHA PALETINA TRIMA S71 VELOUREX 75 MM', 119, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(845, 'BPBR', 'BROCHA PEPE C.ROJO 6\"\"', 120, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(846, 'TM05', 'TANQUE METALICO 55 GL', 120, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(847, 'LHU', 'LIJA DE HIERRO FANDELI UNION 3 #36', 121, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(848, 'ALF18', 'LIJA FANDELI AGUA #180', 122, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(849, 'ALF24', 'LIJA FANDELI AGUA #240', 122, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(850, 'ESPO1751', 'ESPONJA RECAMB ECO 40 CUBRIX REVOL 9\"         \"', 122, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29'),
(851, 'UPM', 'PASTA MATEANTE EN GRAMOS                     ', 123, 1, '2022-01-19 20:41:29', '2022-01-19 20:41:29');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payload` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('fmwcIGa6QnyX1O2QWIQrgda74Xfu48on56zSWJhu', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:96.0) Gecko/20100101 Firefox/96.0', 'YTo2OntzOjY6Il90b2tlbiI7czo0MDoiV2FDbGhPRFRKcEJzZVZnWWtHRng0S20wVUFidnVaekc5Z2xSQ0taVSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9tb3ZpbWllbnRvIjt9czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTtzOjE3OiJwYXNzd29yZF9oYXNoX3dlYiI7czo2MDoiJDJ5JDEwJDkySVhVTnBrak8wck9RNWJ5TWkuWWU0b0tvRWEzUm85bGxDLy5vZy9hdDIudWhlV0cvaWdpIjtzOjIxOiJwYXNzd29yZF9oYXNoX3NhbmN0dW0iO3M6NjA6IiQyeSQxMCQ5MklYVU5wa2pPMHJPUTVieU1pLlllNG9Lb0VhM1JvOWxsQy8ub2cvYXQyLnVoZVdHL2lnaSI7fQ==', 1643130686),
('jJodyfGWVd3AiI1kjXaKLGYCaAY0pBVMDXURkhwy', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:96.0) Gecko/20100101 Firefox/96.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNXg3SkhJNFZHejBzcUNsRlhmQTlnUHdXUkJaaHowUTVjbWQwOHpFUiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9yZWdpc3RlciI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1643125936),
('nlbfGdAY5wjhaoLa9KVeW8vwRcCF2hs0TdQFZwcP', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:96.0) Gecko/20100101 Firefox/96.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZGRvVkdaSGg2d0p6VFNqY2ZzWHFIZVZlc2wyZFVIRHJoY0pLMU1GNiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9yZWdpc3RlciI7fX0=', 1643250302),
('YqxPCoy8Ey0jR2DWU1W68Z344EbSBCOOjOfaBYSh', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:96.0) Gecko/20100101 Firefox/96.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibnFuV0NZYVAzNjJqYWJZbk9GNnhPUlBweFBEZGNzUmVZV0VwSmpKSiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1643122041);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_movimientos`
--

CREATE TABLE `tipo_movimientos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `descripcion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `accion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `tipo_movimientos`
--

INSERT INTO `tipo_movimientos` (`id`, `descripcion`, `accion`, `estado`, `created_at`, `updated_at`) VALUES
(1, 'TRASPASO DE BODEGA', '+', 1, '2022-01-20 01:42:15', '2022-01-20 01:42:15'),
(2, 'PRODUCION', '+', 1, '2022-01-20 01:42:15', '2022-01-20 01:42:15'),
(3, 'DESAPACHO', '-', 1, '2022-01-20 01:42:15', '2022-01-20 01:42:15'),
(4, 'TRASPASO A BODEGA', '-', 1, '2022-01-20 01:42:15', '2022-01-20 01:42:15'),
(5, 'TRASPASO COLORES ESPECIALES', '-', 1, '2022-01-20 01:42:15', '2022-01-20 01:42:15');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_type` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `two_factor_secret` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `two_factor_recovery_codes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `current_team_id` bigint(20) UNSIGNED DEFAULT NULL,
  `profile_photo_path` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `user_type`, `two_factor_secret`, `two_factor_recovery_codes`, `remember_token`, `current_team_id`, `profile_photo_path`, `created_at`, `updated_at`) VALUES
(1, 'Trudie Schinner Jr.', 'angeline71@example.org', '2022-01-20 01:42:14', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'A', NULL, NULL, 'jI4Pl41Qi69fW5JQP2AJQfwU328xFQRVghoj9Oo5YIgaX0rct758xH3D6XKJ', NULL, NULL, '2022-01-20 01:42:14', '2022-01-20 01:42:14'),
(2, 'Abigale Weber', 'lisa83@example.net', '2022-01-20 01:42:14', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'M', NULL, NULL, 'UFda0La9itMk5TEcz4CbvhpxKwz1IgCRCnJ6ohNjtrN9QqGUh4zz36uTRyKI', NULL, NULL, '2022-01-20 01:42:15', '2022-01-20 01:42:15'),
(3, 'Danika Gleason IV', 'fbaumbach@example.org', '2022-01-20 01:42:14', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'A', NULL, NULL, 'iZ3KjeNmwz', NULL, NULL, '2022-01-20 01:42:15', '2022-01-20 01:42:15'),
(4, 'Mr. Kamron Mueller II', 'hessel.kenyatta@example.com', '2022-01-20 01:42:14', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'M', NULL, NULL, 'oX6fmXtqDq', NULL, NULL, '2022-01-20 01:42:15', '2022-01-20 01:42:15'),
(5, 'Amir Waters', 'frida29@example.org', '2022-01-20 01:42:14', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'A', NULL, NULL, 'n9TB7ZikQt', NULL, NULL, '2022-01-20 01:42:15', '2022-01-20 01:42:15'),
(6, 'Shemar Cartwright', 'joanie.runte@example.net', '2022-01-20 01:42:14', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'M', NULL, NULL, 'VBc3BxFGb4', NULL, NULL, '2022-01-20 01:42:15', '2022-01-20 01:42:15'),
(7, 'Mr. Wilber Maggio', 'rosanna.morar@example.com', '2022-01-20 01:42:14', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'A', NULL, NULL, 'C0QMxaJum1', NULL, NULL, '2022-01-20 01:42:15', '2022-01-20 01:42:15'),
(8, 'Prof. Julio Sipes Sr.', 'rsmitham@example.com', '2022-01-20 01:42:14', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'M', NULL, NULL, '2zlcQFxzFy', NULL, NULL, '2022-01-20 01:42:15', '2022-01-20 01:42:15'),
(9, 'Prof. Delbert Waelchi IV', 'tremayne62@example.net', '2022-01-20 01:42:14', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'A', NULL, NULL, 'gWbg8CcbrS', NULL, NULL, '2022-01-20 01:42:15', '2022-01-20 01:42:15'),
(10, 'Ms. Asia Medhurst III', 'hudson.donato@example.com', '2022-01-20 01:42:14', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'M', NULL, NULL, '7CTnFZ4jDw', NULL, NULL, '2022-01-20 01:42:15', '2022-01-20 01:42:15'),
(11, 'Jordan', 'jrodriguez@gmail.com', NULL, '$2y$10$/HKKKOkzikuHeRyW6XqlQ.IVvF6GaWoBHoHn3JPnDnflNmVVk/Pce', NULL, NULL, NULL, NULL, NULL, NULL, '2022-01-25 21:04:58', '2022-01-25 21:04:58');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `bodegas`
--
ALTER TABLE `bodegas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indices de la tabla `localidades`
--
ALTER TABLE `localidades`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `medidas`
--
ALTER TABLE `medidas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `movimiento_inventarios`
--
ALTER TABLE `movimiento_inventarios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `movimiento_inventarios_id_producto_foreign` (`id_producto`),
  ADD KEY `movimiento_inventarios_id_medida_foreign` (`id_medida`),
  ADD KEY `movimiento_inventarios_id_bodega_foreign` (`id_bodega`),
  ADD KEY `movimiento_inventarios_id_localidad_foreign` (`id_localidad`),
  ADD KEY `movimiento_inventarios_id_tipo_movimiento_foreign` (`id_tipo_movimiento`),
  ADD KEY `movimiento_inventarios_nivel_foreign` (`nivel`),
  ADD KEY `movimiento_inventarios_id_usuario_ing_foreign` (`id_usuario_ing`);

--
-- Indices de la tabla `niveles`
--
ALTER TABLE `niveles`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indices de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `productos_id_categoria_foreign` (`id_categoria`);

--
-- Indices de la tabla `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indices de la tabla `tipo_movimientos`
--
ALTER TABLE `tipo_movimientos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `bodegas`
--
ALTER TABLE `bodegas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=124;

--
-- AUTO_INCREMENT de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `localidades`
--
ALTER TABLE `localidades`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `medidas`
--
ALTER TABLE `medidas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=185;

--
-- AUTO_INCREMENT de la tabla `movimiento_inventarios`
--
ALTER TABLE `movimiento_inventarios`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT de la tabla `niveles`
--
ALTER TABLE `niveles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=852;

--
-- AUTO_INCREMENT de la tabla `tipo_movimientos`
--
ALTER TABLE `tipo_movimientos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `movimiento_inventarios`
--
ALTER TABLE `movimiento_inventarios`
  ADD CONSTRAINT `movimiento_inventarios_id_bodega_foreign` FOREIGN KEY (`id_bodega`) REFERENCES `bodegas` (`id`),
  ADD CONSTRAINT `movimiento_inventarios_id_localidad_foreign` FOREIGN KEY (`id_localidad`) REFERENCES `localidades` (`id`),
  ADD CONSTRAINT `movimiento_inventarios_id_medida_foreign` FOREIGN KEY (`id_medida`) REFERENCES `medidas` (`id`),
  ADD CONSTRAINT `movimiento_inventarios_id_producto_foreign` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id`),
  ADD CONSTRAINT `movimiento_inventarios_id_tipo_movimiento_foreign` FOREIGN KEY (`id_tipo_movimiento`) REFERENCES `tipo_movimientos` (`id`),
  ADD CONSTRAINT `movimiento_inventarios_id_usuario_ing_foreign` FOREIGN KEY (`id_usuario_ing`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `movimiento_inventarios_nivel_foreign` FOREIGN KEY (`nivel`) REFERENCES `niveles` (`id`);

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `productos_id_categoria_foreign` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
