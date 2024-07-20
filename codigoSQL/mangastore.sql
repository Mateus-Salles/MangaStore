-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 04/07/2023 às 02:20
-- Versão do servidor: 10.4.28-MariaDB
-- Versão do PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `mangastore`
--

CREATE DATABASE `mangastore`;

-- --------------------------------------------------------

--
-- Estrutura para tabela `cliente`
--

CREATE TABLE `cliente` (
  `id_cliente` int(11) NOT NULL,
  `nome` varchar(50) DEFAULT NULL,
  `endereco` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `telefone` varchar(15) DEFAULT NULL,
  `senha` varchar(8000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `mangas`
--

CREATE TABLE `mangas` (
  `id_manga` int(11) NOT NULL,
  `titulo` varchar(50) DEFAULT NULL,
  `autor` varchar(50) DEFAULT NULL,
  `genero` varchar(256) NOT NULL,
  `editora` varchar(30) DEFAULT NULL,
  `ano_publi` year(4) DEFAULT NULL,
  `preco` float DEFAULT NULL,
  `estoque` int(11) DEFAULT NULL,
  `data_cadastro` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `mangas`
--

INSERT INTO `mangas` (`id_manga`, `titulo`, `autor`, `genero`, `editora`, `ano_publi`, `preco`, `estoque`, `data_cadastro`) VALUES
(28, 'Kaguya-sama: Love is War', 'Aka Akasaka', 'Comédia, Romance, Drama', 'Shueisha', '2015', 53, 200, '2023-07-02'),
(29, 'Naruto vol.1', 'Masashi Kishimoto', 'Shounen, Ação, Aventura, Drama, Artes Marciais, Fantasia', 'Shueisha', '2015', 53, 200, '2023-07-02'),
(30, 'Dragon ball super', 'Akira Toriyama', 'Josei, Romance, Cyberpunk, Namorada Mágica, Pós- apocalíptico, Psicológico, Vida Escolar, Ecchi, Harém, Hentai', 'Shueisha', '1998', 23.49, 0, '2023-07-02'),
(31, 'Kimetsu no Yaiba Vol.1', 'Koyoharu Gotouge', 'Shounen, Ação, Aventura, Sci-Fi, Drama, Fantasia', 'Shueisha', '2016', 53.49, 147, '2023-07-03'),
(32, 'Vinland Saga', 'Makoto Yukimura', 'Seinen, Ação, Drama, Histórico', 'Kodansha', '2005', 43, 200, '2023-07-03');

-- --------------------------------------------------------

--
-- Estrutura para tabela `pedido`
--

CREATE TABLE `pedido` (
  `id_pedido` int(11) NOT NULL,
  `cod_cliente` int(11) DEFAULT NULL,
  `cod_manga` int(11) DEFAULT NULL,
  `data_pedido` date DEFAULT NULL,
  `quant` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`id_cliente`);

--
-- Índices de tabela `mangas`
--
ALTER TABLE `mangas`
  ADD PRIMARY KEY (`id_manga`);

--
-- Índices de tabela `pedido`
--
ALTER TABLE `pedido`
  ADD PRIMARY KEY (`id_pedido`),
  ADD KEY `cod_cliente` (`cod_cliente`),
  ADD KEY `cod_manga` (`cod_manga`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `cliente`
--
ALTER TABLE `cliente`
  MODIFY `id_cliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de tabela `mangas`
--
ALTER TABLE `mangas`
  MODIFY `id_manga` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT de tabela `pedido`
--
ALTER TABLE `pedido`
  MODIFY `id_pedido` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `pedido`
--
ALTER TABLE `pedido`
  ADD CONSTRAINT `pedido_ibfk_1` FOREIGN KEY (`cod_cliente`) REFERENCES `cliente` (`id_cliente`),
  ADD CONSTRAINT `pedido_ibfk_2` FOREIGN KEY (`cod_manga`) REFERENCES `mangas` (`id_manga`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
