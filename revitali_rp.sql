-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 23, 2022 at 10:38 AM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 7.3.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `revitali_rp`
--

-- --------------------------------------------------------

--
-- Table structure for table `911calls`
--

CREATE TABLE `911calls` (
  `ID` int(11) NOT NULL,
  `IssuerName` varchar(24) NOT NULL,
  `IssuerID` int(12) NOT NULL DEFAULT 0,
  `Reason` varchar(64) NOT NULL,
  `Type` int(3) NOT NULL DEFAULT 0,
  `Sector` int(3) NOT NULL DEFAULT 0,
  `Number` int(5) NOT NULL DEFAULT 0,
  `Time` int(12) NOT NULL DEFAULT 0,
  `Location` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `actors`
--

CREATE TABLE `actors` (
  `ID` int(12) NOT NULL,
  `Skin` int(3) NOT NULL DEFAULT 1,
  `Anim` int(4) NOT NULL DEFAULT 0,
  `PosX` float NOT NULL DEFAULT 0,
  `PosY` float NOT NULL DEFAULT 0,
  `PosZ` float NOT NULL DEFAULT 0,
  `PosA` float NOT NULL DEFAULT 0,
  `Name` varchar(24) CHARACTER SET latin1 NOT NULL,
  `World` int(4) NOT NULL DEFAULT 0,
  `Interior` int(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `arrest`
--

CREATE TABLE `arrest` (
  `id` int(8) NOT NULL,
  `owner` int(8) NOT NULL DEFAULT 0,
  `fine` int(8) NOT NULL DEFAULT 0,
  `reason` varchar(64) NOT NULL,
  `date` varchar(40) NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `atm`
--

CREATE TABLE `atm` (
  `atmID` int(11) NOT NULL,
  `atmX` float NOT NULL,
  `atmY` float NOT NULL,
  `atmZ` float NOT NULL,
  `atmA` float NOT NULL DEFAULT 0,
  `atmInterior` int(11) NOT NULL,
  `atmWorld` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `business`
--

CREATE TABLE `business` (
  `bizID` int(12) NOT NULL,
  `bizName` varchar(32) NOT NULL DEFAULT 'None Business',
  `bizOwner` int(12) NOT NULL DEFAULT -1,
  `bizExtX` float NOT NULL DEFAULT 0,
  `bizExtY` float NOT NULL DEFAULT 0,
  `bizExtZ` float NOT NULL DEFAULT 0,
  `bizIntX` float NOT NULL DEFAULT 0,
  `bizIntY` float NOT NULL DEFAULT 0,
  `bizIntZ` float NOT NULL DEFAULT 0,
  `bizProduct1` int(5) NOT NULL DEFAULT 0,
  `bizProduct2` int(5) NOT NULL DEFAULT 0,
  `bizProduct3` int(5) NOT NULL DEFAULT 0,
  `bizProduct4` int(5) NOT NULL DEFAULT 0,
  `bizProduct5` int(5) NOT NULL DEFAULT 0,
  `bizProduct6` int(5) NOT NULL DEFAULT 0,
  `bizProduct7` int(5) NOT NULL DEFAULT 0,
  `bizWorld` int(8) NOT NULL DEFAULT 0,
  `bizInterior` int(8) NOT NULL DEFAULT 0,
  `bizPrice` int(8) NOT NULL DEFAULT 0,
  `bizVault` int(8) NOT NULL DEFAULT 0,
  `bizStock` int(8) NOT NULL DEFAULT 0,
  `bizFuel` int(8) NOT NULL DEFAULT 0,
  `bizType` int(6) NOT NULL DEFAULT 0,
  `bizOwnerName` varchar(64) NOT NULL DEFAULT 'None',
  `bizProdName1` varchar(24) NOT NULL DEFAULT 'None',
  `bizProdName2` varchar(24) NOT NULL DEFAULT 'None',
  `bizProdName3` varchar(24) NOT NULL DEFAULT 'None',
  `bizProdName4` varchar(24) NOT NULL DEFAULT 'None',
  `bizProdName5` varchar(24) NOT NULL DEFAULT 'None',
  `bizProdName6` varchar(24) NOT NULL DEFAULT 'None',
  `bizProdName7` varchar(24) NOT NULL DEFAULT 'None',
  `bizDeliverX` float NOT NULL DEFAULT 0,
  `bizDeliverY` float NOT NULL DEFAULT 0,
  `bizDeliverZ` float NOT NULL DEFAULT 0,
  `bizCargo` int(6) NOT NULL DEFAULT 1000,
  `bizFuelX` float NOT NULL DEFAULT 0,
  `bizFuelY` float NOT NULL DEFAULT 0,
  `bizFuelZ` float NOT NULL DEFAULT 0,
  `bizDiesel` int(7) NOT NULL DEFAULT 0,
  `bizLocked` int(3) NOT NULL DEFAULT 0,
  `bizDescription1` varchar(40) NOT NULL DEFAULT 'No description',
  `bizDescription2` varchar(40) NOT NULL DEFAULT 'No description',
  `bizDescription3` varchar(40) NOT NULL DEFAULT 'No description',
  `bizDescription4` varchar(40) NOT NULL DEFAULT 'No description',
  `bizDescription5` varchar(40) NOT NULL DEFAULT 'No description',
  `bizDescription6` varchar(40) NOT NULL DEFAULT 'No description',
  `bizDescription7` varchar(40) NOT NULL DEFAULT 'No description'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `characters`
--

CREATE TABLE `characters` (
  `pID` int(12) NOT NULL,
  `Name` varchar(64) NOT NULL,
  `PosX` float NOT NULL DEFAULT 0,
  `PosY` float NOT NULL DEFAULT 0,
  `PosZ` float NOT NULL DEFAULT 0,
  `Health` float NOT NULL DEFAULT 100,
  `Interior` int(8) NOT NULL DEFAULT 0,
  `World` int(8) NOT NULL DEFAULT 0,
  `UCP` varchar(22) NOT NULL,
  `Age` int(5) NOT NULL DEFAULT 0,
  `Origin` varchar(22) NOT NULL DEFAULT '',
  `Gender` int(3) NOT NULL DEFAULT 0,
  `Skin` int(4) NOT NULL DEFAULT 0,
  `Hunger` int(8) NOT NULL DEFAULT 100,
  `AdminLevel` int(5) NOT NULL DEFAULT 0,
  `InBiz` int(8) NOT NULL DEFAULT 0,
  `Money` int(12) NOT NULL DEFAULT 0,
  `Thirst` int(8) NOT NULL DEFAULT 100,
  `Job` int(4) NOT NULL DEFAULT 0,
  `Gun1` int(6) NOT NULL DEFAULT 0,
  `Gun2` int(6) NOT NULL DEFAULT 0,
  `Gun3` int(6) NOT NULL DEFAULT 0,
  `Gun4` int(6) NOT NULL DEFAULT 0,
  `Gun5` int(6) NOT NULL DEFAULT 0,
  `Gun6` int(6) NOT NULL DEFAULT 0,
  `Gun7` int(6) NOT NULL DEFAULT 0,
  `Gun8` int(6) NOT NULL DEFAULT 0,
  `Gun9` int(6) NOT NULL DEFAULT 0,
  `Gun10` int(6) NOT NULL DEFAULT 0,
  `Gun11` int(6) NOT NULL DEFAULT 0,
  `Gun12` int(6) NOT NULL DEFAULT 0,
  `Gun13` int(6) NOT NULL DEFAULT 0,
  `Ammo1` int(6) NOT NULL DEFAULT 0,
  `Ammo2` int(6) NOT NULL DEFAULT 0,
  `Ammo3` int(6) NOT NULL DEFAULT 0,
  `Ammo4` int(6) NOT NULL DEFAULT 0,
  `Ammo5` int(6) NOT NULL DEFAULT 0,
  `Ammo6` int(6) NOT NULL DEFAULT 0,
  `Ammo7` int(6) NOT NULL DEFAULT 0,
  `Ammo8` int(6) NOT NULL DEFAULT 0,
  `Ammo9` int(6) NOT NULL DEFAULT 0,
  `Ammo10` int(6) NOT NULL DEFAULT 0,
  `Ammo11` int(6) NOT NULL DEFAULT 0,
  `Ammo12` int(6) NOT NULL DEFAULT 0,
  `Ammo13` int(6) NOT NULL DEFAULT 0,
  `Durability1` int(6) NOT NULL DEFAULT 0,
  `Durability2` int(6) NOT NULL DEFAULT 0,
  `Durability3` int(6) NOT NULL DEFAULT 0,
  `Durability4` int(6) NOT NULL DEFAULT 0,
  `Durability5` int(6) NOT NULL DEFAULT 0,
  `Durability6` int(6) NOT NULL DEFAULT 0,
  `Durability7` int(6) NOT NULL,
  `Durability8` int(6) NOT NULL,
  `Durability9` int(6) NOT NULL,
  `Durability10` int(6) NOT NULL DEFAULT 0,
  `Durability11` int(6) NOT NULL DEFAULT 0,
  `Durability12` int(6) NOT NULL DEFAULT 0,
  `Durability13` int(6) NOT NULL DEFAULT 0,
  `Number` int(6) NOT NULL DEFAULT 0,
  `Faction` int(6) NOT NULL DEFAULT -1,
  `FactionID` int(6) NOT NULL DEFAULT -1,
  `FactionRank` int(6) NOT NULL DEFAULT -1,
  `FactionSkin` int(5) NOT NULL DEFAULT 0,
  `Onduty` int(2) NOT NULL DEFAULT 0,
  `Birthdate` varchar(32) NOT NULL DEFAULT '',
  `Armor` float NOT NULL DEFAULT 0,
  `Salary` int(8) NOT NULL DEFAULT 0,
  `Bank` int(8) NOT NULL DEFAULT 0,
  `InDoor` int(7) NOT NULL DEFAULT -1,
  `Arrest` int(3) NOT NULL DEFAULT 0,
  `JailTime` int(8) NOT NULL DEFAULT 0,
  `JailReason` varchar(32) NOT NULL,
  `JailBy` varchar(24) NOT NULL,
  `Injured` int(3) NOT NULL DEFAULT 0,
  `BusDelay` int(5) NOT NULL DEFAULT 0,
  `SweeperDelay` int(5) NOT NULL DEFAULT 0,
  `Credit` int(8) NOT NULL DEFAULT 0,
  `Healthy` float NOT NULL DEFAULT 100,
  `Head` float NOT NULL DEFAULT 100,
  `RightArm` float NOT NULL DEFAULT 100,
  `LeftArm` float NOT NULL DEFAULT 100,
  `Torso` float NOT NULL DEFAULT 100,
  `RightLeg` float NOT NULL DEFAULT 100,
  `LeftLeg` float NOT NULL DEFAULT 100,
  `Groin` float NOT NULL DEFAULT 100,
  `MaskID` int(6) NOT NULL DEFAULT 0,
  `Exp` int(8) NOT NULL DEFAULT 0,
  `Level` int(8) NOT NULL DEFAULT 1,
  `Minute` int(2) NOT NULL,
  `Second` int(2) NOT NULL,
  `Hour` int(8) NOT NULL,
  `Paycheck` int(5) NOT NULL,
  `InHouse` int(8) NOT NULL DEFAULT -1,
  `Quitjob` int(3) NOT NULL DEFAULT 0,
  `Channel` int(5) NOT NULL DEFAULT 0,
  `Funds` int(3) NOT NULL DEFAULT 0,
  `Bullet1` int(6) NOT NULL DEFAULT 0,
  `Bullet2` int(6) NOT NULL DEFAULT 0,
  `Bullet3` int(6) NOT NULL DEFAULT 0,
  `Bullet4` int(6) NOT NULL DEFAULT 0,
  `Bullet5` int(6) NOT NULL DEFAULT 0,
  `Bullet6` int(6) NOT NULL DEFAULT 0,
  `Bullet7` int(6) NOT NULL DEFAULT 0,
  `DrivingLicense` int(3) NOT NULL DEFAULT 0,
  `FishDelay` int(4) NOT NULL DEFAULT 0,
  `Fish1` float NOT NULL DEFAULT 0,
  `Fish2` float NOT NULL DEFAULT 0,
  `Fish3` float NOT NULL DEFAULT 0,
  `Fish4` float NOT NULL DEFAULT 0,
  `Fish5` float NOT NULL DEFAULT 0,
  `Fish6` float NOT NULL DEFAULT 0,
  `Fish7` float NOT NULL DEFAULT 0,
  `Fish8` float NOT NULL DEFAULT 0,
  `Fish9` float NOT NULL DEFAULT 0,
  `Fish10` float NOT NULL DEFAULT 0,
  `FishName1` varchar(24) NOT NULL DEFAULT 'Empty',
  `FishName2` varchar(24) NOT NULL DEFAULT 'Empty',
  `FishName3` varchar(24) NOT NULL DEFAULT 'Empty',
  `FishName4` varchar(24) NOT NULL DEFAULT 'Empty',
  `FishName5` varchar(24) NOT NULL DEFAULT 'Empty',
  `FishName6` varchar(24) NOT NULL DEFAULT 'Empty',
  `FishName7` varchar(24) NOT NULL DEFAULT 'Empty',
  `FishName8` varchar(24) NOT NULL DEFAULT 'Empty',
  `FishName9` varchar(24) NOT NULL DEFAULT 'Empty',
  `FishName10` varchar(24) NOT NULL DEFAULT 'Empty'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `ID` int(12) DEFAULT 0,
  `contactID` int(12) NOT NULL,
  `contactName` varchar(32) DEFAULT NULL,
  `contactNumber` int(12) DEFAULT 0,
  `contactOwner` int(12) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `crates`
--

CREATE TABLE `crates` (
  `ID` int(12) NOT NULL,
  `Type` int(5) NOT NULL DEFAULT 0,
  `Vehicle` int(12) NOT NULL DEFAULT -1
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `dealer`
--

CREATE TABLE `dealer` (
  `ID` int(12) NOT NULL,
  `Owner` int(8) NOT NULL DEFAULT -1,
  `PosX` float NOT NULL DEFAULT 0,
  `PosY` float NOT NULL DEFAULT 0,
  `PosZ` float NOT NULL DEFAULT 0,
  `SpawnX` float NOT NULL DEFAULT 0,
  `SpawnY` float NOT NULL DEFAULT 0,
  `SpawnZ` float NOT NULL DEFAULT 0,
  `SpawnA` float NOT NULL DEFAULT 0,
  `Name` varchar(24) NOT NULL DEFAULT 'Undefined',
  `Stock` int(5) NOT NULL DEFAULT 0,
  `Vehicle1` int(11) NOT NULL DEFAULT 0,
  `Vehicle2` int(11) NOT NULL DEFAULT 0,
  `Vehicle3` int(11) NOT NULL DEFAULT 0,
  `Vehicle4` int(11) NOT NULL DEFAULT 0,
  `Vehicle5` int(11) NOT NULL DEFAULT 0,
  `Vehicle6` int(11) NOT NULL DEFAULT 0,
  `Price` int(4) NOT NULL DEFAULT 0,
  `Cost1` int(5) NOT NULL DEFAULT 0,
  `Cost2` int(5) NOT NULL DEFAULT 0,
  `Cost3` int(5) NOT NULL DEFAULT 0,
  `Cost4` int(5) NOT NULL DEFAULT 0,
  `Cost5` int(5) NOT NULL DEFAULT 0,
  `Cost6` int(5) NOT NULL DEFAULT 0,
  `Stock1` int(5) NOT NULL DEFAULT 0,
  `Stock2` int(5) NOT NULL DEFAULT 0,
  `Stock3` int(5) NOT NULL DEFAULT 0,
  `Stock4` int(5) NOT NULL DEFAULT 0,
  `Stock5` int(5) NOT NULL DEFAULT 0,
  `Stock6` int(5) NOT NULL DEFAULT 0,
  `Vault` int(8) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `dropped`
--

CREATE TABLE `dropped` (
  `ID` int(12) NOT NULL,
  `itemName` varchar(32) DEFAULT NULL,
  `itemModel` int(12) DEFAULT 0,
  `itemX` float DEFAULT 0,
  `itemY` float DEFAULT 0,
  `itemZ` float DEFAULT 0,
  `itemInt` int(12) DEFAULT 0,
  `itemWorld` int(12) DEFAULT 0,
  `itemQuantity` int(12) DEFAULT 0,
  `itemAmmo` int(12) DEFAULT 0,
  `itemWeapon` int(12) DEFAULT 0,
  `itemPlayer` varchar(24) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `factions`
--

CREATE TABLE `factions` (
  `factionID` int(12) NOT NULL,
  `factionName` varchar(32) DEFAULT NULL,
  `factionColor` int(12) DEFAULT 0,
  `factionType` int(12) DEFAULT 0,
  `factionRanks` int(12) DEFAULT 0,
  `factionLockerX` float DEFAULT 0,
  `factionLockerY` float DEFAULT 0,
  `factionLockerZ` float DEFAULT 0,
  `factionLockerInt` int(12) DEFAULT 0,
  `factionLockerWorld` int(12) DEFAULT 0,
  `factionWeapon1` int(12) DEFAULT 0,
  `factionAmmo1` int(12) DEFAULT 0,
  `factionWeapon2` int(12) DEFAULT 0,
  `factionAmmo2` int(12) DEFAULT 0,
  `factionWeapon3` int(12) DEFAULT 0,
  `factionAmmo3` int(12) DEFAULT 0,
  `factionWeapon4` int(12) DEFAULT 0,
  `factionAmmo4` int(12) DEFAULT 0,
  `factionWeapon5` int(12) DEFAULT 0,
  `factionAmmo5` int(12) DEFAULT 0,
  `factionWeapon6` int(12) DEFAULT 0,
  `factionAmmo6` int(12) DEFAULT 0,
  `factionWeapon7` int(12) DEFAULT 0,
  `factionAmmo7` int(12) DEFAULT 0,
  `factionWeapon8` int(12) DEFAULT 0,
  `factionAmmo8` int(12) DEFAULT 0,
  `factionWeapon9` int(12) DEFAULT 0,
  `factionAmmo9` int(12) DEFAULT 0,
  `factionWeapon10` int(12) DEFAULT 0,
  `factionAmmo10` int(12) DEFAULT 0,
  `factionRank1` varchar(32) DEFAULT NULL,
  `factionRank2` varchar(32) DEFAULT NULL,
  `factionRank3` varchar(32) DEFAULT NULL,
  `factionRank4` varchar(32) DEFAULT NULL,
  `factionRank5` varchar(32) DEFAULT NULL,
  `factionRank6` varchar(32) DEFAULT NULL,
  `factionRank7` varchar(32) DEFAULT NULL,
  `factionRank8` varchar(32) DEFAULT NULL,
  `factionRank9` varchar(32) DEFAULT NULL,
  `factionRank10` varchar(32) DEFAULT NULL,
  `factionRank11` varchar(32) DEFAULT NULL,
  `factionRank12` varchar(32) DEFAULT NULL,
  `factionRank13` varchar(32) DEFAULT NULL,
  `factionRank14` varchar(32) DEFAULT NULL,
  `factionRank15` varchar(32) DEFAULT NULL,
  `factionSkin1` int(12) DEFAULT 0,
  `factionSkin2` int(12) DEFAULT 0,
  `factionSkin3` int(12) DEFAULT 0,
  `factionSkin4` int(12) DEFAULT 0,
  `factionSkin5` int(12) DEFAULT 0,
  `factionSkin6` int(12) DEFAULT 0,
  `factionSkin7` int(12) DEFAULT 0,
  `factionSkin8` int(12) DEFAULT 0,
  `SpawnX` float NOT NULL,
  `SpawnY` float NOT NULL,
  `SpawnZ` float NOT NULL,
  `SpawnInterior` int(11) NOT NULL,
  `SpawnVW` int(1) NOT NULL,
  `factionDurability1` int(7) NOT NULL DEFAULT 0,
  `factionDurability2` int(7) NOT NULL DEFAULT 0,
  `factionDurability3` int(7) NOT NULL DEFAULT 0,
  `factionDurability4` int(7) NOT NULL DEFAULT 0,
  `factionDurability5` int(7) NOT NULL DEFAULT 0,
  `factionDurability6` int(7) NOT NULL DEFAULT 0,
  `factionDurability7` int(7) NOT NULL DEFAULT 0,
  `factionDurability8` int(7) NOT NULL DEFAULT 0,
  `factionDurability9` int(7) NOT NULL DEFAULT 0,
  `factionDurability10` int(7) NOT NULL DEFAULT 0,
  `factionSalary1` int(5) NOT NULL DEFAULT 0,
  `factionSalary2` int(5) NOT NULL DEFAULT 0,
  `factionSalary3` int(5) NOT NULL DEFAULT 0,
  `factionSalary4` int(5) NOT NULL DEFAULT 0,
  `factionSalary5` int(5) NOT NULL DEFAULT 0,
  `factionSalary6` int(5) NOT NULL DEFAULT 0,
  `factionSalary7` int(5) NOT NULL DEFAULT 0,
  `factionSalary8` int(5) NOT NULL DEFAULT 0,
  `factionSalary9` int(5) NOT NULL DEFAULT 0,
  `factionSalary10` int(5) NOT NULL DEFAULT 0,
  `factionSalary11` int(5) NOT NULL DEFAULT 0,
  `factionSalary12` int(5) NOT NULL DEFAULT 0,
  `factionSalary13` int(5) NOT NULL DEFAULT 0,
  `factionSalary14` int(5) NOT NULL DEFAULT 0,
  `factionSalary15` int(5) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `factions`
--

INSERT INTO `factions` (`factionID`, `factionName`, `factionColor`, `factionType`, `factionRanks`, `factionLockerX`, `factionLockerY`, `factionLockerZ`, `factionLockerInt`, `factionLockerWorld`, `factionWeapon1`, `factionAmmo1`, `factionWeapon2`, `factionAmmo2`, `factionWeapon3`, `factionAmmo3`, `factionWeapon4`, `factionAmmo4`, `factionWeapon5`, `factionAmmo5`, `factionWeapon6`, `factionAmmo6`, `factionWeapon7`, `factionAmmo7`, `factionWeapon8`, `factionAmmo8`, `factionWeapon9`, `factionAmmo9`, `factionWeapon10`, `factionAmmo10`, `factionRank1`, `factionRank2`, `factionRank3`, `factionRank4`, `factionRank5`, `factionRank6`, `factionRank7`, `factionRank8`, `factionRank9`, `factionRank10`, `factionRank11`, `factionRank12`, `factionRank13`, `factionRank14`, `factionRank15`, `factionSkin1`, `factionSkin2`, `factionSkin3`, `factionSkin4`, `factionSkin5`, `factionSkin6`, `factionSkin7`, `factionSkin8`, `SpawnX`, `SpawnY`, `SpawnZ`, `SpawnInterior`, `SpawnVW`, `factionDurability1`, `factionDurability2`, `factionDurability3`, `factionDurability4`, `factionDurability5`, `factionDurability6`, `factionDurability7`, `factionDurability8`, `factionDurability9`, `factionDurability10`, `factionSalary1`, `factionSalary2`, `factionSalary3`, `factionSalary4`, `factionSalary5`, `factionSalary6`, `factionSalary7`, `factionSalary8`, `factionSalary9`, `factionSalary10`, `factionSalary11`, `factionSalary12`, `factionSalary13`, `factionSalary14`, `factionSalary15`) VALUES
(2, 'Los Santos Police Departement', 641859072, 1, 10, -563.269, 478.326, 1369.41, 0, 0, 24, 300, 29, 500, 25, 150, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Police Officer I', 'Police Officer II', 'Police Officer III', 'Sergeant I', 'Sergeant II', 'Lieutenant', 'Captain', 'Commander', 'Deputy Chief of Police', 'Chief of Police', 'Commisioner', 'Rank 12', 'Rank 13', 'Rank 14', 'Rank 15', 280, 281, 265, 266, 267, 282, 306, 309, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10000, 11000, 13000, 15000, 16000, 18000, 20000, 21000, 22500, 24000, 20000, 0, 0, 0, 0),
(3, 'Los Santos Emergency Service', -8224256, 3, 10, 1268.92, -1305.97, 1061.14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Cadet', 'Fellow', 'EMT Intermediate', 'Junior Paramedic', 'Senior Paramedic', 'Attending Physician', 'District Executive', 'Assistant Chief', 'Deputy Chief of LSES', 'Chief of LSES', 'Rank 11', 'Rank 12', 'Rank 13', 'Rank 14', 'Rank 15', 274, 275, 276, 277, 278, 308, 141, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10000, 12000, 15000, 16000, 17000, 18000, 19000, 20000, 22000, 25000, 0, 0, 0, 0, 0),
(4, 'Los Santos News', 77361408, 2, 10, 172.907, 137.465, 1003.03, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Staff', 'Senior Staff', 'Supervisor I', 'Supervisor II', 'Head of Operational Staff', 'Manager Divisions', 'General Manager', 'Vice CEO', 'CEO', 'Commisioner', 'Rank 11', 'Rank 12', 'Rank 13', 'Rank 14', 'Rank 15', 240, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 12000, 13000, 14000, 15000, 17000, 18000, 20000, 23000, 25000, 27500, 0, 0, 0, 0, 0),
(5, 'Los Santos Government', -793842689, 4, 5, 2118.36, 756.531, 97.2449, 20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Rank 1', 'Rank 2', 'Rank 3', 'Rank 4', 'Rank 5', 'Rank 6', 'Rank 7', 'Rank 8', 'Rank 9', 'Rank 10', 'Rank 11', 'Rank 12', 'Rank 13', 'Rank 14', 'Rank 15', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `factionvehicle`
--

CREATE TABLE `factionvehicle` (
  `ID` int(12) NOT NULL,
  `Model` int(6) NOT NULL DEFAULT 0,
  `PosX` float NOT NULL DEFAULT 0,
  `PosY` float NOT NULL DEFAULT 0,
  `PosZ` float NOT NULL DEFAULT 0,
  `PosA` float NOT NULL DEFAULT 0,
  `Color1` int(4) NOT NULL DEFAULT 0,
  `Color2` int(4) NOT NULL DEFAULT 0,
  `Faction` int(7) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `furniture`
--

CREATE TABLE `furniture` (
  `ID` int(12) DEFAULT 0,
  `furnitureID` int(12) NOT NULL,
  `furnitureName` varchar(32) DEFAULT NULL,
  `furnitureModel` int(12) DEFAULT 0,
  `furnitureX` float DEFAULT 0,
  `furnitureY` float DEFAULT 0,
  `furnitureZ` float DEFAULT 0,
  `furnitureRX` float DEFAULT 0,
  `furnitureRY` float DEFAULT 0,
  `furnitureRZ` float DEFAULT 0,
  `furnitureType` int(12) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `gates`
--

CREATE TABLE `gates` (
  `gateID` int(12) NOT NULL,
  `gateModel` int(12) DEFAULT 0,
  `gateSpeed` float DEFAULT 0,
  `gateTime` int(12) DEFAULT 0,
  `gateX` float DEFAULT 0,
  `gateY` float DEFAULT 0,
  `gateZ` float DEFAULT 0,
  `gateRX` float DEFAULT 0,
  `gateRY` float DEFAULT 0,
  `gateRZ` float DEFAULT 0,
  `gateInterior` int(12) DEFAULT 0,
  `gateWorld` int(12) DEFAULT 0,
  `gateMoveX` float DEFAULT 0,
  `gateMoveY` float DEFAULT 0,
  `gateMoveZ` float DEFAULT 0,
  `gateMoveRX` float DEFAULT 0,
  `gateMoveRY` float DEFAULT 0,
  `gateMoveRZ` float DEFAULT 0,
  `gateLinkID` int(12) DEFAULT 0,
  `gateFaction` int(12) DEFAULT 0,
  `gatePass` varchar(32) DEFAULT NULL,
  `gateRadius` float DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `houses`
--

CREATE TABLE `houses` (
  `houseID` int(12) NOT NULL,
  `houseOwner` int(12) DEFAULT 0,
  `housePrice` int(12) DEFAULT 0,
  `houseAddress` varchar(32) DEFAULT NULL,
  `housePosX` float DEFAULT 0,
  `housePosY` float DEFAULT 0,
  `housePosZ` float DEFAULT 0,
  `housePosA` float DEFAULT 0,
  `houseIntX` float DEFAULT 0,
  `houseIntY` float DEFAULT 0,
  `houseIntZ` float DEFAULT 0,
  `houseIntA` float DEFAULT 0,
  `houseInterior` int(12) DEFAULT 0,
  `houseExterior` int(12) DEFAULT 0,
  `houseExteriorVW` int(12) DEFAULT 0,
  `houseLocked` int(4) DEFAULT 0,
  `houseWeapon1` int(12) DEFAULT 0,
  `houseAmmo1` int(12) DEFAULT 0,
  `houseWeapon2` int(12) DEFAULT 0,
  `houseAmmo2` int(12) DEFAULT 0,
  `houseWeapon3` int(12) DEFAULT 0,
  `houseAmmo3` int(12) DEFAULT 0,
  `houseWeapon4` int(12) DEFAULT 0,
  `houseAmmo4` int(12) DEFAULT 0,
  `houseWeapon5` int(12) DEFAULT 0,
  `houseAmmo5` int(12) DEFAULT 0,
  `houseWeapon6` int(12) DEFAULT 0,
  `houseAmmo6` int(12) DEFAULT 0,
  `houseWeapon7` int(12) DEFAULT 0,
  `houseAmmo7` int(12) DEFAULT 0,
  `houseWeapon8` int(12) DEFAULT 0,
  `houseAmmo8` int(12) DEFAULT 0,
  `houseWeapon9` int(12) DEFAULT 0,
  `houseAmmo9` int(12) DEFAULT 0,
  `houseWeapon10` int(12) DEFAULT 0,
  `houseAmmo10` int(12) DEFAULT 0,
  `houseMoney` int(12) DEFAULT 0,
  `houseOwnerName` varchar(32) NOT NULL,
  `houseDurability1` int(11) NOT NULL DEFAULT 0,
  `houseDurability2` int(11) NOT NULL DEFAULT 0,
  `houseDurability3` int(11) NOT NULL DEFAULT 0,
  `houseDurability4` int(11) NOT NULL DEFAULT 0,
  `houseDurability5` int(11) NOT NULL DEFAULT 0,
  `houseDurability6` int(11) NOT NULL DEFAULT 0,
  `houseDurability7` int(11) NOT NULL DEFAULT 0,
  `houseDurability8` int(11) NOT NULL DEFAULT 0,
  `houseDurability9` int(11) NOT NULL DEFAULT 0,
  `houseDurability10` int(11) NOT NULL DEFAULT 0,
  `houseSerial1` int(5) NOT NULL DEFAULT 0,
  `houseSerial2` int(5) NOT NULL DEFAULT 0,
  `houseSerial3` int(5) NOT NULL DEFAULT 0,
  `houseSerial4` int(5) NOT NULL DEFAULT 0,
  `houseSerial5` int(5) NOT NULL DEFAULT 0,
  `houseSerial6` int(5) NOT NULL DEFAULT 0,
  `houseSerial7` int(5) NOT NULL DEFAULT 0,
  `houseSerial8` int(5) NOT NULL DEFAULT 0,
  `houseSerial9` int(5) NOT NULL DEFAULT 0,
  `houseSerial10` int(5) NOT NULL DEFAULT 0,
  `housePark` int(3) NOT NULL DEFAULT 0,
  `houseParkX` float NOT NULL DEFAULT 0,
  `houseParkY` float NOT NULL DEFAULT 0,
  `houseParkZ` float NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `housestorage`
--

CREATE TABLE `housestorage` (
  `ID` int(12) DEFAULT 0,
  `itemID` int(12) NOT NULL,
  `itemName` varchar(32) DEFAULT NULL,
  `itemModel` int(12) DEFAULT 0,
  `itemQuantity` int(12) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `inventory`
--

CREATE TABLE `inventory` (
  `ID` int(12) DEFAULT 0,
  `invID` int(12) NOT NULL,
  `invItem` varchar(32) DEFAULT NULL,
  `invModel` int(12) DEFAULT 0,
  `invQuantity` int(12) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `playersalary`
--

CREATE TABLE `playersalary` (
  `id` int(18) NOT NULL,
  `owner` int(12) NOT NULL DEFAULT -1,
  `name` varchar(32) CHARACTER SET latin1 NOT NULL,
  `amount` int(12) NOT NULL DEFAULT 0,
  `date` varchar(40) CHARACTER SET latin1 NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `playerucp`
--

CREATE TABLE `playerucp` (
  `pID` int(12) NOT NULL,
  `UCP` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `code` mediumint(100) NOT NULL,
  `status` text NOT NULL,
  `regdate` varchar(50) NOT NULL DEFAULT 'None',
  `ip` text DEFAULT NULL,
  `nohp` varchar(15) NOT NULL,
  `hide` varchar(100) NOT NULL DEFAULT 'true',
  `Banned` int(3) NOT NULL DEFAULT 0,
  `BannedBy` varchar(24) NOT NULL DEFAULT 'Admin',
  `BannedReason` varchar(32) NOT NULL DEFAULT 'Undefined',
  `BannedTime` int(8) NOT NULL DEFAULT 0,
  `Admin` int(6) NOT NULL DEFAULT 0,
  `Registered` int(8) NOT NULL DEFAULT 0,
  `Active` int(3) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `rental`
--

CREATE TABLE `rental` (
  `ID` int(12) NOT NULL,
  `PosX` float NOT NULL DEFAULT 0,
  `PosY` float NOT NULL DEFAULT 0,
  `PosZ` float NOT NULL DEFAULT 0,
  `SpawnX` float NOT NULL DEFAULT 0,
  `SpawnY` float NOT NULL DEFAULT 0,
  `SpawnZ` float NOT NULL DEFAULT 0,
  `SpawnA` float NOT NULL DEFAULT 0,
  `Vehicle1` int(6) NOT NULL DEFAULT 0,
  `Vehicle2` int(6) NOT NULL DEFAULT 0,
  `Price1` int(6) NOT NULL DEFAULT 0,
  `Price2` int(6) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `samacc`
--

CREATE TABLE `samacc` (
  `ID` int(12) NOT NULL,
  `Username` varchar(24) NOT NULL,
  `Password` varchar(32) NOT NULL,
  `Created` int(3) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `speedcameras`
--

CREATE TABLE `speedcameras` (
  `speedID` int(12) NOT NULL,
  `speedRange` float DEFAULT 0,
  `speedLimit` float DEFAULT 0,
  `speedX` float DEFAULT 0,
  `speedY` float DEFAULT 0,
  `speedZ` float DEFAULT 0,
  `speedAngle` float DEFAULT 0,
  `speedvehicle` int(8) NOT NULL DEFAULT 0,
  `speedplate` varchar(32) NOT NULL,
  `speedTime` int(8) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tags`
--

CREATE TABLE `tags` (
  `ID` int(12) NOT NULL,
  `PosX` float NOT NULL DEFAULT 0,
  `PosY` float NOT NULL DEFAULT 0,
  `PosZ` float NOT NULL DEFAULT 0,
  `RotX` float NOT NULL DEFAULT 0,
  `RotY` float NOT NULL DEFAULT 0,
  `RotZ` float NOT NULL DEFAULT 0,
  `Font` varchar(24) NOT NULL DEFAULT 'Arial',
  `Text` varchar(64) NOT NULL DEFAULT 'None',
  `Size` int(3) NOT NULL DEFAULT 24,
  `Interior` int(4) NOT NULL DEFAULT -1,
  `World` int(4) NOT NULL DEFAULT -1,
  `Bold` int(2) NOT NULL DEFAULT 0,
  `Owner` int(6) NOT NULL DEFAULT -1,
  `Color` int(5) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `tickets`
--

CREATE TABLE `tickets` (
  `ID` int(12) DEFAULT 0,
  `ticketID` int(12) NOT NULL,
  `ticketFee` int(12) DEFAULT 0,
  `ticketBy` varchar(24) DEFAULT NULL,
  `ticketDate` varchar(36) DEFAULT NULL,
  `ticketReason` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `toys`
--

CREATE TABLE `toys` (
  `Id` int(10) NOT NULL,
  `Owner` varchar(40) NOT NULL DEFAULT '',
  `Slot0_Model` int(8) NOT NULL DEFAULT 0,
  `Slot0_Bone` int(8) NOT NULL DEFAULT 0,
  `Slot0_XPos` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot0_YPos` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot0_ZPos` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot0_XRot` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot0_YRot` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot0_ZRot` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot0_XScale` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot0_YScale` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot0_ZScale` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot1_Model` int(8) NOT NULL DEFAULT 0,
  `Slot1_Bone` int(8) NOT NULL DEFAULT 0,
  `Slot1_XPos` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot1_YPos` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot1_ZPos` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot1_XRot` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot1_YRot` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot1_ZRot` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot1_XScale` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot1_YScale` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot1_ZScale` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot2_Model` int(8) NOT NULL DEFAULT 0,
  `Slot2_Bone` int(8) NOT NULL DEFAULT 0,
  `Slot2_XPos` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot2_YPos` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot2_ZPos` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot2_XRot` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot2_YRot` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot2_ZRot` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot2_XScale` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot2_YScale` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot2_ZScale` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot3_Model` int(8) NOT NULL DEFAULT 0,
  `Slot3_Bone` int(8) NOT NULL DEFAULT 0,
  `Slot3_XPos` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot3_YPos` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot3_ZPos` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot3_XRot` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot3_YRot` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot3_ZRot` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot3_XScale` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot3_YScale` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot3_ZScale` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot4_Model` int(8) NOT NULL DEFAULT 0,
  `Slot4_Bone` int(8) NOT NULL DEFAULT 0,
  `Slot4_XPos` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot4_YPos` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot4_ZPos` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot4_XRot` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot4_YRot` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot4_ZRot` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot4_XScale` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot4_YScale` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot4_ZScale` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot5_Model` int(8) NOT NULL DEFAULT 0,
  `Slot5_Bone` int(8) NOT NULL DEFAULT 0,
  `Slot5_XPos` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot5_YPos` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot5_ZPos` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot5_XRot` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot5_YRot` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot5_ZRot` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot5_XScale` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot5_YScale` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot5_ZScale` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot0_Toggle` int(3) NOT NULL DEFAULT 0,
  `Slot1_Toggle` int(3) NOT NULL DEFAULT 0,
  `Slot2_Toggle` int(3) NOT NULL DEFAULT 0,
  `Slot3_Toggle` int(3) NOT NULL DEFAULT 0,
  `Slot4_Toggle` int(3) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `toys`
--

INSERT INTO `toys` (`Id`, `Owner`, `Slot0_Model`, `Slot0_Bone`, `Slot0_XPos`, `Slot0_YPos`, `Slot0_ZPos`, `Slot0_XRot`, `Slot0_YRot`, `Slot0_ZRot`, `Slot0_XScale`, `Slot0_YScale`, `Slot0_ZScale`, `Slot1_Model`, `Slot1_Bone`, `Slot1_XPos`, `Slot1_YPos`, `Slot1_ZPos`, `Slot1_XRot`, `Slot1_YRot`, `Slot1_ZRot`, `Slot1_XScale`, `Slot1_YScale`, `Slot1_ZScale`, `Slot2_Model`, `Slot2_Bone`, `Slot2_XPos`, `Slot2_YPos`, `Slot2_ZPos`, `Slot2_XRot`, `Slot2_YRot`, `Slot2_ZRot`, `Slot2_XScale`, `Slot2_YScale`, `Slot2_ZScale`, `Slot3_Model`, `Slot3_Bone`, `Slot3_XPos`, `Slot3_YPos`, `Slot3_ZPos`, `Slot3_XRot`, `Slot3_YRot`, `Slot3_ZRot`, `Slot3_XScale`, `Slot3_YScale`, `Slot3_ZScale`, `Slot4_Model`, `Slot4_Bone`, `Slot4_XPos`, `Slot4_YPos`, `Slot4_ZPos`, `Slot4_XRot`, `Slot4_YRot`, `Slot4_ZRot`, `Slot4_XScale`, `Slot4_YScale`, `Slot4_ZScale`, `Slot5_Model`, `Slot5_Bone`, `Slot5_XPos`, `Slot5_YPos`, `Slot5_ZPos`, `Slot5_XRot`, `Slot5_YRot`, `Slot5_ZRot`, `Slot5_XScale`, `Slot5_YScale`, `Slot5_ZScale`, `Slot0_Toggle`, `Slot1_Toggle`, `Slot2_Toggle`, `Slot3_Toggle`, `Slot4_Toggle`) VALUES
(1, 'Finn_Xanderz', 0, 0, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0, 0, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0, 0, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0, 0, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0, 0, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0, 0, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0, 0, 0, 0, 0),
(2, 'Leyvon_Caldwell', 0, 0, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0, 0, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0, 0, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0, 0, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0, 0, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0, 0, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `tree`
--

CREATE TABLE `tree` (
  `ID` int(12) NOT NULL,
  `PosX` float NOT NULL DEFAULT 0,
  `PosY` float NOT NULL DEFAULT 0,
  `PosZ` float NOT NULL DEFAULT 0,
  `PosRX` float NOT NULL DEFAULT 0,
  `PosRY` float NOT NULL DEFAULT 0,
  `PosRZ` float NOT NULL DEFAULT 0,
  `Time` int(8) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tree`
--

INSERT INTO `tree` (`ID`, `PosX`, `PosY`, `PosZ`, `PosRX`, `PosRY`, `PosRZ`, `Time`) VALUES
(3, -540.571, -206.313, 77.4663, 0, 0, 171.936, 0),
(4, -565.081, -203.646, 77.7016, 0, 0, 9.40009, 0),
(5, -581.228, -195.234, 78.1952, 0, 0, 233.798, 0),
(6, -388.536, -2584.67, 139.441, 0, 0, 151.888, 0),
(7, -416.407, -2679.04, 160.095, 0, 0, 94.404, 0),
(8, -649.892, -662.138, 40.5864, 0, 0, 94.404, 0),
(9, -529.424, -623.959, 12.7471, 0, 0, 94.404, 0),
(10, -506.712, -1000.8, 24.0474, 0, 0, 94.404, 0),
(11, -526.233, -977.15, 23.5198, 0, 0, 94.404, 0),
(12, -908.493, -505.999, 25.0078, 0, 0, 94.404, 0),
(13, -170.227, -1268.73, 2.18265, 0, 0, 94.404, 0),
(14, 2547.99, -489.042, 84.3173, 0, 0, 94.404, 0),
(15, 2480.92, -526.42, 95.7773, 0, 0, 94.404, 0),
(16, 2381.15, -746.084, 124.737, 0, 0, 94.404, 0),
(17, -116.492, -1111.78, 2.22177, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `vehicle`
--

CREATE TABLE `vehicle` (
  `vehID` int(12) NOT NULL,
  `vehModel` int(6) NOT NULL DEFAULT 0,
  `vehOwner` int(12) NOT NULL DEFAULT 0,
  `vehX` float NOT NULL DEFAULT 0,
  `vehY` float NOT NULL DEFAULT 0,
  `vehZ` float NOT NULL DEFAULT 0,
  `vehA` float NOT NULL DEFAULT 0,
  `vehColor1` int(6) NOT NULL DEFAULT 0,
  `vehColor2` int(6) NOT NULL DEFAULT 0,
  `vehWorld` int(8) NOT NULL DEFAULT 0,
  `vehInterior` int(8) NOT NULL DEFAULT 0,
  `vehFuel` int(8) NOT NULL DEFAULT 0,
  `vehDamage1` int(8) NOT NULL DEFAULT 0,
  `vehDamage2` int(8) NOT NULL DEFAULT 0,
  `vehDamage3` int(8) NOT NULL DEFAULT 0,
  `vehDamage4` int(8) NOT NULL DEFAULT 0,
  `vehHealth` int(11) NOT NULL DEFAULT 1000,
  `vehInsurance` int(8) NOT NULL DEFAULT 0,
  `vehInsuTime` int(12) NOT NULL DEFAULT 0,
  `vehLocked` int(3) NOT NULL DEFAULT 0,
  `vehPlate` varchar(16) NOT NULL DEFAULT 'NONE',
  `vehRental` int(4) NOT NULL DEFAULT -1,
  `vehRentalTime` int(8) NOT NULL DEFAULT 0,
  `vehInsuranced` int(3) NOT NULL DEFAULT 0,
  `vehHouse` int(6) NOT NULL DEFAULT -1,
  `vehWood` int(6) NOT NULL DEFAULT 0,
  `toyid0` int(4) NOT NULL DEFAULT 0,
  `toyid1` int(4) NOT NULL DEFAULT 0,
  `toyid2` int(4) NOT NULL DEFAULT 0,
  `toyid3` int(4) NOT NULL DEFAULT 0,
  `toyid4` int(4) NOT NULL DEFAULT 0,
  `toyposx0` float NOT NULL DEFAULT 0,
  `toyposx1` float NOT NULL DEFAULT 0,
  `toyposx2` float NOT NULL DEFAULT 0,
  `toyposx3` float NOT NULL DEFAULT 0,
  `toyposx4` float NOT NULL DEFAULT 0,
  `toyposy0` float NOT NULL DEFAULT 0,
  `toyposy1` float NOT NULL DEFAULT 0,
  `toyposy2` float NOT NULL DEFAULT 0,
  `toyposy3` float NOT NULL DEFAULT 0,
  `toyposy4` float NOT NULL DEFAULT 0,
  `toyposz0` float NOT NULL DEFAULT 0,
  `toyposz1` float NOT NULL DEFAULT 0,
  `toyposz2` float NOT NULL DEFAULT 0,
  `toyposz3` float NOT NULL DEFAULT 0,
  `toyposz4` float NOT NULL DEFAULT 0,
  `toyrotx0` float NOT NULL DEFAULT 0,
  `toyrotx1` float NOT NULL DEFAULT 0,
  `toyrotx2` float NOT NULL DEFAULT 0,
  `toyrotx3` float NOT NULL DEFAULT 0,
  `toyrotx4` float NOT NULL DEFAULT 0,
  `toyroty0` float NOT NULL DEFAULT 0,
  `toyroty1` float NOT NULL DEFAULT 0,
  `toyroty2` float NOT NULL DEFAULT 0,
  `toyroty3` float NOT NULL DEFAULT 0,
  `toyroty4` float NOT NULL DEFAULT 0,
  `toyrotz0` float NOT NULL DEFAULT 0,
  `toyrotz1` float NOT NULL DEFAULT 0,
  `toyrotz2` float NOT NULL DEFAULT 0,
  `toyrotz3` float NOT NULL DEFAULT 0,
  `toyrotz4` float NOT NULL DEFAULT 0,
  `mod0` int(6) NOT NULL DEFAULT 0,
  `mod1` int(6) NOT NULL DEFAULT 0,
  `mod2` int(6) NOT NULL DEFAULT 0,
  `mod3` int(6) NOT NULL DEFAULT 0,
  `mod4` int(6) NOT NULL DEFAULT 0,
  `mod5` int(6) NOT NULL DEFAULT 0,
  `mod6` int(6) NOT NULL DEFAULT 0,
  `mod7` int(6) NOT NULL DEFAULT 0,
  `mod8` int(6) NOT NULL DEFAULT 0,
  `mod9` int(6) NOT NULL DEFAULT 0,
  `mod10` int(6) NOT NULL DEFAULT 0,
  `mod11` int(6) NOT NULL DEFAULT 0,
  `mod12` int(6) NOT NULL DEFAULT 0,
  `mod13` int(6) NOT NULL DEFAULT 0,
  `mod14` int(6) NOT NULL DEFAULT 0,
  `mod15` int(6) NOT NULL DEFAULT 0,
  `mod16` int(6) NOT NULL DEFAULT 0,
  `vehPaintjob` int(3) NOT NULL DEFAULT -1
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `warnings`
--

CREATE TABLE `warnings` (
  `ID` int(12) NOT NULL,
  `Owner` int(6) NOT NULL DEFAULT 0,
  `Type` int(3) NOT NULL DEFAULT 0,
  `Admin` varchar(24) NOT NULL DEFAULT 'Staff',
  `Reason` varchar(32) NOT NULL DEFAULT 'Unknown',
  `Date` varchar(40) NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `weaponsettings`
--

CREATE TABLE `weaponsettings` (
  `Owner` int(11) NOT NULL,
  `WeaponID` tinyint(4) NOT NULL,
  `PosX` float DEFAULT -0.116,
  `PosY` float DEFAULT 0.189,
  `PosZ` float DEFAULT 0.088,
  `RotX` float DEFAULT 0,
  `RotY` float DEFAULT 44.5,
  `RotZ` float DEFAULT 0,
  `Bone` tinyint(4) NOT NULL DEFAULT 1,
  `Hidden` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `weed`
--

CREATE TABLE `weed` (
  `ID` int(12) NOT NULL,
  `PosX` float NOT NULL DEFAULT 0,
  `PosY` float NOT NULL DEFAULT 0,
  `PosZ` float NOT NULL DEFAULT 0,
  `Grow` int(6) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `911calls`
--
ALTER TABLE `911calls`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `actors`
--
ALTER TABLE `actors`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `arrest`
--
ALTER TABLE `arrest`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `atm`
--
ALTER TABLE `atm`
  ADD PRIMARY KEY (`atmID`);

--
-- Indexes for table `business`
--
ALTER TABLE `business`
  ADD PRIMARY KEY (`bizID`);

--
-- Indexes for table `characters`
--
ALTER TABLE `characters`
  ADD PRIMARY KEY (`pID`);

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`contactID`);

--
-- Indexes for table `crates`
--
ALTER TABLE `crates`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `dealer`
--
ALTER TABLE `dealer`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `dropped`
--
ALTER TABLE `dropped`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `factions`
--
ALTER TABLE `factions`
  ADD PRIMARY KEY (`factionID`);

--
-- Indexes for table `factionvehicle`
--
ALTER TABLE `factionvehicle`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `furniture`
--
ALTER TABLE `furniture`
  ADD PRIMARY KEY (`furnitureID`);

--
-- Indexes for table `gates`
--
ALTER TABLE `gates`
  ADD PRIMARY KEY (`gateID`);

--
-- Indexes for table `houses`
--
ALTER TABLE `houses`
  ADD PRIMARY KEY (`houseID`);

--
-- Indexes for table `housestorage`
--
ALTER TABLE `housestorage`
  ADD PRIMARY KEY (`itemID`);

--
-- Indexes for table `inventory`
--
ALTER TABLE `inventory`
  ADD PRIMARY KEY (`invID`);

--
-- Indexes for table `playersalary`
--
ALTER TABLE `playersalary`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `playerucp`
--
ALTER TABLE `playerucp`
  ADD PRIMARY KEY (`pID`);

--
-- Indexes for table `rental`
--
ALTER TABLE `rental`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `samacc`
--
ALTER TABLE `samacc`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `speedcameras`
--
ALTER TABLE `speedcameras`
  ADD PRIMARY KEY (`speedID`);

--
-- Indexes for table `tags`
--
ALTER TABLE `tags`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `tickets`
--
ALTER TABLE `tickets`
  ADD PRIMARY KEY (`ticketID`);

--
-- Indexes for table `toys`
--
ALTER TABLE `toys`
  ADD PRIMARY KEY (`Id`),
  ADD UNIQUE KEY `id` (`Owner`);

--
-- Indexes for table `tree`
--
ALTER TABLE `tree`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `vehicle`
--
ALTER TABLE `vehicle`
  ADD PRIMARY KEY (`vehID`);

--
-- Indexes for table `warnings`
--
ALTER TABLE `warnings`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `weaponsettings`
--
ALTER TABLE `weaponsettings`
  ADD PRIMARY KEY (`Owner`,`WeaponID`),
  ADD UNIQUE KEY `Owner` (`Owner`,`WeaponID`);

--
-- Indexes for table `weed`
--
ALTER TABLE `weed`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `911calls`
--
ALTER TABLE `911calls`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `actors`
--
ALTER TABLE `actors`
  MODIFY `ID` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `arrest`
--
ALTER TABLE `arrest`
  MODIFY `id` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `atm`
--
ALTER TABLE `atm`
  MODIFY `atmID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `business`
--
ALTER TABLE `business`
  MODIFY `bizID` int(12) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `characters`
--
ALTER TABLE `characters`
  MODIFY `pID` int(12) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `contactID` int(12) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `crates`
--
ALTER TABLE `crates`
  MODIFY `ID` int(12) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dealer`
--
ALTER TABLE `dealer`
  MODIFY `ID` int(12) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dropped`
--
ALTER TABLE `dropped`
  MODIFY `ID` int(12) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `factions`
--
ALTER TABLE `factions`
  MODIFY `factionID` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `factionvehicle`
--
ALTER TABLE `factionvehicle`
  MODIFY `ID` int(12) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `furniture`
--
ALTER TABLE `furniture`
  MODIFY `furnitureID` int(12) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `gates`
--
ALTER TABLE `gates`
  MODIFY `gateID` int(12) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `houses`
--
ALTER TABLE `houses`
  MODIFY `houseID` int(12) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `housestorage`
--
ALTER TABLE `housestorage`
  MODIFY `itemID` int(12) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `inventory`
--
ALTER TABLE `inventory`
  MODIFY `invID` int(12) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `playersalary`
--
ALTER TABLE `playersalary`
  MODIFY `id` int(18) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `playerucp`
--
ALTER TABLE `playerucp`
  MODIFY `pID` int(12) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rental`
--
ALTER TABLE `rental`
  MODIFY `ID` int(12) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `samacc`
--
ALTER TABLE `samacc`
  MODIFY `ID` int(12) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `speedcameras`
--
ALTER TABLE `speedcameras`
  MODIFY `speedID` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tags`
--
ALTER TABLE `tags`
  MODIFY `ID` int(12) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tickets`
--
ALTER TABLE `tickets`
  MODIFY `ticketID` int(12) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `toys`
--
ALTER TABLE `toys`
  MODIFY `Id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tree`
--
ALTER TABLE `tree`
  MODIFY `ID` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `vehicle`
--
ALTER TABLE `vehicle`
  MODIFY `vehID` int(12) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `warnings`
--
ALTER TABLE `warnings`
  MODIFY `ID` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `weed`
--
ALTER TABLE `weed`
  MODIFY `ID` int(12) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
