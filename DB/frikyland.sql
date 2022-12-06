-- phpMyAdmin SQL Dump
-- version 5.1.1deb5ubuntu1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 06-12-2022 a las 00:38:30
-- Versión del servidor: 8.0.31-0ubuntu0.22.04.1
-- Versión de PHP: 8.1.2-1ubuntu2.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `frikyland`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `interaction`
--

CREATE TABLE `interaction` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `post_id` int NOT NULL,
  `user_favorite` tinyint(1) DEFAULT NULL,
  `comment` longtext COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `messenger_messages`
--

CREATE TABLE `messenger_messages` (
  `id` bigint NOT NULL,
  `body` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `headers` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue_name` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `available_at` datetime NOT NULL,
  `delivered_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `post`
--

CREATE TABLE `post` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `file` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creation_date` datetime NOT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `post`
--

INSERT INTO `post` (`id`, `user_id`, `title`, `type`, `description`, `file`, `creation_date`, `url`) VALUES
(1, 1, 'Mi primer titulo ', 'Opinion ', 'Este es mi primer Post ', NULL, '2022-12-02 21:25:33', 'hola-mundo'),
(2, 1, 'Mi primer titulo ', 'Debate ', 'Bienvenidos al debate ?', NULL, '2022-12-07 21:30:16', 'hola-e'),
(3, 1, 'Mi post insertad', 'Opinion', 'hola mundo', 'Hola mundo', '2022-12-02 19:44:35', 'My URL'),
(5, 1, 'hola mundo', 'humor', 'Desde el form', 'Otrotip', '2022-12-02 21:07:00', 'unadescription'),
(6, 1, 'nuevo post', '👩‍💻 Programación', 'Este es un post sobre prog', 'notenemos', '2022-12-04 03:59:12', 'nuevo post'),
(7, 1, 'otro posta nuevo', '👩‍💻 Programación', '123', 'otras', '2022-12-04 04:00:09', 'otro-posta-nuevo'),
(8, 1, 'probando', '👩‍💻 Programación', 'probando', 'depende', '2022-12-04 04:15:51', 'probando'),
(9, 1, 'otra', '👩‍💻 Programación', 'otra', NULL, '2022-12-04 16:53:19', 'otra'),
(10, 1, 'preuba', '😂 Humor', 'qwe', 'imagen-primer-plano-programador-trabajando-su-escritorio-oficina-1098-18707-638cfb72ec888.webp', '2022-12-04 16:56:34', 'preuba'),
(11, 1, 'titulo', '👩‍💻 Programación', 'nuevo', NULL, '2022-12-05 22:26:53', 'titulo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user`
--

CREATE TABLE `user` (
  `id` int NOT NULL,
  `email` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `roles` json NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `photo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `user`
--

INSERT INTO `user` (`id`, `email`, `roles`, `password`, `photo`, `description`) VALUES
(1, 'mauroriverae@gmail.com', '[\"ROLE_USER\"]', '123', 'myphoto.jpg', 'Hola'),
(2, 'mauro23rivera', '[]', '123', 'no', 'Otro'),
(3, 'mrrivera', '[\"ROLE_USER\"]', '1234', 'nohay', 'otroa'),
(4, 'mauro', '[\"ROLE_USER\"]', '$2y$13$4cRBcP4/mmcZ.vUt6IFxZ.7OAaYY4OHfkvpN01NoL4aV1EfV2fose', 'no', 'pas'),
(7, 'mauro@mauro', '[\"ROLE_USER\"]', '$2y$13$tDvvdZVxESS07h8c6vCqtupK4Qy.eZfDH9U8ETbJX1/7F4lvHArzy', 'no', 'qwe');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `interaction`
--
ALTER TABLE `interaction`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_378DFDA7A76ED395` (`user_id`),
  ADD KEY `IDX_378DFDA74B89032C` (`post_id`);

--
-- Indices de la tabla `messenger_messages`
--
ALTER TABLE `messenger_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_75EA56E0FB7336F0` (`queue_name`),
  ADD KEY `IDX_75EA56E0E3BD61CE` (`available_at`),
  ADD KEY `IDX_75EA56E016BA31DB` (`delivered_at`);

--
-- Indices de la tabla `post`
--
ALTER TABLE `post`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_5A8A6C8DA76ED395` (`user_id`);

--
-- Indices de la tabla `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_8D93D649E7927C74` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `interaction`
--
ALTER TABLE `interaction`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `messenger_messages`
--
ALTER TABLE `messenger_messages`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `post`
--
ALTER TABLE `post`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `user`
--
ALTER TABLE `user`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `interaction`
--
ALTER TABLE `interaction`
  ADD CONSTRAINT `FK_378DFDA74B89032C` FOREIGN KEY (`post_id`) REFERENCES `post` (`id`),
  ADD CONSTRAINT `FK_378DFDA7A76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Filtros para la tabla `post`
--
ALTER TABLE `post`
  ADD CONSTRAINT `FK_5A8A6C8DA76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
