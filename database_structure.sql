-- phpMyAdmin SQL Dump
-- version 4.9.4
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Mar 05, 2020 at 05:24 AM
-- Server version: 10.1.44-MariaDB-1~jessie
-- PHP Version: 7.0.33-1~dotdeb+8.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `server_810_123`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `accid` int(10) NOT NULL,
  `aname` varchar(20) DEFAULT NULL,
  `acountry` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `bans`
--

CREATE TABLE `bans` (
  `bid` int(11) NOT NULL,
  `b_name` varchar(24) DEFAULT NULL,
  `b_ip` varchar(16) DEFAULT NULL,
  `b_admin` varchar(24) DEFAULT NULL,
  `b_reason` varchar(50) DEFAULT NULL,
  `b_time` varchar(30) DEFAULT NULL,
  `expire` int(20) NOT NULL DEFAULT '-1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `cblacklist`
--

CREATE TABLE `cblacklist` (
  `cid` int(20) NOT NULL,
  `pid` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `clanhistory`
--

CREATE TABLE `clanhistory` (
  `hid` int(20) NOT NULL,
  `msg` varchar(144) NOT NULL DEFAULT '',
  `cid` int(10) NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `clans`
--

CREATE TABLE `clans` (
  `cid` int(20) NOT NULL,
  `ctag` varchar(5) DEFAULT NULL,
  `cname` varchar(20) DEFAULT NULL,
  `cslogan` varchar(70) DEFAULT 'Clan Slogan: None',
  `cteam` varchar(20) DEFAULT NULL,
  `cowner` varchar(25) DEFAULT NULL,
  `cleader` varchar(25) DEFAULT NULL,
  `cmembers` int(10) NOT NULL DEFAULT '1',
  `clevel` int(5) NOT NULL DEFAULT '0',
  `chpoints` int(10) NOT NULL DEFAULT '0',
  `ckills` int(20) NOT NULL DEFAULT '0',
  `cdeaths` int(20) NOT NULL DEFAULT '0',
  `cskin` int(10) NOT NULL,
  `cwins` int(10) NOT NULL DEFAULT '0',
  `close` int(10) NOT NULL DEFAULT '0',
  `perk0` int(20) NOT NULL DEFAULT '0',
  `perk1` int(20) NOT NULL DEFAULT '0',
  `perk2` int(20) NOT NULL DEFAULT '0',
  `perk3` int(20) NOT NULL DEFAULT '0',
  `perk4` int(20) NOT NULL DEFAULT '0',
  `perk5` int(20) NOT NULL DEFAULT '0',
  `perk6` int(20) NOT NULL DEFAULT '0',
  `perk7` int(20) NOT NULL DEFAULT '0',
  `top_clanwar` varchar(20) NOT NULL DEFAULT '0',
  `top_cw_win` int(10) NOT NULL DEFAULT '0',
  `top_cw_lose` int(10) NOT NULL DEFAULT '0',
  `lastcw` int(10) DEFAULT '-1',
  `activity` int(10) NOT NULL DEFAULT '0',
  `cuseranks` int(20) NOT NULL,
  `crank0` varchar(20) NOT NULL,
  `crank1` varchar(20) NOT NULL,
  `crank2` varchar(20) NOT NULL,
  `crank3` varchar(20) NOT NULL,
  `crank4` varchar(20) NOT NULL,
  `crank5` varchar(20) NOT NULL,
  `crank6` varchar(20) NOT NULL,
  `crank7` varchar(20) NOT NULL,
  `crank8` varchar(20) NOT NULL,
  `crank9` varchar(20) NOT NULL,
  `crank10` varchar(20) NOT NULL,
  `cathp` int(20) DEFAULT '0',
  `ctoy1` int(11) NOT NULL,
  `ctoy2` int(11) NOT NULL,
  `rank` int(3) NOT NULL DEFAULT '0',
  `rankprog` int(4) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Triggers `clans`
--
DELIMITER $$
CREATE TRIGGER `OwnerUpdate` BEFORE UPDATE ON `clans` FOR EACH ROW BEGIN

  /*  IF OLD.cowner IS NOT NULL THEN
    SET NEW.cowner =  (select playerbase.name from playerbase where playerbase.clanown = NEW.cid LIMIT 1);
END IF;
*/
      SET NEW.cmembers = (select COUNT(id) from playerbase where playerbase.inclan = NEW.cid);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `clantoys`
--

CREATE TABLE `clantoys` (
  `toyid` int(10) NOT NULL,
  `index` int(2) NOT NULL,
  `tbone` int(2) NOT NULL,
  `tx` float NOT NULL,
  `ty` float NOT NULL,
  `tz` float NOT NULL,
  `rtx` float NOT NULL,
  `rty` float NOT NULL,
  `rtz` float NOT NULL,
  `tsx` float NOT NULL,
  `tsy` float NOT NULL,
  `tsz` float NOT NULL,
  `cid` int(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `friends`
--

CREATE TABLE `friends` (
  `fid` int(20) NOT NULL,
  `alpha` int(20) NOT NULL,
  `beta` int(20) NOT NULL,
  `alphaname` varchar(20) NOT NULL DEFAULT '',
  `betaname` varchar(20) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Triggers `friends`
--
DELIMITER $$
CREATE TRIGGER `friend_added` BEFORE INSERT ON `friends` FOR EACH ROW BEGIN

   SET NEW.alphaname = (select playerbase.name from playerbase where playerbase.id = NEW.alpha);
   SET NEW.betaname = (select playerbase.name from playerbase where playerbase.id = NEW.beta);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `name_logs`
--

CREATE TABLE `name_logs` (
  `id` int(16) NOT NULL,
  `accountid` int(20) NOT NULL,
  `approvedby` int(24) NOT NULL,
  `new_name` varchar(24) NOT NULL,
  `old_name` varchar(24) NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `playerbase`
--

CREATE TABLE `playerbase` (
  `id` int(16) NOT NULL,
  `name` varchar(25) DEFAULT NULL,
  `ip` varchar(16) DEFAULT NULL,
  `pass` varchar(129) DEFAULT NULL,
  `score` int(20) DEFAULT '50',
  `money` int(20) DEFAULT '0',
  `adminlvl` int(2) DEFAULT '0',
  `helper` int(2) DEFAULT '0',
  `vip` int(2) DEFAULT '0',
  `kills` int(20) DEFAULT '0',
  `deaths` int(20) DEFAULT '0',
  `medkit` int(2) DEFAULT '0',
  `armourpack` int(2) DEFAULT '0',
  `gps` tinyint(4) NOT NULL DEFAULT '0',
  `license` tinyint(4) NOT NULL DEFAULT '1',
  `laston` varchar(30) DEFAULT '',
  `hours` int(10) DEFAULT '0',
  `ddm` int(10) DEFAULT '0',
  `dcbdm` int(10) DEFAULT '0',
  `dsdm` int(10) DEFAULT '0',
  `minutes` int(10) DEFAULT '0',
  `seconds` int(10) DEFAULT '0',
  `skin` int(3) DEFAULT '0',
  `useskin` tinyint(2) DEFAULT '0',
  `inclan` int(10) DEFAULT '-1',
  `clanlead` int(10) DEFAULT '-1',
  `clanown` int(10) DEFAULT '-1',
  `head` bigint(16) DEFAULT '0',
  `warnings` int(10) NOT NULL DEFAULT '0',
  `jailtime` int(10) NOT NULL DEFAULT '0',
  `dmusickit` int(10) NOT NULL DEFAULT '0',
  `clancoown` int(2) NOT NULL DEFAULT '0',
  `crank` int(10) NOT NULL DEFAULT '0',
  `XP` int(10) NOT NULL DEFAULT '0',
  `classes` varchar(20) NOT NULL DEFAULT '0',
  `VPB` float NOT NULL,
  `spectds` int(2) NOT NULL DEFAULT '1',
  `cmdtds` int(2) NOT NULL DEFAULT '1',
  `lastip` varchar(16) NOT NULL DEFAULT 'Not available',
  `gpci` varchar(128) NOT NULL DEFAULT 'Not available',
  `acnotification` int(2) NOT NULL DEFAULT '1',
  `mute` int(32) NOT NULL DEFAULT '0',
  `namekey` int(2) NOT NULL DEFAULT '0',
  `vipjoin` int(2) NOT NULL DEFAULT '1',
  `quests` varchar(5) NOT NULL DEFAULT '0',
  `spvip` int(3) NOT NULL,
  `spscr` int(3) NOT NULL,
  `toggles` varchar(20) NOT NULL DEFAULT '10111111',
  `dtxt` varchar(17) NOT NULL,
  `qp` varchar(11) NOT NULL,
  `stm` int(2) NOT NULL DEFAULT '0',
  `pst` varchar(4) NOT NULL DEFAULT '000'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `pubgpickups`
--

CREATE TABLE `pubgpickups` (
  `id` int(10) NOT NULL,
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tournament`
--

CREATE TABLE `tournament` (
  `TID` int(20) NOT NULL,
  `WINNER` int(20) NOT NULL DEFAULT '-1',
  `ON` int(2) NOT NULL DEFAULT '1',
  `PHASE` int(10) NOT NULL,
  `IT` int(11) NOT NULL,
  `MAX` int(11) NOT NULL,
  `QT1_0` int(11) NOT NULL DEFAULT '-1',
  `QT1_1` int(11) NOT NULL DEFAULT '-1',
  `QT1_2` int(11) NOT NULL DEFAULT '-1',
  `QT1_3` int(11) NOT NULL DEFAULT '-1',
  `QT2_0` int(11) NOT NULL DEFAULT '-1',
  `QT2_1` int(11) NOT NULL DEFAULT '-1',
  `QT2_2` int(11) NOT NULL DEFAULT '-1',
  `QT2_3` int(11) NOT NULL DEFAULT '-1',
  `ST1_0` int(11) NOT NULL DEFAULT '-1',
  `ST1_1` int(11) NOT NULL DEFAULT '-1',
  `ST2_0` int(11) NOT NULL DEFAULT '-1',
  `ST2_1` int(11) NOT NULL DEFAULT '-1',
  `FT1` int(11) NOT NULL DEFAULT '-1',
  `FT2` int(11) NOT NULL DEFAULT '-1',
  `TTAG_0` varchar(6) NOT NULL DEFAULT '',
  `TTAG_1` varchar(6) NOT NULL DEFAULT '',
  `TTAG_2` varchar(6) NOT NULL DEFAULT '',
  `TTAG_3` varchar(6) NOT NULL DEFAULT '',
  `TTAG_4` varchar(6) NOT NULL DEFAULT '',
  `TTAG_5` varchar(6) NOT NULL DEFAULT '',
  `TTAG_6` varchar(6) NOT NULL DEFAULT '',
  `TTAG_7` varchar(6) NOT NULL DEFAULT '',
  `STAG_0` varchar(6) NOT NULL DEFAULT '?',
  `STAG_1` varchar(6) NOT NULL DEFAULT '?',
  `STAG_2` varchar(6) NOT NULL DEFAULT '?',
  `STAG_3` varchar(6) NOT NULL DEFAULT '?',
  `FTAG_1` varchar(6) NOT NULL DEFAULT '?',
  `FTAG_2` varchar(6) NOT NULL DEFAULT '?',
  `CM` int(20) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`accid`);

--
-- Indexes for table `bans`
--
ALTER TABLE `bans`
  ADD PRIMARY KEY (`bid`);

--
-- Indexes for table `clanhistory`
--
ALTER TABLE `clanhistory`
  ADD PRIMARY KEY (`hid`);

--
-- Indexes for table `clans`
--
ALTER TABLE `clans`
  ADD PRIMARY KEY (`cid`);

--
-- Indexes for table `clantoys`
--
ALTER TABLE `clantoys`
  ADD PRIMARY KEY (`toyid`);

--
-- Indexes for table `friends`
--
ALTER TABLE `friends`
  ADD PRIMARY KEY (`fid`);

--
-- Indexes for table `name_logs`
--
ALTER TABLE `name_logs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `accountid_2` (`old_name`);

--
-- Indexes for table `playerbase`
--
ALTER TABLE `playerbase`
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `pubgpickups`
--
ALTER TABLE `pubgpickups`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tournament`
--
ALTER TABLE `tournament`
  ADD PRIMARY KEY (`TID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `accid` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1319275;

--
-- AUTO_INCREMENT for table `bans`
--
ALTER TABLE `bans`
  MODIFY `bid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=191826;

--
-- AUTO_INCREMENT for table `clanhistory`
--
ALTER TABLE `clanhistory`
  MODIFY `hid` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5410;

--
-- AUTO_INCREMENT for table `clans`
--
ALTER TABLE `clans`
  MODIFY `cid` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1757;

--
-- AUTO_INCREMENT for table `clantoys`
--
ALTER TABLE `clantoys`
  MODIFY `toyid` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT for table `friends`
--
ALTER TABLE `friends`
  MODIFY `fid` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=621;

--
-- AUTO_INCREMENT for table `name_logs`
--
ALTER TABLE `name_logs`
  MODIFY `id` int(16) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5197;

--
-- AUTO_INCREMENT for table `playerbase`
--
ALTER TABLE `playerbase`
  MODIFY `id` int(16) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1657663;

--
-- AUTO_INCREMENT for table `pubgpickups`
--
ALTER TABLE `pubgpickups`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=860;

--
-- AUTO_INCREMENT for table `tournament`
--
ALTER TABLE `tournament`
  MODIFY `TID` int(20) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
