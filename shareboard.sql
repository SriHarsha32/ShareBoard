-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Nov 05, 2016 at 08:31 PM
-- Server version: 10.1.13-MariaDB
-- PHP Version: 7.0.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `shareboard`
--

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `CId` int(11) NOT NULL,
  `SId` int(11) DEFAULT NULL,
  `COMMENT` text,
  `CmntOn` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `username` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `hashshares`
--

CREATE TABLE `hashshares` (
  `hashid` int(11) NOT NULL,
  `Shareid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `hashtag`
--

CREATE TABLE `hashtag` (
  `hashid` int(11) NOT NULL,
  `hashName` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `login`
--

CREATE TABLE `login` (
  `username` varchar(255) NOT NULL,
  `pass` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `reactions`
--

CREATE TABLE `reactions` (
  `RId` int(11) NOT NULL,
  `RType` varchar(10) DEFAULT NULL,
  `Sid` int(11) DEFAULT NULL,
  `RctOn` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `username` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `shares`
--

CREATE TABLE `shares` (
  `ShareId` int(11) NOT NULL,
  `SType` int(11) DEFAULT NULL,
  `SBody` text,
  `Slink` text,
  `username` varchar(255) DEFAULT NULL,
  `SharedOn` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `types`
--

CREATE TABLE `types` (
  `tid` int(11) NOT NULL,
  `tname` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `typesconfig`
--

CREATE TABLE `typesconfig` (
  `username` varchar(255) NOT NULL,
  `tid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `userdetails`
--

CREATE TABLE `userdetails` (
  `fullname` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `gender` char(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`CId`),
  ADD KEY `SId` (`SId`),
  ADD KEY `username` (`username`);

--
-- Indexes for table `hashshares`
--
ALTER TABLE `hashshares`
  ADD PRIMARY KEY (`hashid`,`Shareid`),
  ADD KEY `Shareid` (`Shareid`);

--
-- Indexes for table `hashtag`
--
ALTER TABLE `hashtag`
  ADD PRIMARY KEY (`hashid`);

--
-- Indexes for table `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `reactions`
--
ALTER TABLE `reactions`
  ADD PRIMARY KEY (`RId`),
  ADD KEY `Sid` (`Sid`),
  ADD KEY `username` (`username`);

--
-- Indexes for table `shares`
--
ALTER TABLE `shares`
  ADD PRIMARY KEY (`ShareId`),
  ADD KEY `SType` (`SType`),
  ADD KEY `username` (`username`);

--
-- Indexes for table `types`
--
ALTER TABLE `types`
  ADD PRIMARY KEY (`tid`);

--
-- Indexes for table `typesconfig`
--
ALTER TABLE `typesconfig`
  ADD PRIMARY KEY (`tid`,`username`),
  ADD KEY `username` (`username`);

--
-- Indexes for table `userdetails`
--
ALTER TABLE `userdetails`
  ADD PRIMARY KEY (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `CId` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `hashtag`
--
ALTER TABLE `hashtag`
  MODIFY `hashid` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `reactions`
--
ALTER TABLE `reactions`
  MODIFY `RId` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `shares`
--
ALTER TABLE `shares`
  MODIFY `ShareId` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `types`
--
ALTER TABLE `types`
  MODIFY `tid` int(11) NOT NULL AUTO_INCREMENT;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`SId`) REFERENCES `shares` (`ShareId`) ON DELETE CASCADE,
  ADD CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`username`) REFERENCES `userdetails` (`username`);

--
-- Constraints for table `hashshares`
--
ALTER TABLE `hashshares`
  ADD CONSTRAINT `hashshares_ibfk_1` FOREIGN KEY (`hashid`) REFERENCES `hashtag` (`hashid`),
  ADD CONSTRAINT `hashshares_ibfk_2` FOREIGN KEY (`Shareid`) REFERENCES `shares` (`ShareId`);

--
-- Constraints for table `login`
--
ALTER TABLE `login`
  ADD CONSTRAINT `login_ibfk_1` FOREIGN KEY (`username`) REFERENCES `userdetails` (`username`);

--
-- Constraints for table `reactions`
--
ALTER TABLE `reactions`
  ADD CONSTRAINT `reactions_ibfk_1` FOREIGN KEY (`Sid`) REFERENCES `shares` (`ShareId`) ON DELETE CASCADE,
  ADD CONSTRAINT `reactions_ibfk_2` FOREIGN KEY (`username`) REFERENCES `userdetails` (`username`);

--
-- Constraints for table `shares`
--
ALTER TABLE `shares`
  ADD CONSTRAINT `shares_ibfk_1` FOREIGN KEY (`SType`) REFERENCES `types` (`tid`),
  ADD CONSTRAINT `shares_ibfk_2` FOREIGN KEY (`username`) REFERENCES `userdetails` (`username`);

--
-- Constraints for table `typesconfig`
--
ALTER TABLE `typesconfig`
  ADD CONSTRAINT `typesconfig_ibfk_1` FOREIGN KEY (`tid`) REFERENCES `types` (`tid`),
  ADD CONSTRAINT `typesconfig_ibfk_2` FOREIGN KEY (`username`) REFERENCES `userdetails` (`username`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
