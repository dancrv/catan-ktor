-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 10-02-2025 a las 17:37:12
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `catan`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `almacenrecursos`
--

CREATE TABLE `almacenrecursos` (
  `id` int(11) NOT NULL,
  `id_jugador` int(11) NOT NULL,
  `madera` int(11) DEFAULT 0,
  `trigo` int(11) DEFAULT 0,
  `carbon` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `almacenrecursos`
--

INSERT INTO `almacenrecursos` (`id`, `id_jugador`, `madera`, `trigo`, `carbon`) VALUES
(1, 1, 397, 237, 353),
(2, 1, 397, 237, 353),
(3, 1, 397, 237, 353),
(4, 1, 262, 232, 287),
(5, 1, 221, 212, 250),
(6, 1, 221, 212, 250),
(7, 1, 221, 212, 250),
(8, 1, 221, 212, 250),
(9, 1, 221, 212, 250),
(10, 1, 221, 212, 250),
(11, 1, 221, 212, 250),
(12, 1, 221, 212, 250),
(13, 2, 82, 95, 124),
(14, 2, 82, 95, 124),
(15, 2, 82, 95, 124),
(16, 2, 82, 95, 124),
(17, 2, 82, 95, 124),
(18, 2, 61, 21, 54),
(19, 2, 61, 21, 54),
(20, 2, 61, 21, 54),
(21, 2, 0, 0, 0),
(22, 2, 0, 0, 0),
(23, 3, 56, 35, 21),
(24, 3, 0, 0, 0),
(25, 3, 0, 0, 0),
(26, 3, 0, 0, 0),
(27, 1, 194, 191, 220),
(28, 1, 194, 191, 220),
(29, 1, 168, 168, 200),
(30, 1, 136, 136, 184),
(31, 1, 102, 116, 150),
(32, 1, 102, 116, 150),
(33, 1, 102, 116, 150),
(34, 1, 102, 116, 150),
(35, 1, 102, 116, 150),
(36, 1, 102, 116, 150),
(37, 1, 102, 116, 150),
(38, 1, 102, 116, 150),
(39, 1, 102, 116, 150),
(40, 1, 78, 94, 114),
(41, 1, 54, 70, 86),
(42, 1, 20, 50, 29),
(43, 1, 0, 0, 0),
(44, 2, 0, 0, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `casillas`
--

CREATE TABLE `casillas` (
  `id` int(11) NOT NULL,
  `id_partida` int(11) NOT NULL,
  `recurso` enum('MADERA','TRIGO','CARBON') NOT NULL,
  `valor_dado` int(11) DEFAULT NULL,
  `propietario` enum('JUGADOR','SERVIDOR','LIBRE') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `casillas`
--

INSERT INTO `casillas` (`id`, `id_partida`, `recurso`, `valor_dado`, `propietario`) VALUES
(1, 1, 'CARBON', 1, 'JUGADOR'),
(2, 1, 'CARBON', 1, 'SERVIDOR'),
(3, 1, 'CARBON', 2, 'JUGADOR'),
(4, 1, 'CARBON', 3, 'SERVIDOR'),
(5, 1, 'MADERA', 3, 'JUGADOR'),
(6, 1, 'CARBON', 4, 'JUGADOR'),
(7, 1, 'TRIGO', 1, 'JUGADOR'),
(8, 1, 'CARBON', 6, 'SERVIDOR'),
(9, 1, 'TRIGO', 2, 'JUGADOR'),
(10, 1, 'TRIGO', 5, 'SERVIDOR'),
(11, 1, 'TRIGO', 2, 'SERVIDOR'),
(12, 1, 'TRIGO', 6, 'SERVIDOR'),
(13, 2, 'MADERA', 5, 'LIBRE'),
(14, 2, 'MADERA', 4, 'LIBRE'),
(15, 2, 'MADERA', 4, 'LIBRE'),
(16, 2, 'MADERA', 5, 'LIBRE'),
(17, 2, 'MADERA', 4, 'LIBRE'),
(18, 2, 'TRIGO', 1, 'LIBRE'),
(19, 2, 'CARBON', 6, 'LIBRE'),
(20, 2, 'MADERA', 4, 'LIBRE'),
(21, 2, 'TRIGO', 1, 'LIBRE'),
(22, 2, 'MADERA', 2, 'LIBRE'),
(23, 2, 'CARBON', 4, 'LIBRE'),
(24, 2, 'MADERA', 5, 'LIBRE'),
(25, 3, 'CARBON', 2, 'SERVIDOR'),
(26, 3, 'TRIGO', 6, 'SERVIDOR'),
(27, 3, 'CARBON', 4, 'JUGADOR'),
(28, 3, 'MADERA', 3, 'SERVIDOR'),
(29, 3, 'TRIGO', 1, 'JUGADOR'),
(30, 3, 'TRIGO', 6, 'SERVIDOR'),
(31, 3, 'MADERA', 5, 'JUGADOR'),
(32, 3, 'CARBON', 5, 'JUGADOR'),
(33, 3, 'TRIGO', 5, 'SERVIDOR'),
(34, 3, 'MADERA', 3, 'JUGADOR'),
(35, 3, 'MADERA', 6, 'JUGADOR'),
(36, 3, 'TRIGO', 6, 'SERVIDOR'),
(37, 4, 'MADERA', 4, 'SERVIDOR'),
(38, 4, 'MADERA', 4, 'JUGADOR'),
(39, 4, 'TRIGO', 6, 'SERVIDOR'),
(40, 4, 'CARBON', 5, 'JUGADOR'),
(41, 4, 'TRIGO', 6, 'SERVIDOR'),
(42, 4, 'MADERA', 6, 'SERVIDOR'),
(43, 4, 'CARBON', 2, 'JUGADOR'),
(44, 4, 'TRIGO', 6, 'JUGADOR'),
(45, 4, 'CARBON', 1, 'SERVIDOR'),
(46, 4, 'MADERA', 4, 'SERVIDOR'),
(47, 4, 'MADERA', 5, 'JUGADOR'),
(48, 4, 'TRIGO', 1, 'JUGADOR'),
(49, 5, 'MADERA', 1, 'LIBRE'),
(50, 5, 'TRIGO', 5, 'LIBRE'),
(51, 5, 'MADERA', 3, 'LIBRE'),
(52, 5, 'TRIGO', 1, 'LIBRE'),
(53, 5, 'MADERA', 5, 'LIBRE'),
(54, 5, 'MADERA', 4, 'LIBRE'),
(55, 5, 'MADERA', 2, 'LIBRE'),
(56, 5, 'CARBON', 3, 'LIBRE'),
(57, 5, 'CARBON', 3, 'LIBRE'),
(58, 5, 'MADERA', 3, 'LIBRE'),
(59, 5, 'TRIGO', 3, 'LIBRE'),
(60, 5, 'TRIGO', 5, 'LIBRE'),
(61, 6, 'TRIGO', 4, 'SERVIDOR'),
(62, 6, 'CARBON', 2, 'JUGADOR'),
(63, 6, 'TRIGO', 3, 'JUGADOR'),
(64, 6, 'CARBON', 4, 'LIBRE'),
(65, 6, 'TRIGO', 4, 'SERVIDOR'),
(66, 6, 'MADERA', 5, 'SERVIDOR'),
(67, 6, 'MADERA', 1, 'JUGADOR'),
(68, 6, 'CARBON', 5, 'JUGADOR'),
(69, 6, 'CARBON', 2, 'LIBRE'),
(70, 6, 'MADERA', 6, 'SERVIDOR'),
(71, 6, 'CARBON', 3, 'LIBRE'),
(72, 6, 'TRIGO', 2, 'LIBRE'),
(73, 7, 'MADERA', 1, 'LIBRE'),
(74, 7, 'CARBON', 4, 'LIBRE'),
(75, 7, 'MADERA', 3, 'LIBRE'),
(76, 7, 'CARBON', 3, 'LIBRE'),
(77, 7, 'CARBON', 3, 'LIBRE'),
(78, 7, 'TRIGO', 4, 'LIBRE'),
(79, 7, 'CARBON', 1, 'LIBRE'),
(80, 7, 'TRIGO', 6, 'LIBRE'),
(81, 7, 'CARBON', 2, 'LIBRE'),
(82, 7, 'TRIGO', 2, 'LIBRE'),
(83, 7, 'TRIGO', 5, 'LIBRE'),
(84, 7, 'TRIGO', 4, 'LIBRE'),
(85, 8, 'CARBON', 4, 'LIBRE'),
(86, 8, 'MADERA', 6, 'LIBRE'),
(87, 8, 'TRIGO', 6, 'SERVIDOR'),
(88, 8, 'MADERA', 6, 'LIBRE'),
(89, 8, 'MADERA', 1, 'LIBRE'),
(90, 8, 'MADERA', 3, 'JUGADOR'),
(91, 8, 'CARBON', 6, 'JUGADOR'),
(92, 8, 'MADERA', 2, 'JUGADOR'),
(93, 8, 'TRIGO', 5, 'SERVIDOR'),
(94, 8, 'CARBON', 6, 'SERVIDOR'),
(95, 8, 'MADERA', 5, 'LIBRE'),
(96, 8, 'MADERA', 6, 'LIBRE'),
(97, 9, 'CARBON', 5, 'LIBRE'),
(98, 9, 'CARBON', 2, 'LIBRE'),
(99, 9, 'MADERA', 5, 'LIBRE'),
(100, 9, 'TRIGO', 5, 'LIBRE'),
(101, 9, 'MADERA', 2, 'LIBRE'),
(102, 9, 'MADERA', 6, 'LIBRE'),
(103, 9, 'MADERA', 2, 'LIBRE'),
(104, 9, 'CARBON', 5, 'LIBRE'),
(105, 9, 'MADERA', 4, 'LIBRE'),
(106, 9, 'MADERA', 1, 'LIBRE'),
(107, 9, 'CARBON', 5, 'LIBRE'),
(108, 9, 'CARBON', 3, 'LIBRE'),
(109, 10, 'TRIGO', 6, 'LIBRE'),
(110, 10, 'TRIGO', 4, 'LIBRE'),
(111, 10, 'TRIGO', 4, 'LIBRE'),
(112, 10, 'CARBON', 3, 'LIBRE'),
(113, 10, 'CARBON', 2, 'LIBRE'),
(114, 10, 'MADERA', 1, 'LIBRE'),
(115, 10, 'CARBON', 6, 'LIBRE'),
(116, 10, 'CARBON', 2, 'LIBRE'),
(117, 10, 'TRIGO', 3, 'LIBRE'),
(118, 10, 'TRIGO', 5, 'LIBRE'),
(119, 10, 'MADERA', 6, 'LIBRE'),
(120, 10, 'TRIGO', 1, 'LIBRE'),
(121, 11, 'MADERA', 5, 'LIBRE'),
(122, 11, 'TRIGO', 2, 'LIBRE'),
(123, 11, 'TRIGO', 5, 'LIBRE'),
(124, 11, 'TRIGO', 6, 'LIBRE'),
(125, 11, 'CARBON', 5, 'LIBRE'),
(126, 11, 'TRIGO', 3, 'LIBRE'),
(127, 11, 'TRIGO', 1, 'LIBRE'),
(128, 11, 'CARBON', 3, 'LIBRE'),
(129, 11, 'CARBON', 6, 'LIBRE'),
(130, 11, 'MADERA', 2, 'LIBRE'),
(131, 11, 'MADERA', 4, 'LIBRE'),
(132, 11, 'CARBON', 6, 'LIBRE'),
(133, 12, 'TRIGO', 4, 'SERVIDOR'),
(134, 12, 'MADERA', 3, 'SERVIDOR'),
(135, 12, 'CARBON', 5, 'SERVIDOR'),
(136, 12, 'MADERA', 5, 'JUGADOR'),
(137, 12, 'CARBON', 3, 'JUGADOR'),
(138, 12, 'MADERA', 5, 'SERVIDOR'),
(139, 12, 'CARBON', 4, 'SERVIDOR'),
(140, 12, 'MADERA', 4, 'SERVIDOR'),
(141, 12, 'TRIGO', 3, 'JUGADOR'),
(142, 12, 'TRIGO', 6, 'JUGADOR'),
(143, 12, 'CARBON', 5, 'JUGADOR'),
(144, 12, 'MADERA', 4, 'JUGADOR'),
(145, 13, 'TRIGO', 4, 'LIBRE'),
(146, 13, 'CARBON', 3, 'LIBRE'),
(147, 13, 'TRIGO', 6, 'LIBRE'),
(148, 13, 'CARBON', 5, 'LIBRE'),
(149, 13, 'TRIGO', 4, 'LIBRE'),
(150, 13, 'TRIGO', 1, 'LIBRE'),
(151, 13, 'MADERA', 1, 'LIBRE'),
(152, 13, 'CARBON', 6, 'LIBRE'),
(153, 13, 'CARBON', 6, 'LIBRE'),
(154, 13, 'CARBON', 4, 'LIBRE'),
(155, 13, 'TRIGO', 3, 'LIBRE'),
(156, 13, 'MADERA', 4, 'LIBRE'),
(157, 14, 'MADERA', 1, 'LIBRE'),
(158, 14, 'CARBON', 4, 'LIBRE'),
(159, 14, 'TRIGO', 6, 'LIBRE'),
(160, 14, 'TRIGO', 5, 'LIBRE'),
(161, 14, 'MADERA', 6, 'LIBRE'),
(162, 14, 'CARBON', 1, 'LIBRE'),
(163, 14, 'TRIGO', 6, 'LIBRE'),
(164, 14, 'TRIGO', 1, 'LIBRE'),
(165, 14, 'TRIGO', 6, 'LIBRE'),
(166, 14, 'CARBON', 6, 'LIBRE'),
(167, 14, 'TRIGO', 4, 'LIBRE'),
(168, 14, 'TRIGO', 3, 'LIBRE'),
(169, 15, 'MADERA', 5, 'LIBRE'),
(170, 15, 'TRIGO', 4, 'LIBRE'),
(171, 15, 'TRIGO', 2, 'LIBRE'),
(172, 15, 'MADERA', 3, 'LIBRE'),
(173, 15, 'MADERA', 3, 'LIBRE'),
(174, 15, 'MADERA', 3, 'LIBRE'),
(175, 15, 'TRIGO', 5, 'LIBRE'),
(176, 15, 'MADERA', 4, 'LIBRE'),
(177, 15, 'TRIGO', 3, 'LIBRE'),
(178, 15, 'MADERA', 6, 'LIBRE'),
(179, 15, 'MADERA', 5, 'LIBRE'),
(180, 15, 'TRIGO', 2, 'LIBRE'),
(181, 16, 'TRIGO', 5, 'LIBRE'),
(182, 16, 'CARBON', 3, 'LIBRE'),
(183, 16, 'CARBON', 2, 'LIBRE'),
(184, 16, 'MADERA', 2, 'LIBRE'),
(185, 16, 'MADERA', 6, 'LIBRE'),
(186, 16, 'CARBON', 1, 'LIBRE'),
(187, 16, 'TRIGO', 3, 'LIBRE'),
(188, 16, 'MADERA', 2, 'LIBRE'),
(189, 16, 'CARBON', 2, 'LIBRE'),
(190, 16, 'CARBON', 1, 'LIBRE'),
(191, 16, 'MADERA', 2, 'LIBRE'),
(192, 16, 'CARBON', 3, 'LIBRE'),
(193, 17, 'TRIGO', 5, 'SERVIDOR'),
(194, 17, 'CARBON', 6, 'SERVIDOR'),
(195, 17, 'CARBON', 1, 'SERVIDOR'),
(196, 17, 'TRIGO', 6, 'SERVIDOR'),
(197, 17, 'TRIGO', 1, 'JUGADOR'),
(198, 17, 'TRIGO', 5, 'SERVIDOR'),
(199, 17, 'MADERA', 3, 'JUGADOR'),
(200, 17, 'TRIGO', 5, 'JUGADOR'),
(201, 17, 'TRIGO', 5, 'JUGADOR'),
(202, 17, 'CARBON', 5, 'JUGADOR'),
(203, 17, 'TRIGO', 2, 'SERVIDOR'),
(204, 17, 'CARBON', 5, 'JUGADOR'),
(205, 18, 'TRIGO', 2, 'LIBRE'),
(206, 18, 'TRIGO', 3, 'LIBRE'),
(207, 18, 'MADERA', 1, 'LIBRE'),
(208, 18, 'MADERA', 1, 'LIBRE'),
(209, 18, 'TRIGO', 6, 'LIBRE'),
(210, 18, 'TRIGO', 2, 'LIBRE'),
(211, 18, 'CARBON', 1, 'LIBRE'),
(212, 18, 'TRIGO', 4, 'LIBRE'),
(213, 18, 'TRIGO', 6, 'LIBRE'),
(214, 18, 'TRIGO', 3, 'LIBRE'),
(215, 18, 'CARBON', 1, 'LIBRE'),
(216, 18, 'CARBON', 3, 'LIBRE'),
(217, 19, 'MADERA', 6, 'LIBRE'),
(218, 19, 'MADERA', 1, 'LIBRE'),
(219, 19, 'MADERA', 6, 'LIBRE'),
(220, 19, 'MADERA', 3, 'LIBRE'),
(221, 19, 'TRIGO', 6, 'LIBRE'),
(222, 19, 'TRIGO', 2, 'LIBRE'),
(223, 19, 'CARBON', 5, 'LIBRE'),
(224, 19, 'MADERA', 3, 'LIBRE'),
(225, 19, 'TRIGO', 1, 'LIBRE'),
(226, 19, 'MADERA', 3, 'LIBRE'),
(227, 19, 'CARBON', 6, 'LIBRE'),
(228, 19, 'CARBON', 1, 'LIBRE'),
(229, 20, 'TRIGO', 1, 'SERVIDOR'),
(230, 20, 'CARBON', 4, 'JUGADOR'),
(231, 20, 'TRIGO', 3, 'JUGADOR'),
(232, 20, 'CARBON', 6, 'SERVIDOR'),
(233, 20, 'TRIGO', 6, 'SERVIDOR'),
(234, 20, 'CARBON', 5, 'SERVIDOR'),
(235, 20, 'CARBON', 3, 'SERVIDOR'),
(236, 20, 'MADERA', 4, 'JUGADOR'),
(237, 20, 'CARBON', 1, 'SERVIDOR'),
(238, 20, 'CARBON', 1, 'JUGADOR'),
(239, 20, 'MADERA', 3, 'JUGADOR'),
(240, 20, 'CARBON', 1, 'JUGADOR'),
(241, 21, 'MADERA', 2, 'LIBRE'),
(242, 21, 'MADERA', 6, 'LIBRE'),
(243, 21, 'MADERA', 1, 'LIBRE'),
(244, 21, 'CARBON', 5, 'LIBRE'),
(245, 21, 'MADERA', 5, 'LIBRE'),
(246, 21, 'MADERA', 5, 'LIBRE'),
(247, 21, 'TRIGO', 3, 'LIBRE'),
(248, 21, 'TRIGO', 3, 'LIBRE'),
(249, 21, 'MADERA', 1, 'LIBRE'),
(250, 21, 'CARBON', 5, 'LIBRE'),
(251, 21, 'CARBON', 1, 'LIBRE'),
(252, 21, 'CARBON', 4, 'LIBRE'),
(253, 22, 'TRIGO', 5, 'LIBRE'),
(254, 22, 'TRIGO', 5, 'LIBRE'),
(255, 22, 'TRIGO', 6, 'LIBRE'),
(256, 22, 'CARBON', 3, 'LIBRE'),
(257, 22, 'MADERA', 3, 'LIBRE'),
(258, 22, 'CARBON', 6, 'LIBRE'),
(259, 22, 'CARBON', 2, 'LIBRE'),
(260, 22, 'TRIGO', 1, 'LIBRE'),
(261, 22, 'MADERA', 3, 'LIBRE'),
(262, 22, 'TRIGO', 5, 'LIBRE'),
(263, 22, 'MADERA', 6, 'LIBRE'),
(264, 22, 'CARBON', 4, 'LIBRE'),
(265, 23, 'TRIGO', 1, 'SERVIDOR'),
(266, 23, 'MADERA', 6, 'SERVIDOR'),
(267, 23, 'MADERA', 5, 'JUGADOR'),
(268, 23, 'MADERA', 3, 'JUGADOR'),
(269, 23, 'TRIGO', 1, 'JUGADOR'),
(270, 23, 'MADERA', 6, 'SERVIDOR'),
(271, 23, 'MADERA', 1, 'SERVIDOR'),
(272, 23, 'TRIGO', 4, 'JUGADOR'),
(273, 23, 'CARBON', 1, 'JUGADOR'),
(274, 23, 'MADERA', 3, 'SERVIDOR'),
(275, 23, 'CARBON', 2, 'JUGADOR'),
(276, 23, 'MADERA', 6, 'SERVIDOR'),
(277, 24, 'CARBON', 3, 'LIBRE'),
(278, 24, 'TRIGO', 5, 'LIBRE'),
(279, 24, 'CARBON', 4, 'LIBRE'),
(280, 24, 'MADERA', 6, 'LIBRE'),
(281, 24, 'TRIGO', 1, 'LIBRE'),
(282, 24, 'CARBON', 6, 'LIBRE'),
(283, 24, 'CARBON', 3, 'LIBRE'),
(284, 24, 'MADERA', 5, 'LIBRE'),
(285, 24, 'CARBON', 4, 'LIBRE'),
(286, 24, 'CARBON', 3, 'LIBRE'),
(287, 24, 'TRIGO', 4, 'LIBRE'),
(288, 24, 'TRIGO', 6, 'LIBRE'),
(289, 25, 'MADERA', 3, 'LIBRE'),
(290, 25, 'CARBON', 2, 'LIBRE'),
(291, 25, 'TRIGO', 4, 'LIBRE'),
(292, 25, 'CARBON', 2, 'LIBRE'),
(293, 25, 'CARBON', 2, 'LIBRE'),
(294, 25, 'MADERA', 1, 'LIBRE'),
(295, 25, 'CARBON', 6, 'LIBRE'),
(296, 25, 'CARBON', 1, 'LIBRE'),
(297, 25, 'TRIGO', 2, 'LIBRE'),
(298, 25, 'TRIGO', 1, 'LIBRE'),
(299, 25, 'CARBON', 6, 'LIBRE'),
(300, 25, 'MADERA', 2, 'LIBRE'),
(301, 26, 'CARBON', 1, 'LIBRE'),
(302, 26, 'CARBON', 1, 'LIBRE'),
(303, 26, 'CARBON', 4, 'LIBRE'),
(304, 26, 'TRIGO', 2, 'LIBRE'),
(305, 26, 'MADERA', 6, 'LIBRE'),
(306, 26, 'CARBON', 5, 'LIBRE'),
(307, 26, 'TRIGO', 6, 'LIBRE'),
(308, 26, 'TRIGO', 2, 'LIBRE'),
(309, 26, 'TRIGO', 1, 'LIBRE'),
(310, 26, 'MADERA', 2, 'LIBRE'),
(311, 26, 'TRIGO', 3, 'LIBRE'),
(312, 26, 'MADERA', 6, 'LIBRE'),
(313, 27, 'CARBON', 6, 'LIBRE'),
(314, 27, 'CARBON', 4, 'LIBRE'),
(315, 27, 'TRIGO', 1, 'LIBRE'),
(316, 27, 'MADERA', 1, 'LIBRE'),
(317, 27, 'MADERA', 4, 'LIBRE'),
(318, 27, 'CARBON', 2, 'LIBRE'),
(319, 27, 'TRIGO', 1, 'LIBRE'),
(320, 27, 'MADERA', 1, 'LIBRE'),
(321, 27, 'MADERA', 6, 'LIBRE'),
(322, 27, 'TRIGO', 3, 'LIBRE'),
(323, 27, 'TRIGO', 1, 'LIBRE'),
(324, 27, 'TRIGO', 1, 'LIBRE'),
(325, 28, 'TRIGO', 2, 'SERVIDOR'),
(326, 28, 'CARBON', 6, 'SERVIDOR'),
(327, 28, 'CARBON', 3, 'SERVIDOR'),
(328, 28, 'TRIGO', 6, 'JUGADOR'),
(329, 28, 'TRIGO', 2, 'JUGADOR'),
(330, 28, 'MADERA', 3, 'SERVIDOR'),
(331, 28, 'MADERA', 5, 'JUGADOR'),
(332, 28, 'CARBON', 5, 'JUGADOR'),
(333, 28, 'CARBON', 5, 'SERVIDOR'),
(334, 28, 'TRIGO', 1, 'JUGADOR'),
(335, 28, 'MADERA', 4, 'SERVIDOR'),
(336, 28, 'MADERA', 3, 'JUGADOR'),
(337, 29, 'CARBON', 1, 'JUGADOR'),
(338, 29, 'CARBON', 1, 'JUGADOR'),
(339, 29, 'TRIGO', 4, 'JUGADOR'),
(340, 29, 'TRIGO', 4, 'SERVIDOR'),
(341, 29, 'CARBON', 2, 'JUGADOR'),
(342, 29, 'TRIGO', 5, 'SERVIDOR'),
(343, 29, 'MADERA', 6, 'SERVIDOR'),
(344, 29, 'MADERA', 2, 'JUGADOR'),
(345, 29, 'TRIGO', 5, 'SERVIDOR'),
(346, 29, 'MADERA', 6, 'SERVIDOR'),
(347, 29, 'CARBON', 6, 'SERVIDOR'),
(348, 29, 'MADERA', 6, 'JUGADOR'),
(349, 30, 'MADERA', 4, 'JUGADOR'),
(350, 30, 'TRIGO', 2, 'JUGADOR'),
(351, 30, 'TRIGO', 5, 'SERVIDOR'),
(352, 30, 'MADERA', 6, 'SERVIDOR'),
(353, 30, 'TRIGO', 1, 'JUGADOR'),
(354, 30, 'MADERA', 3, 'SERVIDOR'),
(355, 30, 'CARBON', 1, 'JUGADOR'),
(356, 30, 'TRIGO', 5, 'SERVIDOR'),
(357, 30, 'TRIGO', 5, 'SERVIDOR'),
(358, 30, 'MADERA', 1, 'JUGADOR'),
(359, 30, 'MADERA', 6, 'SERVIDOR'),
(360, 30, 'CARBON', 4, 'JUGADOR'),
(361, 31, 'TRIGO', 1, 'JUGADOR'),
(362, 31, 'CARBON', 1, 'SERVIDOR'),
(363, 31, 'MADERA', 2, 'SERVIDOR'),
(364, 31, 'TRIGO', 5, 'SERVIDOR'),
(365, 31, 'CARBON', 2, 'JUGADOR'),
(366, 31, 'CARBON', 4, 'JUGADOR'),
(367, 31, 'MADERA', 3, 'JUGADOR'),
(368, 31, 'MADERA', 3, 'SERVIDOR'),
(369, 31, 'TRIGO', 5, 'SERVIDOR'),
(370, 31, 'TRIGO', 3, 'JUGADOR'),
(371, 31, 'MADERA', 3, 'JUGADOR'),
(372, 31, 'TRIGO', 3, 'SERVIDOR'),
(373, 32, 'CARBON', 4, 'SERVIDOR'),
(374, 32, 'MADERA', 1, 'JUGADOR'),
(375, 32, 'CARBON', 3, 'SERVIDOR'),
(376, 32, 'TRIGO', 1, 'JUGADOR'),
(377, 32, 'MADERA', 3, 'SERVIDOR'),
(378, 32, 'MADERA', 1, 'JUGADOR'),
(379, 32, 'MADERA', 3, 'JUGADOR'),
(380, 32, 'TRIGO', 5, 'SERVIDOR'),
(381, 32, 'MADERA', 1, 'SERVIDOR'),
(382, 32, 'MADERA', 3, 'JUGADOR'),
(383, 32, 'CARBON', 3, 'SERVIDOR'),
(384, 32, 'TRIGO', 2, 'JUGADOR'),
(385, 33, 'TRIGO', 3, 'LIBRE'),
(386, 33, 'CARBON', 2, 'LIBRE'),
(387, 33, 'MADERA', 3, 'LIBRE'),
(388, 33, 'MADERA', 2, 'LIBRE'),
(389, 33, 'TRIGO', 1, 'LIBRE'),
(390, 33, 'MADERA', 1, 'LIBRE'),
(391, 33, 'MADERA', 1, 'LIBRE'),
(392, 33, 'TRIGO', 4, 'LIBRE'),
(393, 33, 'TRIGO', 1, 'LIBRE'),
(394, 33, 'TRIGO', 4, 'LIBRE'),
(395, 33, 'TRIGO', 2, 'LIBRE'),
(396, 33, 'MADERA', 5, 'LIBRE'),
(397, 34, 'TRIGO', 2, 'SERVIDOR'),
(398, 34, 'TRIGO', 1, 'JUGADOR'),
(399, 34, 'MADERA', 1, 'JUGADOR'),
(400, 34, 'MADERA', 3, 'SERVIDOR'),
(401, 34, 'MADERA', 6, 'SERVIDOR'),
(402, 34, 'TRIGO', 5, 'SERVIDOR'),
(403, 34, 'MADERA', 3, 'JUGADOR'),
(404, 34, 'TRIGO', 3, 'SERVIDOR'),
(405, 34, 'CARBON', 6, 'SERVIDOR'),
(406, 34, 'TRIGO', 2, 'JUGADOR'),
(407, 34, 'MADERA', 1, 'JUGADOR'),
(408, 34, 'CARBON', 2, 'JUGADOR'),
(409, 35, 'TRIGO', 1, 'SERVIDOR'),
(410, 35, 'CARBON', 4, 'SERVIDOR'),
(411, 35, 'CARBON', 6, 'JUGADOR'),
(412, 35, 'MADERA', 5, 'JUGADOR'),
(413, 35, 'TRIGO', 4, 'SERVIDOR'),
(414, 35, 'TRIGO', 6, 'SERVIDOR'),
(415, 35, 'TRIGO', 2, 'JUGADOR'),
(416, 35, 'TRIGO', 2, 'JUGADOR'),
(417, 35, 'CARBON', 5, 'SERVIDOR'),
(418, 35, 'TRIGO', 2, 'JUGADOR'),
(419, 35, 'CARBON', 2, 'JUGADOR'),
(420, 35, 'TRIGO', 4, 'SERVIDOR'),
(421, 36, 'TRIGO', 1, 'SERVIDOR'),
(422, 36, 'MADERA', 5, 'SERVIDOR'),
(423, 36, 'MADERA', 2, 'JUGADOR'),
(424, 36, 'MADERA', 3, 'JUGADOR'),
(425, 36, 'TRIGO', 3, 'SERVIDOR'),
(426, 36, 'MADERA', 5, 'JUGADOR'),
(427, 36, 'TRIGO', 6, 'SERVIDOR'),
(428, 36, 'TRIGO', 3, 'JUGADOR'),
(429, 36, 'MADERA', 4, 'SERVIDOR'),
(430, 36, 'MADERA', 4, 'SERVIDOR'),
(431, 36, 'MADERA', 5, 'JUGADOR'),
(432, 36, 'CARBON', 3, 'JUGADOR'),
(433, 37, 'CARBON', 6, 'LIBRE'),
(434, 37, 'TRIGO', 6, 'LIBRE'),
(435, 37, 'MADERA', 3, 'LIBRE'),
(436, 37, 'TRIGO', 2, 'LIBRE'),
(437, 37, 'TRIGO', 6, 'LIBRE'),
(438, 37, 'TRIGO', 3, 'LIBRE'),
(439, 37, 'CARBON', 4, 'LIBRE'),
(440, 37, 'CARBON', 2, 'LIBRE'),
(441, 37, 'TRIGO', 4, 'LIBRE'),
(442, 37, 'CARBON', 4, 'LIBRE'),
(443, 37, 'CARBON', 1, 'LIBRE'),
(444, 37, 'CARBON', 5, 'LIBRE'),
(445, 38, 'MADERA', 5, 'SERVIDOR'),
(446, 38, 'MADERA', 5, 'JUGADOR'),
(447, 38, 'MADERA', 4, 'SERVIDOR'),
(448, 38, 'CARBON', 3, 'JUGADOR'),
(449, 38, 'TRIGO', 4, 'SERVIDOR'),
(450, 38, 'MADERA', 6, 'SERVIDOR'),
(451, 38, 'CARBON', 3, 'JUGADOR'),
(452, 38, 'MADERA', 5, 'SERVIDOR'),
(453, 38, 'CARBON', 5, 'SERVIDOR'),
(454, 38, 'CARBON', 5, 'JUGADOR'),
(455, 38, 'CARBON', 4, 'JUGADOR'),
(456, 38, 'CARBON', 4, 'JUGADOR'),
(457, 39, 'CARBON', 2, 'SERVIDOR'),
(458, 39, 'CARBON', 3, 'JUGADOR'),
(459, 39, 'CARBON', 4, 'JUGADOR'),
(460, 39, 'TRIGO', 2, 'JUGADOR'),
(461, 39, 'TRIGO', 5, 'SERVIDOR'),
(462, 39, 'CARBON', 4, 'JUGADOR'),
(463, 39, 'MADERA', 6, 'JUGADOR'),
(464, 39, 'TRIGO', 5, 'SERVIDOR'),
(465, 39, 'CARBON', 6, 'SERVIDOR'),
(466, 39, 'TRIGO', 4, 'JUGADOR'),
(467, 39, 'TRIGO', 6, 'SERVIDOR'),
(468, 39, 'CARBON', 4, 'SERVIDOR'),
(469, 40, 'TRIGO', 1, 'SERVIDOR'),
(470, 40, 'MADERA', 3, 'JUGADOR'),
(471, 40, 'MADERA', 6, 'SERVIDOR'),
(472, 40, 'CARBON', 6, 'SERVIDOR'),
(473, 40, 'MADERA', 6, 'SERVIDOR'),
(474, 40, 'TRIGO', 3, 'JUGADOR'),
(475, 40, 'MADERA', 6, 'SERVIDOR'),
(476, 40, 'CARBON', 2, 'JUGADOR'),
(477, 40, 'MADERA', 4, 'JUGADOR'),
(478, 40, 'CARBON', 2, 'JUGADOR'),
(479, 40, 'CARBON', 6, 'SERVIDOR'),
(480, 40, 'TRIGO', 3, 'JUGADOR'),
(481, 41, 'MADERA', 3, 'SERVIDOR'),
(482, 41, 'MADERA', 4, 'SERVIDOR'),
(483, 41, 'MADERA', 6, 'JUGADOR'),
(484, 41, 'MADERA', 4, 'JUGADOR'),
(485, 41, 'TRIGO', 5, 'SERVIDOR'),
(486, 41, 'TRIGO', 4, 'SERVIDOR'),
(487, 41, 'TRIGO', 2, 'JUGADOR'),
(488, 41, 'TRIGO', 4, 'SERVIDOR'),
(489, 41, 'CARBON', 3, 'JUGADOR'),
(490, 41, 'CARBON', 4, 'SERVIDOR'),
(491, 41, 'CARBON', 6, 'JUGADOR'),
(492, 41, 'TRIGO', 4, 'JUGADOR'),
(493, 42, 'TRIGO', 3, 'SERVIDOR'),
(494, 42, 'CARBON', 1, 'JUGADOR'),
(495, 42, 'TRIGO', 2, 'JUGADOR'),
(496, 42, 'TRIGO', 2, 'SERVIDOR'),
(497, 42, 'CARBON', 2, 'SERVIDOR'),
(498, 42, 'TRIGO', 5, 'SERVIDOR'),
(499, 42, 'MADERA', 6, 'SERVIDOR'),
(500, 42, 'TRIGO', 1, 'JUGADOR'),
(501, 42, 'MADERA', 2, 'JUGADOR'),
(502, 42, 'CARBON', 2, 'JUGADOR'),
(503, 42, 'TRIGO', 3, 'JUGADOR'),
(504, 42, 'MADERA', 2, 'SERVIDOR'),
(505, 43, 'CARBON', 2, 'LIBRE'),
(506, 43, 'CARBON', 1, 'LIBRE'),
(507, 43, 'MADERA', 1, 'LIBRE'),
(508, 43, 'MADERA', 5, 'JUGADOR'),
(509, 43, 'CARBON', 4, 'LIBRE'),
(510, 43, 'CARBON', 6, 'SERVIDOR'),
(511, 43, 'CARBON', 4, 'JUGADOR'),
(512, 43, 'CARBON', 1, 'LIBRE'),
(513, 43, 'CARBON', 4, 'LIBRE'),
(514, 43, 'CARBON', 2, 'LIBRE'),
(515, 43, 'TRIGO', 4, 'SERVIDOR'),
(516, 43, 'CARBON', 5, 'LIBRE'),
(517, 44, 'TRIGO', 2, 'LIBRE'),
(518, 44, 'MADERA', 2, 'LIBRE'),
(519, 44, 'TRIGO', 4, 'LIBRE'),
(520, 44, 'MADERA', 5, 'LIBRE'),
(521, 44, 'TRIGO', 1, 'LIBRE'),
(522, 44, 'CARBON', 3, 'LIBRE'),
(523, 44, 'MADERA', 2, 'LIBRE'),
(524, 44, 'MADERA', 4, 'LIBRE'),
(525, 44, 'MADERA', 3, 'LIBRE'),
(526, 44, 'CARBON', 1, 'LIBRE'),
(527, 44, 'TRIGO', 1, 'LIBRE'),
(528, 44, 'MADERA', 2, 'LIBRE');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `partidas`
--

CREATE TABLE `partidas` (
  `id` int(11) NOT NULL,
  `id_jugador` int(11) NOT NULL,
  `estado` enum('EN_CURSO','FINALIZADA','ABANDONADA') NOT NULL,
  `ganador` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `partidas`
--

INSERT INTO `partidas` (`id`, `id_jugador`, `estado`, `ganador`) VALUES
(1, 1, 'ABANDONADA', ''),
(2, 1, 'ABANDONADA', ''),
(3, 1, 'FINALIZADA', ''),
(4, 1, 'FINALIZADA', ''),
(5, 1, 'ABANDONADA', ''),
(6, 1, 'ABANDONADA', ''),
(7, 1, 'ABANDONADA', ''),
(8, 1, 'ABANDONADA', ''),
(9, 1, 'ABANDONADA', ''),
(10, 1, 'ABANDONADA', ''),
(11, 1, 'ABANDONADA', ''),
(12, 1, 'FINALIZADA', ''),
(13, 2, 'ABANDONADA', ''),
(14, 2, 'ABANDONADA', ''),
(15, 2, 'ABANDONADA', ''),
(16, 2, 'ABANDONADA', ''),
(17, 2, 'FINALIZADA', ''),
(18, 2, 'ABANDONADA', ''),
(19, 2, 'ABANDONADA', ''),
(20, 2, 'FINALIZADA', ''),
(21, 2, 'ABANDONADA', ''),
(22, 2, 'ABANDONADA', ''),
(23, 3, 'FINALIZADA', 'JUGADOR'),
(24, 3, 'ABANDONADA', NULL),
(25, 3, 'ABANDONADA', NULL),
(26, 3, 'ABANDONADA', 'SERVIDOR'),
(27, 1, 'ABANDONADA', 'SERVIDOR'),
(28, 1, 'FINALIZADA', 'JUGADOR'),
(29, 1, 'FINALIZADA', 'SERVIDOR'),
(30, 1, 'FINALIZADA', 'JUGADOR'),
(31, 1, 'ABANDONADA', 'SERVIDOR'),
(32, 1, 'ABANDONADA', 'SERVIDOR'),
(33, 1, 'ABANDONADA', 'SERVIDOR'),
(34, 1, 'ABANDONADA', 'SERVIDOR'),
(35, 1, 'ABANDONADA', 'SERVIDOR'),
(36, 1, 'ABANDONADA', 'SERVIDOR'),
(37, 1, 'ABANDONADA', 'SERVIDOR'),
(38, 1, 'ABANDONADA', 'SERVIDOR'),
(39, 1, 'FINALIZADA', 'JUGADOR'),
(40, 1, 'FINALIZADA', 'JUGADOR'),
(41, 1, 'FINALIZADA', 'JUGADOR'),
(42, 1, 'FINALIZADA', 'JUGADOR'),
(43, 1, 'ABANDONADA', 'SERVIDOR'),
(44, 2, 'EN_CURSO', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(10) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `email`, `password`) VALUES
(1, 'dan@catan.com', '$2a$12$.P8AIbj7N32fbl4Wa8gB4uQXSw9IZXFQZcyGCS/KwGZrJmz2J2BLq'),
(2, 'pepe@catan.com', '$2a$12$UgR9D5KJjQq2Ir9wVoxbuuuYgpZbrfgZWGYxxJrHMLpu3VwmenXOW'),
(3, 'maria@catan.com', '$2a$12$I0W4pujUoutjHcOZeL7nlOXRzEI/2.KI95d7Qxg0KcOPFa1AQWGOS');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `almacenrecursos`
--
ALTER TABLE `almacenrecursos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_jugador` (`id_jugador`) USING BTREE;

--
-- Indices de la tabla `casillas`
--
ALTER TABLE `casillas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_partida` (`id_partida`);

--
-- Indices de la tabla `partidas`
--
ALTER TABLE `partidas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_jugador` (`id_jugador`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `almacenrecursos`
--
ALTER TABLE `almacenrecursos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT de la tabla `casillas`
--
ALTER TABLE `casillas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=529;

--
-- AUTO_INCREMENT de la tabla `partidas`
--
ALTER TABLE `partidas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `almacenrecursos`
--
ALTER TABLE `almacenrecursos`
  ADD CONSTRAINT `almacenrecursos_ibfk_1` FOREIGN KEY (`id_jugador`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `casillas`
--
ALTER TABLE `casillas`
  ADD CONSTRAINT `casillas_ibfk_1` FOREIGN KEY (`id_partida`) REFERENCES `partidas` (`id`);

--
-- Filtros para la tabla `partidas`
--
ALTER TABLE `partidas`
  ADD CONSTRAINT `partidas_ibfk_1` FOREIGN KEY (`id_jugador`) REFERENCES `usuarios` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
