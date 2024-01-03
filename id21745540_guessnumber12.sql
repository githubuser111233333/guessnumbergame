-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jan 03, 2024 at 07:28 PM
-- Server version: 10.5.20-MariaDB
-- PHP Version: 7.3.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `id21745540_guessnumber12`
--

-- --------------------------------------------------------

--
-- Table structure for table `hits`
--

CREATE TABLE `hits` (
  `hit_id` int(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  `totalhits` int(11) NOT NULL,
  `attempts` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `hits`
--

INSERT INTO `hits` (`hit_id`, `player_id`, `totalhits`, `attempts`) VALUES
(1, 1, 3, 21),
(2, 6, 5, 38),
(3, 11, 2, 10),
(4, 12, 1, 12);

-- --------------------------------------------------------

--
-- Table structure for table `players`
--

CREATE TABLE `players` (
  `player_id` int(11) NOT NULL,
  `player_name` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `players`
--

INSERT INTO `players` (`player_id`, `player_name`, `password`) VALUES
(1, 'ALI', '123'),
(2, 'Ali123', '123'),
(3, 'Ali1234', '123'),
(4, 'Ali12', '123'),
(5, 'Ali1', '123'),
(6, 'test1', '123'),
(7, 'test2', '123'),
(8, 'test3', '123'),
(9, 'test4', '123'),
(10, 'test5', '123'),
(11, 'alix', '123'),
(12, 'alixx', '123');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `hits`
--
ALTER TABLE `hits`
  ADD PRIMARY KEY (`hit_id`),
  ADD KEY `player_id` (`player_id`);

--
-- Indexes for table `players`
--
ALTER TABLE `players`
  ADD PRIMARY KEY (`player_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `hits`
--
ALTER TABLE `hits`
  MODIFY `hit_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `players`
--
ALTER TABLE `players`
  MODIFY `player_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `hits`
--
ALTER TABLE `hits`
  ADD CONSTRAINT `hits_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`player_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
