-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: May 11, 2023 at 06:37 PM
-- Server version: 5.7.36
-- PHP Version: 7.4.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `g1`
--

-- --------------------------------------------------------

--
-- Table structure for table `kategorije`
--

DROP TABLE IF EXISTS `kategorije`;
CREATE TABLE IF NOT EXISTS `kategorije` (
  `id` int(2) UNSIGNED NOT NULL AUTO_INCREMENT,
  `naziv` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `kategorije`
--

INSERT INTO `kategorije` (`id`, `naziv`) VALUES
(1, 'Sport'),
(2, 'Zdravlje'),
(3, 'Putovanja'),
(4, 'Politika'),
(5, 'Život'),
(6, 'Mobilni telefoni');

-- --------------------------------------------------------

--
-- Table structure for table `komentari`
--

DROP TABLE IF EXISTS `komentari`;
CREATE TABLE IF NOT EXISTS `komentari` (
  `id` int(3) UNSIGNED NOT NULL AUTO_INCREMENT,
  `idProizvoda` int(3) NOT NULL,
  `ime` varchar(250) NOT NULL,
  `komentar` text NOT NULL,
  `vreme` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `volime` int(3) NOT NULL DEFAULT '0',
  `nevolime` int(3) NOT NULL DEFAULT '0',
  `odobren` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `komentari`
--

INSERT INTO `komentari` (`id`, `idProizvoda`, `ime`, `komentar`, `vreme`, `volime`, `nevolime`, `odobren`) VALUES
(2, 16, 'Boško', 'Ovo je moj komentar', '2023-02-23 17:02:54', 0, 0, 1),
(3, 13, 'Boško', 'Ovo je komentar za Nokia telefon', '2023-02-23 17:04:10', 0, 0, 1),
(8, 16, 'Бошко Богојевић', 'asdasdadssa', '2023-02-23 17:16:38', 0, 0, 1),
(9, 16, 'asdsad', 'asdasd', '2023-02-23 17:20:22', 0, 0, 1),
(10, 16, 'asdasd', 'asdasdasd', '2023-02-23 17:20:27', 0, 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `kontakt`
--

DROP TABLE IF EXISTS `kontakt`;
CREATE TABLE IF NOT EXISTS `kontakt` (
  `id` int(3) UNSIGNED NOT NULL AUTO_INCREMENT,
  `email` varchar(50) NOT NULL,
  `idKorisnika` int(3) DEFAULT NULL,
  `pitanje` text NOT NULL,
  `vremeP` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `odgovor` text,
  `vremeO` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `kontakt`
--

INSERT INTO `kontakt` (`id`, `email`, `idKorisnika`, `pitanje`, `vremeP`, `odgovor`, `vremeO`) VALUES
(1, 'asdasdsad@sadas', NULL, 'Ovo je pitanje neprijavljenog korisnika?', '2023-02-23 18:16:05', 'sdfdgsdgsgsgd', '2023-02-23 18:53:04'),
(2, 'bbosko@mojaskola.com', 1, 'Ovo je za prijavljenog korisnika?', '2023-02-23 18:16:58', 'Ovo je odgovor za prijavljenog korisnika', '2023-02-23 18:41:09'),
(3, 'bbosko@skola.com', 1, 'Pitanje 2', '2023-02-23 18:28:50', 'Ovo je odgovor na pitanje 2', '2023-02-23 18:42:31'),
(4, 'bbosko@skola.com', 1, 'Pitanje 3?', '2023-02-23 18:28:58', 'cxycycycyxcyxc', '2023-02-23 18:52:30'),
(5, 'ckurbla@skola.com', 3, 'kako da kupim proizvod?', '2023-02-23 18:44:07', 'Odete na proizvod i kliknete na dugme kupi.', '2023-02-23 18:44:55'),
(6, 'ckurbla@skola.com', 3, 'Kako da kupim proizvod, niko mi još nije odgovorio?', '2023-02-23 18:44:25', 'Cane, ne smaraj, pogledaj odgovor od ranije.', '2023-02-23 18:45:16');

-- --------------------------------------------------------

--
-- Table structure for table `korisnici`
--

DROP TABLE IF EXISTS `korisnici`;
CREATE TABLE IF NOT EXISTS `korisnici` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ime` varchar(50) NOT NULL,
  `prezime` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `lozinka` varchar(256) NOT NULL,
  `status` enum('Administrator','Urednik','Korisnik') NOT NULL,
  `aktivan` int(11) NOT NULL DEFAULT '1',
  `vremeK` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `vremeI` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `obrisan` int(11) NOT NULL DEFAULT '0',
  `registrovan` int(15) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `korisnici`
--

INSERT INTO `korisnici` (`id`, `ime`, `prezime`, `email`, `lozinka`, `status`, `aktivan`, `vremeK`, `vremeI`, `obrisan`, `registrovan`) VALUES
(1, 'Бошко', 'Богојевић', 'bbosko@skola.com', 'bbosko', 'Administrator', 1, '2022-12-26 19:25:14', '2023-05-04 17:52:45', 0, 0),
(2, 'Pera', 'Perić', 'pperic@skola.com', 'pperic', 'Urednik', 1, '2022-12-26 19:25:14', '2023-05-04 13:31:33', 0, 0),
(3, 'Cane', 'Kurbla', 'ckurbla@skola.com', '12345', 'Korisnik', 1, '2022-12-26 15:47:39', NULL, 0, 0),
(4, 'Mile', 'Dizna', 'mdizna@skola.com', '12345', 'Korisnik', 1, '2023-01-12 18:32:25', NULL, 0, 0),
(10, 'aaa', 'aaa', 'asdasdsad@sadas', '12345', 'Korisnik', 1, '2023-01-26 19:24:04', '2023-04-27 16:19:37', 1, 0),
(11, 'aaa', 'aaa', 'aaaa@skola.com', '12345', 'Korisnik', 1, '2023-02-02 18:57:34', '2023-04-27 16:19:34', 1, 0),
(12, 'ne postoji', 'asdasdasd', 'mdiznaasdasd@skola.com', 'fg.GD62', 'Korisnik', 1, '2023-02-09 19:31:45', '2023-04-20 18:40:59', 1, 1675971105),
(13, 'Boško', 'asdasdasd', 'bboskosssss@skola.com', 'ff_CH41', 'Korisnik', 1, '2023-02-09 19:44:04', '2023-04-20 18:40:44', 1, 0),
(14, 'Joca', 'Karburator', 'asdasdasd', '12345', 'Urednik', 1, '2023-04-27 16:08:29', '2023-04-27 16:09:31', 0, 0),
(15, 'sdfsf', 'sdfsdf', 'sdfsdf', '12345', 'Korisnik', 1, '2023-04-27 16:17:31', '2023-04-27 16:17:36', 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `korpa`
--

DROP TABLE IF EXISTS `korpa`;
CREATE TABLE IF NOT EXISTS `korpa` (
  `id` int(4) UNSIGNED NOT NULL AUTO_INCREMENT,
  `korisnik_id` int(3) NOT NULL,
  `proizvod_id` int(4) NOT NULL,
  `kupljen` int(1) NOT NULL DEFAULT '0',
  `vremeDodavanja` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `vremeKupovine` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `korpa`
--

INSERT INTO `korpa` (`id`, `korisnik_id`, `proizvod_id`, `kupljen`, `vremeDodavanja`, `vremeKupovine`) VALUES
(1, 1, 16, 0, '2023-05-11 18:26:51', NULL);

-- --------------------------------------------------------

--
-- Stand-in structure for view `pogledkorpa`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `pogledkorpa`;
CREATE TABLE IF NOT EXISTS `pogledkorpa` (
`id` int(4) unsigned
,`korisnik_id` int(3)
,`proizvod_id` int(4)
,`kupljen` int(1)
,`vremeDodavanja` timestamp
,`vremeKupovine` timestamp
,`naslov` varchar(200)
,`cena` int(5)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `pogledproizvodi`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `pogledproizvodi`;
CREATE TABLE IF NOT EXISTS `pogledproizvodi` (
`id` int(10) unsigned
,`naslov` varchar(200)
,`tekst` text
,`kategorija` int(3)
,`autor` int(3)
,`vremeK` timestamp
,`vremeI` timestamp
,`obrisan` int(11)
,`pogledan` int(5)
,`ime` varchar(50)
,`prezime` varchar(100)
,`naziv` varchar(20)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `pogledvesti`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `pogledvesti`;
CREATE TABLE IF NOT EXISTS `pogledvesti` (
`id` int(10) unsigned
,`naslov` varchar(200)
,`tekst` text
,`kategorija` int(3)
,`autor` int(3)
,`vremeK` timestamp
,`vremeI` timestamp
,`obrisan` int(11)
,`ime` varchar(50)
,`prezime` varchar(100)
,`naziv` varchar(20)
);

-- --------------------------------------------------------

--
-- Table structure for table `proizvodi`
--

DROP TABLE IF EXISTS `proizvodi`;
CREATE TABLE IF NOT EXISTS `proizvodi` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `naslov` varchar(200) NOT NULL,
  `tekst` text NOT NULL,
  `kategorija` int(3) NOT NULL,
  `autor` int(3) NOT NULL,
  `vremeK` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `vremeI` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `obrisan` int(11) NOT NULL DEFAULT '0',
  `cena` int(5) DEFAULT NULL,
  `pogledan` int(5) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `proizvodi`
--

INSERT INTO `proizvodi` (`id`, `naslov`, `tekst`, `kategorija`, `autor`, `vremeK`, `vremeI`, `obrisan`, `cena`, `pogledan`) VALUES
(1, 'Mitrović obrće Premijer ligu – dve asistencije, pa gol', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla a sodales sem. Mauris libero ipsum, varius sit amet nulla at, maximus scelerisque quam. Phasellus at diam laoreet, faucibus augue ac, aliquet massa. Etiam a metus non enim molestie ornare eu eu quam. Nam venenatis nunc mauris, vitae hendrerit metus posuere non. In condimentum sagittis diam quis semper. Duis efficitur lacinia ligula, vel aliquam diam pharetra eu. Nullam dolor risus, iaculis porta urna in, mattis venenatis purus. Nam in diam eu tellus porta luctus eu in lacus. Suspendisse viverra suscipit eros et tempor. Quisque tincidunt ullamcorper posuere. Mauris dictum molestie nisi, sit amet porttitor mauris iaculis nec.', 1, 1, '2022-12-04 17:09:15', '2023-04-20 15:33:53', 0, NULL, 8),
(2, 'Gordon izveo zakucavanje godine; Jokić: Bio sam otvoren', 'Ut tristique ante sed risus dictum, a cursus risus sodales. Nunc pharetra massa ac odio ullamcorper faucibus. In quam nisi, fermentum vitae augue id, venenatis porta lectus. Maecenas ac sagittis justo, at fringilla tellus. Quisque auctor ut lorem et sodales. Vivamus viverra ligula sed vestibulum efficitur. Maecenas commodo eu urna vel sagittis. Donec ac tempus ligula. Sed at luctus nisi, a iaculis velit. Sed eu gravida metus. Donec ac lacus id enim tincidunt lobortis. Duis commodo libero at pellentesque finibus. Nam imperdiet, tellus et ultrices venenatis, magna est posuere ante, vel dictum nulla massa vitae nisi. Sed ultricies felis sapien, sit amet scelerisque ante luctus nec. Phasellus sodales lorem diam, quis commodo turpis auctor et.', 2, 1, '2022-12-26 17:09:15', '2023-01-12 16:55:28', 0, NULL, 0),
(3, 'Postoji način da poboljšate kardiovaskularne sposobnosti, otkriven je pre 50 godina i to slučajno', 'Sed feugiat, mauris posuere imperdiet aliquam, tortor lacus tempus urna, et semper turpis dui eget odio. Mauris ut magna elit. Integer nec ultrices quam. Praesent vulputate orci justo, eget viverra est imperdiet ut. Ut eget porttitor sapien. Fusce varius nibh eget sem vehicula aliquam. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Quisque aliquam bibendum est, vitae varius ligula consectetur eu.', 3, 2, '2022-12-30 17:10:41', '2023-01-12 17:35:38', 0, NULL, 0),
(4, 'Lekar otkrio šta se dešava u organizmu ako san traje duže od 9 sati', 'Maecenas laoreet euismod faucibus. Morbi malesuada sit amet risus eget pellentesque. Nunc vel ante vitae urna convallis porttitor. Nunc est lorem, vulputate eu ultricies non, consequat non nisi. Sed eget blandit ex, ac iaculis massa. Phasellus hendrerit varius tellus ac feugiat. Donec orci ex, lobortis non laoreet non, ornare nec dui. Quisque convallis dignissim lacus id eleifend.', 3, 2, '2022-12-26 17:10:41', '2023-01-12 16:55:44', 0, NULL, 0),
(5, 'Svetski kuvari presudili; Objavljen spisak deset najboljih srpskih jela', 'Nullam efficitur, nibh nec luctus placerat, mauris magna faucibus arcu, in suscipit felis sem nec erat. Aliquam quis quam arcu. Aenean blandit imperdiet turpis, vitae ornare ligula laoreet nec. Nullam accumsan tortor vel suscipit fringilla. Sed dolor nibh, consequat quis convallis eget, imperdiet vel tortor. Nam imperdiet id augue quis dictum. Etiam suscipit et massa non gravida.', 4, 3, '2022-12-26 17:11:39', '2023-01-12 16:55:48', 0, NULL, 0),
(6, 'Mitrović obrće Premijer ligu OPET – tri asistencije, pa 2 gola', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla a sodales sem. Mauris libero ipsum, varius sit amet nulla at, maximus scelerisque quam. Phasellus at diam laoreet, faucibus augue ac, aliquet massa. Etiam a metus non enim molestie ornare eu eu quam. Nam venenatis nunc mauris, vitae hendrerit metus posuere non. In condimentum sagittis diam quis semper. Duis efficitur lacinia ligula, vel aliquam diam pharetra eu. Nullam dolor risus, iaculis porta urna in, mattis venenatis purus. Nam in diam eu tellus porta luctus eu in lacus. Suspendisse viverra suscipit eros et tempor. Quisque tincidunt ullamcorper posuere. Mauris dictum molestie nisi, sit amet porttitor mauris iaculis nec.', 1, 3, '2022-12-05 17:09:15', '2023-01-12 17:35:26', 0, NULL, 0),
(7, 'Nikola Jokić car!!!', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. In arcu cursus euismod quis viverra nibh cras. Nam libero justo laoreet sit amet cursus sit amet dictum. Libero enim sed faucibus turpis in. Neque convallis a cras semper auctor. In arcu cursus euismod quis viverra nibh cras pulvinar. Vulputate mi sit amet mauris. Ornare arcu dui vivamus arcu felis bibendum ut. Risus feugiat in ante metus dictum at tempor. Nibh sit amet commodo nulla facilisi nullam vehicula ipsum. Venenatis urna cursus eget nunc scelerisque viverra mauris in aliquam. Sed nisi lacus sed viverra tellus in. Adipiscing tristique risus nec feugiat in fermentum posuere. Dui vivamus arcu felis bibendum ut tristique et egestas. Mi proin sed libero enim sed faucibus turpis in eu. Nisi quis eleifend quam adipiscing vitae proin sagittis nisl. Commodo odio aenean sed adipiscing diam donec adipiscing tristique risus.', 5, 10, '2023-01-12 18:03:26', '2023-01-26 19:31:28', 0, NULL, 0),
(8, 'Ovo je naslov iz INSERT INTO upita', 'Ovo je Lorem Ipsum sadržaj', 1, 1, '2023-01-12 18:07:49', NULL, 0, NULL, 0),
(9, 'Ovo je uneo Boško sa stranice', 'Accumsan lacus vel facilisis volutpat est velit. Egestas integer eget aliquet nibh. Duis tristique sollicitudin nibh sit. At risus viverra adipiscing at. Donec et odio pellentesque diam volutpat commodo. At varius vel pharetra vel turpis nunc eget lorem. Mauris pharetra et ultrices neque ornare aenean. Vel turpis nunc eget lorem dolor sed. Enim ut sem viverra aliquet eget sit. Maecenas pharetra convallis posuere morbi leo urna molestie at elementum. Gravida rutrum quisque non tellus orci. Eget lorem dolor sed viverra ipsum. Nunc vel risus commodo viverra maecenas accumsan lacus vel. At lectus urna duis convallis convallis tellus id interdum velit. Nunc id cursus metus aliquam eleifend mi. At ultrices mi tempus imperdiet nulla malesuada pellentesque elit.', 5, 1, '2023-01-12 18:22:40', NULL, 0, NULL, 0),
(10, 'Ovo je uneo Boško sa stranice ali ponovo', 'Ultrices dui sapien eget mi proin sed libero. Interdum velit euismod in pellentesque. Scelerisque viverra mauris in aliquam sem. Praesent elementum facilisis leo vel fringilla est ullamcorper eget. Dui nunc mattis enim ut tellus elementum sagittis. Eleifend mi in nulla posuere sollicitudin aliquam ultrices sagittis orci. Turpis egestas pretium aenean pharetra magna. Tempus quam pellentesque nec nam aliquam sem. Diam phasellus vestibulum lorem sed risus ultricies tristique nulla aliquet. Sit amet consectetur adipiscing elit pellentesque habitant morbi tristique. Neque vitae tempus quam pellentesque nec nam aliquam sem et. Elementum pulvinar etiam non quam lacus suspendisse. Sem et tortor consequat id porta nibh. Eu facilisis sed odio morbi quis commodo odio aenean sed. Volutpat lacus laoreet non curabitur gravida. Pharetra convallis posuere morbi leo urna molestie at. Eu feugiat pretium nibh ipsum consequat nisl vel. Risus feugiat in ante metus dictum at tempor commodo ullamcorper.', 3, 1, '2023-01-12 18:23:41', '2023-05-04 13:55:22', 0, NULL, 1),
(11, 'Ovo je za statistiku', 'Lectus nulla at volutpat diam ut venenatis tellus in. Amet aliquam id diam maecenas ultricies mi eget. Dolor morbi non arcu risus quis. Tellus in hac habitasse platea. Leo in vitae turpis massa sed elementum tempus egestas. Egestas congue quisque egestas diam in arcu. Varius vel pharetra vel turpis nunc eget lorem dolor sed. Sit amet massa vitae tortor condimentum lacinia quis vel. Dictumst quisque sagittis purus sit. Posuere sollicitudin aliquam ultrices sagittis orci. Quis viverra nibh cras pulvinar mattis nunc sed blandit libero.', 1, 1, '2023-01-12 18:51:28', '2023-02-23 19:04:03', 0, NULL, 4),
(13, 'Nokia 3310', 'Stara 15 godina.\r\nBaterija drži 14 dana aktivnog korišćenja.\r\nBaba ga koristila samo komšinicu da zove.\r\nCena 300 evrića', 6, 1, '2023-01-19 18:27:08', '2023-02-23 19:03:56', 0, NULL, 3),
(16, 'Opel Vectra', 'Iz 2000. Prešao 100000', 3, 1, '2023-02-02 19:28:08', '2023-05-11 18:35:23', 0, 10000, 33);

-- --------------------------------------------------------

--
-- Table structure for table `slikeproizvoda`
--

DROP TABLE IF EXISTS `slikeproizvoda`;
CREATE TABLE IF NOT EXISTS `slikeproizvoda` (
  `id` int(4) UNSIGNED NOT NULL AUTO_INCREMENT,
  `idProizvoda` int(4) DEFAULT NULL,
  `imeSlike` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `slikeproizvoda`
--

INSERT INTO `slikeproizvoda` (`id`, `idProizvoda`, `imeSlike`) VALUES
(1, 16, '1675366088.5301_2-summer-beach-christopher-elwell-and-amanda-haselock.jpg'),
(2, 16, '1675366088.5317_1000_F_294032590_C4mXxgRWDO435yFE97ob0nviY4nEz0s1.jpg'),
(3, 16, '1675366088.5331_summer-beach-background-seashells-57302038.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `statistika`
--

DROP TABLE IF EXISTS `statistika`;
CREATE TABLE IF NOT EXISTS `statistika` (
  `id` int(4) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ipadresa` varchar(20) NOT NULL,
  `stranica` varchar(50) NOT NULL,
  `parametri` varchar(50) NOT NULL,
  `tekst` varchar(250) DEFAULT NULL,
  `vreme` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=373 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `statistika`
--

INSERT INTO `statistika` (`id`, `ipadresa`, `stranica`, `parametri`, `tekst`, `vreme`) VALUES
(1, '::1', '/g1/aphp/p1/vest.php', 'id=10', '', '2023-01-12 18:45:58'),
(2, '::1', '/g1/aphp/p1/vest.php', 'id=10', '', '2023-01-12 18:46:15'),
(3, '::1', '/g1/aphp/p1/vest.php', 'id=10', '', '2023-01-12 18:46:15'),
(4, '172.15.15.15', '/g1/aphp/p1/vest.php', 'id=10', '', '2023-01-12 18:46:15'),
(5, '::1', '/g1/aphp/p1/vest.php', 'id=10', '', '2023-01-12 18:46:16'),
(6, '::1', '/g1/aphp/p1/vest.php', 'id=10', '', '2023-01-12 18:46:16'),
(7, '::1', '/g1/aphp/p1/vest.php', 'id=10', '', '2023-01-12 18:46:16'),
(8, 'hhhhhhhh', '/g1/aphp/p1/index.php', '', 'Ovo sam ja dodao', '2023-01-12 18:46:19'),
(9, '::1', '/g1/aphp/p1/index.php', '', '', '2023-01-12 18:46:22'),
(10, '::1', '/g1/aphp/p1/index.php', 'kategorija=1', '', '2023-01-12 18:46:23'),
(11, '::1', '/g1/aphp/p1/index.php', 'kategorija=2', '', '2023-01-12 18:46:24'),
(12, '::1', '/g1/aphp/p1/index.php', 'kategorija=3', '', '2023-01-12 18:46:24'),
(13, '::1', '/g1/aphp/p1/index.php', 'kategorija=4', '', '2023-01-12 18:46:25'),
(14, '172.15.15.15', '/g1/aphp/p1/index.php', 'kategorija=5', '', '2023-01-12 18:46:25'),
(15, '::1', '/g1/aphp/p1/index.php', '', '', '2023-01-12 18:46:27'),
(16, '::1', '/g1/aphp/p1/index.php', '', '', '2023-01-12 18:46:30'),
(17, '::1', '/g1/aphp/p1/index.php', '', '', '2023-01-12 18:46:30'),
(18, '::1', '/g1/aphp/p1/index.php', '', '', '2023-01-12 18:46:30'),
(19, '::1', '/g1/aphp/p1/vest.php', 'id=10', '', '2023-01-12 18:47:22'),
(20, '::1', '/g1/aphp/p1/index.php', '', '', '2023-01-12 18:47:24'),
(21, '172.15.15.15', '/g1/aphp/p1/vest.php', 'id=9', '', '2023-01-12 18:47:25'),
(22, '::1', '/g1/aphp/p1/index.php', '', '', '2023-01-12 18:47:26'),
(23, '172.15.15.14', '/g1/aphp/p1/vest.php', 'id=8', '', '2023-01-12 18:47:27'),
(24, '::1', '/g1/aphp/p1/index.php', '', '', '2023-01-12 18:47:28'),
(25, '::1', '/g1/aphp/p1/vest.php', 'id=6', '', '2023-01-12 18:47:29'),
(26, '::1', '/g1/aphp/p1/index.php', '', '', '2023-01-12 18:47:30'),
(27, '::1', '/g1/aphp/p1/index2.php', '', 'Snimanje vesti sa id=11', '2023-01-12 18:51:28'),
(28, '::1', '/g1/aphp/p1/index2.php', '', 'Snimanje vesti sa id=12', '2023-01-12 19:05:55'),
(29, '::1', '/g1/aphp/p1/index.php', '', '', '2023-01-12 19:06:18'),
(30, '::1', '/g1/aphp/p1/index4.php', '', 'Snimanje vesti sa id=0', '2023-01-12 19:07:35'),
(31, '::1', '/g1/aphp/p1/index.php', '', '', '2023-01-12 19:07:57'),
(32, '::1', '/g1/aphp/p1/index5.php', '', 'Uspešno obrisana vest iz baze sa id=12', '2023-01-12 19:12:24'),
(33, '::1', '/g1/aphp/p1/index6.php', '', 'Lažno obrisana vest iz baze sa id=11', '2023-01-12 19:16:01'),
(34, '::1', '/g1/aphp/p1/index.php', '', '', '2023-01-12 19:16:10'),
(35, '::1', '/g1/aphp/p1/index.php', '', '', '2023-01-12 19:16:46'),
(36, '::1', '/g1/aphp/p1/index2.php', '', 'Snimanje vesti sa id=13', '2023-01-19 18:27:08'),
(37, '::1', '/g1/aphp/p1/index.php', '', '', '2023-01-19 18:27:14'),
(38, '::1', '/g1/aphp/p1/index.php', '', '', '2023-01-19 18:27:52'),
(39, '::1', '/g1/aphp/p1/vest.php', 'id=13', '', '2023-01-19 18:27:57'),
(40, '::1', '/g1/aphp/p1/index.php', '', '', '2023-01-19 18:29:28'),
(41, '::1', '/g1/aphp/p2/sajt/index.php', '', '', '2023-01-19 18:36:47'),
(42, '::1', '/g1/aphp/p2/sajt/index.php', '', '', '2023-01-19 18:38:27'),
(43, '::1', '/g1/aphp/p2/sajt/index.php', '', '', '2023-01-19 18:38:56'),
(44, '::1', '/g1/aphp/p2/sajt/index.php', '', '', '2023-01-19 18:40:18'),
(45, '::1', '/g1/aphp/p2/sajt/index.php', '', '', '2023-01-19 18:41:21'),
(46, '::1', '/g1/aphp/p2/sajt/index.php', '', '', '2023-01-19 18:41:38'),
(47, '::1', '/g1/aphp/p2/sajt/index.php', '', '', '2023-01-19 18:43:19'),
(48, '::1', '/g1/aphp/p2/sajt/index.php', '', '', '2023-01-19 18:43:21'),
(49, '::1', '/g1/aphp/p2/sajt/index.php', '', '', '2023-01-19 18:43:48'),
(50, '::1', '/g1/aphp/p2/sajt/index.php', '', '', '2023-01-19 18:44:20'),
(51, '::1', '/g1/aphp/p2/sajt/index.php', '', '', '2023-01-19 18:45:38'),
(52, '::1', '/g1/aphp/p2/sajt/index.php', '', '', '2023-01-19 18:45:56'),
(53, '::1', '/g1/aphp/p2/sajt/index.php', '', '', '2023-01-19 18:46:26'),
(54, '::1', '/g1/aphp/p2/sajt/index.php', '', '', '2023-01-19 18:46:27'),
(55, '::1', '/g1/aphp/p2/sajt/index.php', '', '', '2023-01-19 18:46:28'),
(56, '::1', '/g1/aphp/p2/sajt/index.php', '', '', '2023-01-19 18:47:10'),
(57, '::1', '/g1/aphp/p2/sajt/index.php', '', '', '2023-01-19 18:47:21'),
(58, '::1', '/g1/aphp/p2/sajt/index.php', '', '', '2023-01-19 18:47:28'),
(59, '::1', '/g1/aphp/p2/sajt/index.php', '', '', '2023-01-19 18:47:37'),
(60, '::1', '/g1/aphp/p2/sajt/index.php', 'kategorija=6', '', '2023-01-19 18:47:42'),
(61, '::1', '/g1/aphp/p2/sajt/index.php', '', '', '2023-01-19 18:47:46'),
(62, '::1', '/g1/aphp/p2/sajt/index.php', 'kategorija=1', '', '2023-01-19 18:47:48'),
(63, '::1', '/g1/aphp/p2/sajt/index.php', 'autor=1', '', '2023-01-19 18:47:52'),
(64, '::1', '/g1/aphp/p2/sajt/index.php', 'autor=1', '', '2023-01-19 18:48:58'),
(65, '::1', '/g1/aphp/p2/sajt/index.php', '', '', '2023-01-19 18:49:05'),
(66, '::1', '/g1/aphp/p2/sajt/index.php', '', '', '2023-01-19 18:57:47'),
(67, '::1', '/g1/aphp/p2/sajt/index.php', '', '', '2023-01-19 18:57:51'),
(68, '::1', '/g1/aphp/p2/sajt/index.php', '', '', '2023-01-19 18:57:57'),
(69, '::1', '/g1/aphp/p2/sajt/index.php', '', '', '2023-01-19 18:58:00'),
(70, '::1', '/g1/aphp/p2/sajt/index.php', '', '', '2023-01-19 19:11:28'),
(71, '::1', '/g1/aphp/p2/sajt/index.php', '', '', '2023-01-19 19:16:15'),
(72, '::1', '/g1/aphp/p2/sajt/index.php', '', '', '2023-01-19 19:16:32'),
(73, '::1', '/g1/aphp/p2/sajt/index.php', '', '', '2023-01-19 19:16:53'),
(74, '::1', '/g1/aphp/p2/sajt/index.php', '', '', '2023-01-19 19:17:49'),
(75, '::1', '/g1/aphp/p2/sajt/index.php', 'kategorija=1', '', '2023-01-19 19:17:54'),
(76, '::1', '/g1/aphp/p2/sajt/index.php', 'kategorija=3', '', '2023-01-19 19:17:56'),
(77, '::1', '/g1/aphp/p2/sajt/index.php', 'kategorija=5', '', '2023-01-19 19:17:57'),
(78, '::1', '/g1/aphp/p2/sajt/index.php', 'kategorija=5', '', '2023-01-19 19:18:12'),
(79, '::1', '/g1/aphp/p2/sajt/index.php', '', '', '2023-01-19 19:24:23'),
(80, '::1', '/g1/aphp/p2/sajt/index.php', '', '', '2023-01-19 19:24:34'),
(81, '::1', '/g1/aphp/p2/sajt/index.php', '', '', '2023-01-19 19:24:47'),
(82, '::1', '/g1/aphp/p2/sajt/index.php', '', '', '2023-01-19 19:25:00'),
(83, '::1', '/g1/aphp/p2/sajt/index.php', '', '', '2023-01-19 19:28:20'),
(84, '::1', '/g1/aphp/p2/sajt/index.php', '', '', '2023-01-19 19:29:17'),
(85, '::1', '/g1/aphp/p2/sajt/index.php', '', '', '2023-01-19 19:31:31'),
(86, '::1', '/g1/aphp/p2/sajt/index.php', '', '', '2023-01-19 19:31:35'),
(87, '::1', '/g1/aphp/p2/sajt/index.php', '', '', '2023-01-19 19:31:45'),
(88, '::1', '/g1/aphp/p2/sajt/index.php', '', '', '2023-01-19 19:32:10'),
(89, '::1', '/g1/aphp/p2/sajt/index.php', '', '', '2023-01-19 19:33:24'),
(90, '::1', '/g1/aphp/p2/sajt/index.php', '', '', '2023-01-19 19:33:24'),
(91, '::1', '/g1/aphp/p2/sajt/index.php', '', '', '2023-01-19 19:33:25'),
(92, '::1', '/g1/aphp/p2/sajt/index.php', '', '', '2023-01-19 19:33:25'),
(93, '::1', '/g1/aphp/p2/sajt/index.php', '', '', '2023-01-19 19:33:28'),
(94, '::1', '/g1/aphp/p2/sajt/index.php', '', '', '2023-01-19 19:33:28'),
(95, '::1', '/g1/aphp/p2/sajt/index.php', '', '', '2023-01-19 19:33:28'),
(96, '::1', '/g1/aphp/p2/sajt/index.php', '', '', '2023-01-19 19:33:28'),
(97, '::1', '/g1/aphp/p2/sajt/index.php', '', '', '2023-01-19 19:34:17'),
(98, '::1', '/g1/aphp/p3/sajt/index.php', '', '', '2023-01-26 18:28:10'),
(99, '::1', '/g1/aphp/p3/sajt/index.php', '', '', '2023-01-26 18:29:12'),
(100, '::1', '/g1/aphp/p3/sajt/index.php', '', '', '2023-01-26 18:29:29'),
(101, '::1', '/g1/aphp/p3/sajt/index.php', '', '', '2023-01-26 18:30:19'),
(102, '::1', '/g1/aphp/p3/sajt/index.php', '', '', '2023-01-26 18:35:27'),
(103, '::1', '/g1/aphp/p3/sajt/index.php', '', '', '2023-01-26 18:35:44'),
(104, '::1', '/g1/aphp/p3/sajt/index.php', '', '', '2023-01-26 18:37:18'),
(105, '::1', '/g1/aphp/p3/sajt/index.php', '', '', '2023-01-26 18:37:54'),
(106, '::1', '/g1/aphp/p3/sajt/index.php', '', '', '2023-01-26 18:38:06'),
(107, '::1', '/g1/aphp/p3/sajt/index.php', '', '', '2023-01-26 18:38:36'),
(108, '::1', '/g1/aphp/p3/sajt/index.php', '', '', '2023-01-26 18:38:42'),
(109, '::1', '/g1/aphp/p3/sajt/index.php', '', '', '2023-01-26 18:39:24'),
(110, '::1', '/g1/aphp/p3/sajt/index.php', '', '', '2023-01-26 18:39:44'),
(111, '::1', '/g1/aphp/p3/sajt/index.php', '', '', '2023-01-26 18:40:01'),
(112, '::1', '/g1/aphp/p3/sajt/index.php', '', '', '2023-01-26 18:42:25'),
(113, '::1', '/g1/aphp/p3/sajt/index.php', '', '', '2023-01-26 18:42:33'),
(114, '::1', '/g1/aphp/p3/sajt/index.php', '', '', '2023-01-26 18:42:42'),
(115, '::1', '/g1/aphp/p3/sajt/index.php', '', '', '2023-01-26 18:59:04'),
(116, '::1', '/g1/aphp/p3/sajt/index.php', '', '', '2023-01-26 19:02:05'),
(117, '::1', '/g1/aphp/p3/sajt/index.php', '', '', '2023-01-26 19:02:18'),
(118, '::1', '/g1/aphp/p3/sajt/index.php', '', '', '2023-01-26 19:02:25'),
(119, '::1', '/g1/aphp/p3/sajt/index.php', '', '', '2023-01-26 19:27:11'),
(120, '::1', '/g1/aphp/p3/sajt/index.php', '', '', '2023-01-26 19:27:35'),
(121, '::1', '/g1/aphp/p3/sajt/index.php', '', '', '2023-01-26 19:29:50'),
(122, '::1', '/g1/aphp/p3/sajt/index.php', '', '', '2023-01-26 19:30:16'),
(123, '::1', '/g1/aphp/p3/sajt/index.php', '', '', '2023-01-26 19:30:25'),
(124, '::1', '/g1/aphp/p3/sajt/index.php', '', '', '2023-01-26 19:30:29'),
(125, '::1', '/g1/aphp/p3/sajt/index.php', '', '', '2023-01-26 19:30:33'),
(126, '::1', '/g1/aphp/p3/sajt/index.php', '', '', '2023-01-26 19:30:58'),
(127, '::1', '/g1/aphp/p3/sajt/index.php', '', '', '2023-01-26 19:31:33'),
(128, '::1', '/g1/aphp/p3/sajt/index.php', '', '', '2023-01-26 19:31:46'),
(129, '::1', '/g1/aphp/p3/sajt/index.php', '', '', '2023-01-26 19:31:51'),
(130, '::1', '/g1/aphp/p3/sajt/index.php', '', '', '2023-01-26 19:31:59'),
(131, '::1', '/g1/aphp/p3/sajt/index.php', '', '', '2023-01-26 19:32:26'),
(132, '::1', '/g1/aphp/p3/sajt/vest.php', 'id=13', '', '2023-01-26 19:32:56'),
(133, '::1', '/g1/aphp/p3/sajt/vest.php', 'id=13', '', '2023-01-26 19:35:23'),
(134, '::1', '/g1/aphp/p3/sajt/index.php', '', '', '2023-01-26 19:36:04'),
(135, '::1', '/g1/aphp/p3/sajt/index.php', '', '', '2023-01-26 19:39:03'),
(136, '::1', '/g1/aphp/p3/sajt/index.php', '', '', '2023-01-26 19:39:11'),
(137, '::1', '/g1/aphp/p3/sajt/index.php', '', '', '2023-01-26 19:39:34'),
(138, '::1', '/g1/aphp/p4/sajt/index.php', '', '', '2023-02-02 18:25:47'),
(139, '::1', '/g1/aphp/p4/sajt/index.php', '', '', '2023-02-02 18:25:56'),
(140, '::1', '/g1/aphp/p4/sajt/index.php', '', '', '2023-02-02 18:26:58'),
(141, '::1', '/g1/aphp/p4/sajt/proizvod.php', 'id=13', '', '2023-02-02 18:27:00'),
(142, '::1', '/g1/aphp/p4/sajt/index.php', '', '', '2023-02-02 18:27:12'),
(143, '::1', '/g1/aphp/p4/sajt/index.php', '', '', '2023-02-02 18:44:24'),
(144, '::1', '/g1/aphp/p4/sajt/index.php', '', '', '2023-02-02 18:44:39'),
(145, '::1', '/g1/aphp/p4/sajt/index.php', '', '', '2023-02-02 18:49:47'),
(146, '::1', '/g1/aphp/p4/sajt/index.php', '', '', '2023-02-02 18:51:06'),
(147, '::1', '/g1/aphp/p4/sajt/index.php', '', '', '2023-02-02 18:53:39'),
(148, '::1', '/g1/aphp/p4/sajt/index.php', '', '', '2023-02-02 18:53:47'),
(149, '::1', '/g1/aphp/p4/sajt/index.php', '', '', '2023-02-02 19:29:30'),
(150, '::1', '/g1/aphp/p4/sajt/proizvod.php', 'id=16', '', '2023-02-02 19:29:32'),
(151, '::1', '/g1/aphp/p4/sajt/proizvod.php', 'id=16', '', '2023-02-02 19:30:15'),
(152, '::1', '/g1/aphp/p4/sajt/index.php', '', '', '2023-02-02 19:30:51'),
(153, '::1', '/g1/aphp/p4/sajt/proizvod.php', 'id=13', '', '2023-02-02 19:30:52'),
(154, '::1', '/g1/aphp/p4/sajt/index.php', '', '', '2023-02-02 19:30:57'),
(155, '::1', '/g1/aphp/p4/sajt/proizvod.php', 'id=11', '', '2023-02-02 19:30:58'),
(156, '::1', '/g1/aphp/p4/sajt/index.php', '', '', '2023-02-02 19:31:00'),
(157, '::1', '/g1/aphp/p4/sajt/proizvod.php', 'id=16', '', '2023-02-02 19:31:01'),
(158, '::1', '/g1/aphp/p4/sajt/index.php', '', '', '2023-02-02 19:31:04'),
(159, '::1', '/g1/aphp/p4/sajt/proizvod.php', 'id=13', '', '2023-02-02 19:31:06'),
(160, '::1', '/g1/aphp/p4/sajt/index.php', '', '', '2023-02-02 19:31:10'),
(161, '::1', '/g1/aphp/p4/sajt/proizvod.php', 'id=16', '', '2023-02-02 19:31:12'),
(162, '::1', '/g1/aphp/p4/sajt/proizvod.php', 'id=16', '', '2023-02-02 19:32:02'),
(163, '::1', '/g1/aphp/p4/sajt/proizvod.php', 'id=16', '', '2023-02-02 19:32:20'),
(164, '::1', '/g1/aphp/p4/sajt/proizvod.php', 'id=16', '', '2023-02-02 19:35:53'),
(165, '::1', '/g1/aphp/p4/sajt/proizvod.php', 'id=16', '', '2023-02-02 19:36:04'),
(166, '::1', '/g1/aphp/p4/sajt/proizvod.php', 'id=16', '', '2023-02-02 19:36:22'),
(167, '::1', '/g1/aphp/p4/sajt/proizvod.php', 'id=16', '', '2023-02-02 19:36:45'),
(168, '::1', '/g1/aphp/p4/sajt/proizvod.php', 'id=16', '', '2023-02-02 19:37:06'),
(169, '::1', '/g1/aphp/p4/sajt/proizvod.php', 'id=16', '', '2023-02-02 19:38:18'),
(170, '::1', '/g1/aphp/p4/sajt/proizvod.php', 'id=16', '', '2023-02-02 19:38:27'),
(171, '::1', '/g1/aphp/p4/sajt/index.php', '', '', '2023-02-02 19:38:35'),
(172, '::1', '/g1/aphp/p4/sajt/proizvod.php', 'id=13', '', '2023-02-02 19:38:36'),
(173, '::1', '/g1/aphp/p4/sajt/index.php', '', '', '2023-02-02 19:38:39'),
(174, '::1', '/g1/aphp/p4/sajt/proizvod.php', 'id=16', '', '2023-02-02 19:38:40'),
(175, '::1', '/g1/aphp/p5/sajt/index.php', '', '', '2023-02-09 18:22:30'),
(176, '::1', '/g1/aphp/p5/sajt/proizvod.php', 'id=16', '', '2023-02-09 18:22:32'),
(177, '::1', '/g1/aphp/p5/sajt/proizvod.php', 'id=asdasd', '', '2023-02-09 18:28:30'),
(178, '::1', '/g1/aphp/p5/sajt/proizvod.php', 'id=16', '', '2023-02-09 18:45:22'),
(179, '::1', '/g1/aphp/p5/sajt/proizvod.php', 'id=asdasdsa', '', '2023-02-09 18:47:55'),
(180, '::1', '/g1/aphp/p5/sajt/proizvod.php', 'id=asdasdsa', '', '2023-02-09 18:50:56'),
(181, '::1', '/g1/aphp/p5/sajt/proizvod.php', 'id=asdasdsa', '', '2023-02-09 18:50:56'),
(182, '::1', '/g1/aphp/p5/sajt/proizvod.php', 'id=asdasdsa', '', '2023-02-09 18:50:57'),
(183, '::1', '/g1/aphp/p5/sajt/proizvod.php', 'id=asdasdsa', '', '2023-02-09 18:50:58'),
(184, '::1', '/g1/aphp/p5/sajt/index.php', '', '', '2023-02-09 18:52:34'),
(185, '::1', '/g1/aphp/p5/sajt/index.php', '', '', '2023-02-09 18:58:19'),
(186, '::1', '/g1/aphp/p5/sajt/proizvod.php', 'id=16', '', '2023-02-09 18:58:20'),
(187, '::1', '/g1/aphp/p5/sajt/proizvod.php', 'id=16', '', '2023-02-09 19:06:16'),
(188, '::1', '/g1/aphp/p5/sajt/index.php', '', '', '2023-02-09 19:07:51'),
(189, '::1', '/g1/aphp/p6/sajt/index.php', '', '', '2023-02-23 15:12:28'),
(190, '::1', '/g1/aphp/p6/sajt/index.php', '', '', '2023-02-23 15:46:07'),
(191, '::1', '/g1/aphp/p6/sajt/index.php', 'kategorija=1', '', '2023-02-23 15:46:08'),
(192, '::1', '/g1/aphp/p6/sajt/index.php', 'kategorija=2', '', '2023-02-23 15:46:09'),
(193, '::1', '/g1/aphp/p6/sajt/index.php', 'kategorija=3', '', '2023-02-23 15:46:10'),
(194, '::1', '/g1/aphp/p6/sajt/index.php', 'kategorija=4', '', '2023-02-23 15:46:11'),
(195, '::1', '/g1/aphp/p6/sajt/index.php', '', '', '2023-02-23 15:46:11'),
(196, '::1', '/g1/aphp/p6/sajt/index.php', '', '', '2023-02-23 15:51:15'),
(197, '::1', '/g1/aphp/p6/sajt/index.php', '', '', '2023-02-23 15:51:20'),
(198, '::1', '/g1/aphp/p6/sajt/index.php', '', '', '2023-02-23 15:51:26'),
(199, '::1', '/g1/aphp/p6/sajt/index.php', '', '', '2023-02-23 16:09:05'),
(200, '::1', '/g1/aphp/p6/sajt/proizvod.php', 'id=16', '', '2023-02-23 16:46:38'),
(201, '::1', '/g1/aphp/p6/sajt/proizvod.php', 'id=16', '', '2023-02-23 16:51:02'),
(202, '::1', '/g1/aphp/p6/sajt/proizvod.php', 'id=16', '', '2023-02-23 16:51:24'),
(203, '::1', '/g1/aphp/p6/sajt/proizvod.php', 'id=16', '', '2023-02-23 16:51:57'),
(204, '::1', '/g1/aphp/p6/sajt/proizvod.php', 'id=16', '', '2023-02-23 16:51:58'),
(205, '::1', '/g1/aphp/p6/sajt/proizvod.php', 'id=16', '', '2023-02-23 16:52:45'),
(206, '::1', '/g1/aphp/p6/sajt/proizvod.php', 'id=16', '', '2023-02-23 16:52:54'),
(207, '::1', '/g1/aphp/p6/sajt/proizvod.php', 'id=16', '', '2023-02-23 16:54:05'),
(208, '::1', '/g1/aphp/p6/sajt/proizvod.php', 'id=16', '', '2023-02-23 16:54:20'),
(209, '::1', '/g1/aphp/p6/sajt/proizvod.php', 'id=16', '', '2023-02-23 16:54:28'),
(210, '::1', '/g1/aphp/p6/sajt/proizvod.php', 'id=16', '', '2023-02-23 16:58:45'),
(211, '::1', '/g1/aphp/p6/sajt/proizvod.php', 'id=16', '', '2023-02-23 16:59:07'),
(212, '::1', '/g1/aphp/p6/sajt/proizvod.php', 'id=16', '', '2023-02-23 16:59:09'),
(213, '::1', '/g1/aphp/p6/sajt/proizvod.php', 'id=16', '', '2023-02-23 17:02:23'),
(214, '::1', '/g1/aphp/p6/sajt/proizvod.php', 'id=16', '', '2023-02-23 17:02:54'),
(215, '::1', '/g1/aphp/p6/sajt/index.php', '', '', '2023-02-23 17:03:51'),
(216, '::1', '/g1/aphp/p6/sajt/proizvod.php', 'id=13', '', '2023-02-23 17:03:52'),
(217, '::1', '/g1/aphp/p6/sajt/proizvod.php', 'id=13', '', '2023-02-23 17:04:10'),
(218, '::1', '/g1/aphp/p6/sajt/proizvod.php', 'id=13', '', '2023-02-23 17:07:30'),
(219, '::1', '/g1/aphp/p6/sajt/index.php', '', '', '2023-02-23 17:07:37'),
(220, '::1', '/g1/aphp/p6/sajt/proizvod.php', 'id=16', '', '2023-02-23 17:07:39'),
(221, '::1', '/g1/aphp/p6/sajt/index.php', '', '', '2023-02-23 17:07:47'),
(222, '::1', '/g1/aphp/p6/sajt/proizvod.php', 'id=10', '', '2023-02-23 17:07:49'),
(223, '::1', '/g1/aphp/p6/sajt/proizvod.php', 'id=10', '', '2023-02-23 17:08:45'),
(224, '::1', '/g1/aphp/p6/sajt/proizvod.php', 'id=10', '', '2023-02-23 17:09:04'),
(225, '::1', '/g1/aphp/p6/sajt/index.php', '', '', '2023-02-23 17:09:08'),
(226, '::1', '/g1/aphp/p6/sajt/proizvod.php', 'id=16', '', '2023-02-23 17:09:09'),
(227, '::1', '/g1/aphp/p6/sajt/proizvod.php', 'id=16', '', '2023-02-23 17:10:32'),
(228, '::1', '/g1/aphp/p6/sajt/proizvod.php', 'id=16', '', '2023-02-23 17:10:40'),
(229, '::1', '/g1/aphp/p6/sajt/index.php', '', '', '2023-02-23 17:10:43'),
(230, '::1', '/g1/aphp/p6/sajt/proizvod.php', 'id=16', '', '2023-02-23 17:10:48'),
(231, '::1', '/g1/aphp/p6/sajt/index.php', '', '', '2023-02-23 17:11:27'),
(232, '::1', '/g1/aphp/p6/sajt/proizvod.php', 'id=16', '', '2023-02-23 17:11:29'),
(233, '::1', '/g1/aphp/p6/sajt/proizvod.php', 'id=16', '', '2023-02-23 17:12:39'),
(234, '::1', '/g1/aphp/p6/sajt/proizvod.php', 'id=16', '', '2023-02-23 17:15:16'),
(235, '::1', '/g1/aphp/p6/sajt/index.php', '', '', '2023-02-23 17:15:29'),
(236, '::1', '/g1/aphp/p6/sajt/proizvod.php', 'id=16', '', '2023-02-23 17:15:30'),
(237, '::1', '/g1/aphp/p6/sajt/proizvod.php', 'id=16', '', '2023-02-23 17:15:34'),
(238, '::1', '/g1/aphp/p6/sajt/index.php', '', '', '2023-02-23 17:15:38'),
(239, '::1', '/g1/aphp/p6/sajt/proizvod.php', 'id=16', '', '2023-02-23 17:15:40'),
(240, '::1', '/g1/aphp/p6/sajt/index.php', '', '', '2023-02-23 17:15:51'),
(241, '::1', '/g1/aphp/p6/sajt/proizvod.php', 'id=16', '', '2023-02-23 17:15:53'),
(242, '::1', '/g1/aphp/p6/sajt/proizvod.php', 'id=16', '', '2023-02-23 17:16:33'),
(243, '::1', '/g1/aphp/p6/sajt/proizvod.php', 'id=16', '', '2023-02-23 17:16:38'),
(244, '::1', '/g1/aphp/p6/sajt/proizvod.php', 'id=16', '', '2023-02-23 17:17:16'),
(245, '::1', '/g1/aphp/p6/sajt/proizvod.php', 'id=16', '', '2023-02-23 17:19:53'),
(246, '::1', '/g1/aphp/p6/sajt/index.php', '', '', '2023-02-23 17:19:57'),
(247, '::1', '/g1/aphp/p6/sajt/proizvod.php', 'id=16', '', '2023-02-23 17:19:59'),
(248, '::1', '/g1/aphp/p6/sajt/proizvod.php', 'id=16', '', '2023-02-23 17:20:22'),
(249, '::1', '/g1/aphp/p6/sajt/proizvod.php', 'id=16', '', '2023-02-23 17:20:27'),
(250, '::1', '/g1/aphp/p6/sajt/index.php', '', '', '2023-02-23 17:21:05'),
(251, '::1', '/g1/aphp/p6/sajt/index.php', '', '', '2023-02-23 17:34:36'),
(252, '::1', '/g1/aphp/p6/sajt/proizvod.php', 'id=16', '', '2023-02-23 17:34:41'),
(253, '::1', '/g1/aphp/p6/sajt/index.php', '', '', '2023-02-23 17:34:53'),
(254, '::1', '/g1/aphp/p6/sajt/proizvod.php', 'id=13', '', '2023-02-23 17:34:55'),
(255, '::1', '/g1/aphp/p6/sajt/proizvod.php', 'id=13', '', '2023-02-23 17:35:32'),
(256, '::1', '/g1/aphp/p6/sajt/index.php', '', '', '2023-02-23 17:35:35'),
(257, '::1', '/g1/aphp/p6/sajt/proizvod.php', 'id=16', '', '2023-02-23 17:35:35'),
(258, '::1', '/g1/aphp/p6/sajt/proizvod.php', 'id=16', '', '2023-02-23 17:36:01'),
(259, '::1', '/g1/aphp/p6/sajt/index.php', '', '', '2023-02-23 17:43:11'),
(260, '::1', '/g1/aphp/p6/sajt/index.php', '', '', '2023-02-23 18:06:03'),
(261, '::1', '/g1/aphp/p6/sajt/index.php', '', '', '2023-02-23 18:16:34'),
(262, '::1', '/g1/aphp/p6/sajt/index.php', '', '', '2023-02-23 18:20:43'),
(263, '::1', '/g1/aphp/p6/sajt/index.php', '', '', '2023-02-23 18:43:46'),
(264, '::1', '/g1/aphp/p6/sajt/index.php', '', '', '2023-02-23 19:00:36'),
(265, '::1', '/g1/aphp/p6/sajt/proizvod.php', 'id=16', '', '2023-02-23 19:03:37'),
(266, '::1', '/g1/aphp/p6/sajt/proizvod.php', 'id=16', '', '2023-02-23 19:03:41'),
(267, '::1', '/g1/aphp/p6/sajt/proizvod.php', 'id=16', '', '2023-02-23 19:03:41'),
(268, '::1', '/g1/aphp/p6/sajt/proizvod.php', 'id=16', '', '2023-02-23 19:03:41'),
(269, '::1', '/g1/aphp/p6/sajt/proizvod.php', 'id=16', '', '2023-02-23 19:03:42'),
(270, '::1', '/g1/aphp/p6/sajt/proizvod.php', 'id=16', '', '2023-02-23 19:03:42'),
(271, '::1', '/g1/aphp/p6/sajt/index.php', '', '', '2023-02-23 19:03:53'),
(272, '::1', '/g1/aphp/p6/sajt/proizvod.php', 'id=13', '', '2023-02-23 19:03:54'),
(273, '::1', '/g1/aphp/p6/sajt/proizvod.php', 'id=13', '', '2023-02-23 19:03:56'),
(274, '::1', '/g1/aphp/p6/sajt/proizvod.php', 'id=13', '', '2023-02-23 19:03:56'),
(275, '::1', '/g1/aphp/p6/sajt/index.php', '', '', '2023-02-23 19:04:00'),
(276, '::1', '/g1/aphp/p6/sajt/proizvod.php', 'id=11', '', '2023-02-23 19:04:02'),
(277, '::1', '/g1/aphp/p6/sajt/proizvod.php', 'id=11', '', '2023-02-23 19:04:03'),
(278, '::1', '/g1/aphp/p6/sajt/proizvod.php', 'id=11', '', '2023-02-23 19:04:03'),
(279, '::1', '/g1/aphp/p6/sajt/proizvod.php', 'id=11', '', '2023-02-23 19:04:03'),
(280, '::1', '/g1/aphp/p6/sajt/index.php', '', '', '2023-02-23 19:10:56'),
(281, '::1', '/g1/aphp/p6/sajt/index.php', '', '', '2023-02-23 19:11:25'),
(282, '::1', '/g1/aphp/p6/sajt/index.php', '', '', '2023-02-23 19:12:06'),
(283, '::1', '/g1/aphp/p6/sajt/index.php', '', '', '2023-02-23 19:13:53'),
(284, '::1', '/g1/aphp/p6/sajt/index.php', '', '', '2023-02-23 19:14:28'),
(285, '::1', '/g1/cjs/p4/sajt/index.php', '', '', '2023-03-23 19:13:45'),
(286, '::1', '/g1/cjs/p4/sajt/proizvod.php', 'id=16', '', '2023-03-23 19:13:48'),
(287, '::1', '/g1/cjs/p4/sajt/proizvod.php', 'id=16', '', '2023-03-23 19:16:33'),
(288, '::1', '/g1/cjs/p4/sajt/proizvod.php', 'id=16', '', '2023-03-23 19:16:47'),
(289, '::1', '/g1/cjs/p4/sajt/proizvod.php', 'id=16', '', '2023-03-23 19:20:05'),
(290, '::1', '/g1/cjs/p4/sajt/proizvod.php', 'id=16', '', '2023-03-23 19:21:16'),
(291, '::1', '/g1/cjs/p4/sajt/proizvod.php', 'id=16', '', '2023-03-23 19:21:50'),
(292, '::1', '/g1/cjs/p4/sajt/proizvod.php', 'id=16', '', '2023-03-23 19:22:00'),
(293, '::1', '/g1/cjs/p4/sajt/proizvod.php', 'id=16', '', '2023-03-23 19:23:15'),
(294, '::1', '/g1/cjs/p4/sajt/proizvod.php', 'id=16', '', '2023-03-23 19:24:45'),
(295, '::1', '/g1/cjs/p4/sajt/proizvod.php', 'id=16', '', '2023-03-23 19:25:15'),
(296, '::1', '/g1/cjs/p4/sajt/proizvod.php', 'id=16', '', '2023-03-23 19:25:40'),
(297, '::1', '/g1/cjs/p4/sajt/proizvod.php', 'id=1', '', '2023-03-23 19:25:55'),
(298, '::1', '/g1/cjs/p4/sajt/proizvod.php', 'id=1', '', '2023-03-23 19:28:05'),
(299, '::1', '/g1/cjs/p4/sajt/proizvod.php', 'id=1', '', '2023-03-23 19:31:13'),
(300, '::1', '/g1/cjs/p4/sajt/proizvod.php', 'id=1', '', '2023-03-23 19:31:32'),
(301, '::1', '/g1/cjs/p4/sajt/proizvod.php', 'id=1', '', '2023-03-23 19:31:51'),
(302, '::1', '/g1/cjs/p4/sajt/proizvod.php', 'id=1', '', '2023-03-23 19:32:28'),
(303, '::1', '/g1/cjs/p4/sajt/proizvod.php', 'id=1', '', '2023-03-23 19:33:56'),
(304, '::1', '/g1/cjs/p4/sajt/index.php', '', '', '2023-03-23 19:34:16'),
(305, '::1', '/g1/cjs/p4/sajt/proizvod.php', 'id=16', '', '2023-03-23 19:34:17'),
(306, '::1', '/g1/cjs/p4/sajt/index.php', '', '', '2023-03-23 19:34:28'),
(307, '::1', '/g1/cjs/p4/sajt/proizvod.php', 'id=1', '', '2023-04-20 15:33:53'),
(308, '::1', '/g1/cjs/p4/sajt/index.php', '', '', '2023-04-20 15:34:02'),
(309, '::1', '/g1/cjs/p4/sajt/index.php', '', '', '2023-04-20 15:34:13'),
(310, '::1', '/g1/ajs/p4/sajt/index.php', '', '', '2023-04-27 13:52:35'),
(311, '::1', '/g1/ajs/p4/sajt/index.php', '', '', '2023-04-27 13:52:58'),
(312, '::1', '/g1/ajs/p4/sajt/index.php', '', '', '2023-04-27 13:53:34'),
(313, '::1', '/g1/ajs/p4/sajt/index.php', '', '', '2023-04-27 14:28:46'),
(314, '::1', '/g1/ajs/p4/sajt/index.php', '', '', '2023-04-27 14:29:12'),
(315, '::1', '/g1/ajs/p4/sajt/index.php', '', '', '2023-04-27 16:10:59'),
(316, '::1', '/g1/ajs/p4/sajt/index.php', '', '', '2023-04-27 16:11:05'),
(317, '::1', '/g1/aphp/p7/sajt/index.php', '', '', '2023-05-04 13:20:43'),
(318, '::1', '/g1/aphp/p7/sajt/index.php', '', '', '2023-05-04 13:21:14'),
(319, '::1', '/g1/aphp/p7/sajt/index.php', '', '', '2023-05-04 13:21:55'),
(320, '::1', '/g1/aphp/p7/sajt/index.php', '', '', '2023-05-04 13:31:59'),
(321, '::1', '/g1/aphp/p7/sajt/index.php', '', '', '2023-05-04 13:48:22'),
(322, '::1', '/g1/aphp/p7/sajt/proizvod.php', 'id=16', '', '2023-05-04 13:50:46'),
(323, '::1', '/g1/aphp/p7/sajt/index.php', '', '', '2023-05-04 13:51:12'),
(324, '::1', '/g1/aphp/p7/sajt/proizvod.php', 'id=10', '', '2023-05-04 13:55:22'),
(325, '::1', '/g1/aphp/p7/sajt/index.php', '', '', '2023-05-04 13:55:59'),
(326, '::1', '/g1/aphp/p7/sajt/index.php', '', '', '2023-05-04 16:06:43'),
(327, '::1', '/g1/aphp/p7/sajt/index.php', '', '', '2023-05-04 16:13:10'),
(328, '::1', '/g1/aphp/p7/sajt/index.php', '', '', '2023-05-04 16:18:56'),
(329, '::1', '/g1/aphp/p7/sajt/index.php', '', '', '2023-05-04 16:19:18'),
(330, '::1', '/g1/aphp/p7/sajt/index.php', '', '', '2023-05-04 16:50:20'),
(331, '::1', '/g1/aphp/p7/sajt/index.php', '', '', '2023-05-04 16:52:09'),
(332, '::1', '/g1/aphp/p7/sajt/index.php', '', '', '2023-05-04 16:52:20'),
(333, '::1', '/g1/aphp/p7/sajt/index.php', '', '', '2023-05-04 16:52:55'),
(334, '::1', '/g1/aphp/p7/sajt/index.php', '', '', '2023-05-04 17:03:58'),
(335, '::1', '/g1/aphp/p7/sajt/index.php', '', '', '2023-05-04 17:16:40'),
(336, '::1', '/g1/aphp/p7/sajt/index.php', '', '', '2023-05-04 17:16:47'),
(337, '::1', '/g1/aphp/p7/sajt/index.php', '', '', '2023-05-04 17:17:33'),
(338, '::1', '/g1/aphp/p7/sajt/index.php', '', '', '2023-05-04 17:18:06'),
(339, '::1', '/g1/aphp/p7/sajt/index.php', '', '', '2023-05-04 17:18:18'),
(340, '::1', '/g1/aphp/p7/sajt/index.php', '', '', '2023-05-04 17:18:24'),
(341, '::1', '/g1/aphp/p7/sajt/index.php', 'kategorija=6', '', '2023-05-04 17:51:37'),
(342, '::1', '/g1/aphp/p7/sajt/index.php', '', '', '2023-05-04 17:51:39'),
(343, '::1', '/g1/aphp/p7/sajt/index.php', '', '', '2023-05-04 17:52:27'),
(344, '::1', '/g1/aphp/p7/sajt/index.php', '', '', '2023-05-04 18:02:32'),
(345, '::1', '/g1/aphp/p7/sajt/index.php', '', '', '2023-05-04 18:24:10'),
(346, '::1', '/g1/xmlphp/p1/sajt/index.php', '', '', '2023-05-11 14:05:19'),
(347, '::1', '/g1/xmlphp/p1/sajt/index.php', '', '', '2023-05-11 14:05:50'),
(348, '::1', '/g1/xmlphp/p1/sajt/index.php', '', '', '2023-05-11 14:05:54'),
(349, '::1', '/g1/xmlphp/p1/sajt/index.php', '', '', '2023-05-11 14:07:31'),
(350, '::1', '/g1/xmlphp/p1/sajt/index.php', '', '', '2023-05-11 18:14:24'),
(351, '::1', '/g1/xmlphp/p1/sajt/index.php', '', '', '2023-05-11 18:14:32'),
(352, '::1', '/g1/xmlphp/p1/sajt/proizvod.php', 'id=16', '', '2023-05-11 18:14:33'),
(353, '::1', '/g1/xmlphp/p1/sajt/proizvod.php', 'id=16', '', '2023-05-11 18:16:39'),
(354, '::1', '/g1/xmlphp/p1/sajt/proizvod.php', 'id=16', '', '2023-05-11 18:17:02'),
(355, '::1', '/g1/xmlphp/p1/sajt/proizvod.php', 'id=16', '', '2023-05-11 18:17:13'),
(356, '::1', '/g1/xmlphp/p1/sajt/proizvod.php', 'id=16', '', '2023-05-11 18:18:54'),
(357, '::1', '/g1/xmlphp/p1/sajt/proizvod.php', 'id=16', '', '2023-05-11 18:19:04'),
(358, '::1', '/g1/xmlphp/p1/sajt/proizvod.php', 'id=16', '', '2023-05-11 18:26:38'),
(359, '::1', '/g1/xmlphp/p1/sajt/proizvod.php', 'id=16', '', '2023-05-11 18:27:37'),
(360, '::1', '/g1/xmlphp/p1/sajt/proizvod.php', 'id=16', '', '2023-05-11 18:28:50'),
(361, '::1', '/g1/xmlphp/p1/sajt/proizvod.php', 'id=16', '', '2023-05-11 18:28:55'),
(362, '::1', '/g1/xmlphp/p1/sajt/proizvod.php', 'id=16', '', '2023-05-11 18:28:59'),
(363, '::1', '/g1/xmlphp/p1/sajt/proizvod.php', 'id=16', '', '2023-05-11 18:29:13'),
(364, '::1', '/g1/xmlphp/p1/sajt/proizvod.php', 'id=16', '', '2023-05-11 18:30:39'),
(365, '::1', '/g1/xmlphp/p1/sajt/proizvod.php', 'id=16', '', '2023-05-11 18:35:23'),
(366, '::1', '/g1/xmlphp/p1/sajt/index.php', '', '', '2023-05-11 18:35:28'),
(367, '::1', '/g1/xmlphp/p1/sajt/index.php', '', '', '2023-05-11 18:36:28'),
(368, '::1', '/g1/xmlphp/p1/sajt/index.php', 'kategorija=1', '', '2023-05-11 18:36:33'),
(369, '::1', '/g1/xmlphp/p1/sajt/index.php', 'kategorija=2', '', '2023-05-11 18:36:35'),
(370, '::1', '/g1/xmlphp/p1/sajt/index.php', 'kategorija=3', '', '2023-05-11 18:36:37'),
(371, '::1', '/g1/xmlphp/p1/sajt/index.php', 'kategorija=6', '', '2023-05-11 18:36:38'),
(372, '::1', '/g1/xmlphp/p1/sajt/index.php', '', '', '2023-05-11 18:36:53');

-- --------------------------------------------------------

--
-- Table structure for table `vesti`
--

DROP TABLE IF EXISTS `vesti`;
CREATE TABLE IF NOT EXISTS `vesti` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `naslov` varchar(200) NOT NULL,
  `tekst` text NOT NULL,
  `kategorija` int(3) NOT NULL,
  `autor` int(3) NOT NULL,
  `vremeK` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `vremeI` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `obrisan` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `vesti`
--

INSERT INTO `vesti` (`id`, `naslov`, `tekst`, `kategorija`, `autor`, `vremeK`, `vremeI`, `obrisan`) VALUES
(1, 'Mitrović obrće Premijer ligu – dve asistencije, pa gol', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla a sodales sem. Mauris libero ipsum, varius sit amet nulla at, maximus scelerisque quam. Phasellus at diam laoreet, faucibus augue ac, aliquet massa. Etiam a metus non enim molestie ornare eu eu quam. Nam venenatis nunc mauris, vitae hendrerit metus posuere non. In condimentum sagittis diam quis semper. Duis efficitur lacinia ligula, vel aliquam diam pharetra eu. Nullam dolor risus, iaculis porta urna in, mattis venenatis purus. Nam in diam eu tellus porta luctus eu in lacus. Suspendisse viverra suscipit eros et tempor. Quisque tincidunt ullamcorper posuere. Mauris dictum molestie nisi, sit amet porttitor mauris iaculis nec.', 1, 1, '2022-12-04 17:09:15', '2023-01-12 17:35:34', 0),
(2, 'Gordon izveo zakucavanje godine; Jokić: Bio sam otvoren', 'Ut tristique ante sed risus dictum, a cursus risus sodales. Nunc pharetra massa ac odio ullamcorper faucibus. In quam nisi, fermentum vitae augue id, venenatis porta lectus. Maecenas ac sagittis justo, at fringilla tellus. Quisque auctor ut lorem et sodales. Vivamus viverra ligula sed vestibulum efficitur. Maecenas commodo eu urna vel sagittis. Donec ac tempus ligula. Sed at luctus nisi, a iaculis velit. Sed eu gravida metus. Donec ac lacus id enim tincidunt lobortis. Duis commodo libero at pellentesque finibus. Nam imperdiet, tellus et ultrices venenatis, magna est posuere ante, vel dictum nulla massa vitae nisi. Sed ultricies felis sapien, sit amet scelerisque ante luctus nec. Phasellus sodales lorem diam, quis commodo turpis auctor et.', 2, 1, '2022-12-26 17:09:15', '2023-01-12 16:55:28', 0),
(3, 'Postoji način da poboljšate kardiovaskularne sposobnosti, otkriven je pre 50 godina i to slučajno', 'Sed feugiat, mauris posuere imperdiet aliquam, tortor lacus tempus urna, et semper turpis dui eget odio. Mauris ut magna elit. Integer nec ultrices quam. Praesent vulputate orci justo, eget viverra est imperdiet ut. Ut eget porttitor sapien. Fusce varius nibh eget sem vehicula aliquam. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Quisque aliquam bibendum est, vitae varius ligula consectetur eu.', 3, 2, '2022-12-30 17:10:41', '2023-01-12 17:35:38', 0),
(4, 'Lekar otkrio šta se dešava u organizmu ako san traje duže od 9 sati', 'Maecenas laoreet euismod faucibus. Morbi malesuada sit amet risus eget pellentesque. Nunc vel ante vitae urna convallis porttitor. Nunc est lorem, vulputate eu ultricies non, consequat non nisi. Sed eget blandit ex, ac iaculis massa. Phasellus hendrerit varius tellus ac feugiat. Donec orci ex, lobortis non laoreet non, ornare nec dui. Quisque convallis dignissim lacus id eleifend.', 3, 2, '2022-12-26 17:10:41', '2023-01-12 16:55:44', 0),
(5, 'Svetski kuvari presudili; Objavljen spisak deset najboljih srpskih jela', 'Nullam efficitur, nibh nec luctus placerat, mauris magna faucibus arcu, in suscipit felis sem nec erat. Aliquam quis quam arcu. Aenean blandit imperdiet turpis, vitae ornare ligula laoreet nec. Nullam accumsan tortor vel suscipit fringilla. Sed dolor nibh, consequat quis convallis eget, imperdiet vel tortor. Nam imperdiet id augue quis dictum. Etiam suscipit et massa non gravida.', 4, 3, '2022-12-26 17:11:39', '2023-01-12 16:55:48', 0),
(6, 'Mitrović obrće Premijer ligu OPET – tri asistencije, pa 2 gola', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla a sodales sem. Mauris libero ipsum, varius sit amet nulla at, maximus scelerisque quam. Phasellus at diam laoreet, faucibus augue ac, aliquet massa. Etiam a metus non enim molestie ornare eu eu quam. Nam venenatis nunc mauris, vitae hendrerit metus posuere non. In condimentum sagittis diam quis semper. Duis efficitur lacinia ligula, vel aliquam diam pharetra eu. Nullam dolor risus, iaculis porta urna in, mattis venenatis purus. Nam in diam eu tellus porta luctus eu in lacus. Suspendisse viverra suscipit eros et tempor. Quisque tincidunt ullamcorper posuere. Mauris dictum molestie nisi, sit amet porttitor mauris iaculis nec.', 1, 3, '2022-12-05 17:09:15', '2023-01-12 17:35:26', 0),
(7, 'Nikola Jokić car!!!', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. In arcu cursus euismod quis viverra nibh cras. Nam libero justo laoreet sit amet cursus sit amet dictum. Libero enim sed faucibus turpis in. Neque convallis a cras semper auctor. In arcu cursus euismod quis viverra nibh cras pulvinar. Vulputate mi sit amet mauris. Ornare arcu dui vivamus arcu felis bibendum ut. Risus feugiat in ante metus dictum at tempor. Nibh sit amet commodo nulla facilisi nullam vehicula ipsum. Venenatis urna cursus eget nunc scelerisque viverra mauris in aliquam. Sed nisi lacus sed viverra tellus in. Adipiscing tristique risus nec feugiat in fermentum posuere. Dui vivamus arcu felis bibendum ut tristique et egestas. Mi proin sed libero enim sed faucibus turpis in eu. Nisi quis eleifend quam adipiscing vitae proin sagittis nisl. Commodo odio aenean sed adipiscing diam donec adipiscing tristique risus.', 5, 1, '2023-01-12 18:03:26', NULL, 0),
(8, 'Ovo je naslov iz INSERT INTO upita', 'Ovo je Lorem Ipsum sadržaj', 1, 1, '2023-01-12 18:07:49', NULL, 0),
(9, 'Ovo je uneo Boško sa stranice', 'Accumsan lacus vel facilisis volutpat est velit. Egestas integer eget aliquet nibh. Duis tristique sollicitudin nibh sit. At risus viverra adipiscing at. Donec et odio pellentesque diam volutpat commodo. At varius vel pharetra vel turpis nunc eget lorem. Mauris pharetra et ultrices neque ornare aenean. Vel turpis nunc eget lorem dolor sed. Enim ut sem viverra aliquet eget sit. Maecenas pharetra convallis posuere morbi leo urna molestie at elementum. Gravida rutrum quisque non tellus orci. Eget lorem dolor sed viverra ipsum. Nunc vel risus commodo viverra maecenas accumsan lacus vel. At lectus urna duis convallis convallis tellus id interdum velit. Nunc id cursus metus aliquam eleifend mi. At ultrices mi tempus imperdiet nulla malesuada pellentesque elit.', 5, 1, '2023-01-12 18:22:40', NULL, 0),
(10, 'Ovo je uneo Boško sa stranice ali ponovo', 'Ultrices dui sapien eget mi proin sed libero. Interdum velit euismod in pellentesque. Scelerisque viverra mauris in aliquam sem. Praesent elementum facilisis leo vel fringilla est ullamcorper eget. Dui nunc mattis enim ut tellus elementum sagittis. Eleifend mi in nulla posuere sollicitudin aliquam ultrices sagittis orci. Turpis egestas pretium aenean pharetra magna. Tempus quam pellentesque nec nam aliquam sem. Diam phasellus vestibulum lorem sed risus ultricies tristique nulla aliquet. Sit amet consectetur adipiscing elit pellentesque habitant morbi tristique. Neque vitae tempus quam pellentesque nec nam aliquam sem et. Elementum pulvinar etiam non quam lacus suspendisse. Sem et tortor consequat id porta nibh. Eu facilisis sed odio morbi quis commodo odio aenean sed. Volutpat lacus laoreet non curabitur gravida. Pharetra convallis posuere morbi leo urna molestie at. Eu feugiat pretium nibh ipsum consequat nisl vel. Risus feugiat in ante metus dictum at tempor commodo ullamcorper.', 3, 1, '2023-01-12 18:23:41', NULL, 0),
(11, 'Ovo je za statistiku', 'Lectus nulla at volutpat diam ut venenatis tellus in. Amet aliquam id diam maecenas ultricies mi eget. Dolor morbi non arcu risus quis. Tellus in hac habitasse platea. Leo in vitae turpis massa sed elementum tempus egestas. Egestas congue quisque egestas diam in arcu. Varius vel pharetra vel turpis nunc eget lorem dolor sed. Sit amet massa vitae tortor condimentum lacinia quis vel. Dictumst quisque sagittis purus sit. Posuere sollicitudin aliquam ultrices sagittis orci. Quis viverra nibh cras pulvinar mattis nunc sed blandit libero.', 1, 1, '2023-01-12 18:51:28', '2023-01-12 19:16:43', 0),
(13, 'Nokia 3310', 'Stara 15 godina.\r\nBaterija drži 14 dana aktivnog korišćenja.\r\nBaba ga koristila samo komšinicu da zove.\r\nCena 300 evrića', 6, 1, '2023-01-19 18:27:08', '2023-01-19 18:27:49', 0);

-- --------------------------------------------------------

--
-- Structure for view `pogledkorpa`
--
DROP TABLE IF EXISTS `pogledkorpa`;

DROP VIEW IF EXISTS `pogledkorpa`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `pogledkorpa`  AS SELECT `korpa`.`id` AS `id`, `korpa`.`korisnik_id` AS `korisnik_id`, `korpa`.`proizvod_id` AS `proizvod_id`, `korpa`.`kupljen` AS `kupljen`, `korpa`.`vremeDodavanja` AS `vremeDodavanja`, `korpa`.`vremeKupovine` AS `vremeKupovine`, `proizvodi`.`naslov` AS `naslov`, `proizvodi`.`cena` AS `cena` FROM (`korpa` join `proizvodi` on((`korpa`.`proizvod_id` = `proizvodi`.`id`))) ;

-- --------------------------------------------------------

--
-- Structure for view `pogledproizvodi`
--
DROP TABLE IF EXISTS `pogledproizvodi`;

DROP VIEW IF EXISTS `pogledproizvodi`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `pogledproizvodi`  AS SELECT `proizvodi`.`id` AS `id`, `proizvodi`.`naslov` AS `naslov`, `proizvodi`.`tekst` AS `tekst`, `proizvodi`.`kategorija` AS `kategorija`, `proizvodi`.`autor` AS `autor`, `proizvodi`.`vremeK` AS `vremeK`, `proizvodi`.`vremeI` AS `vremeI`, `proizvodi`.`obrisan` AS `obrisan`, `proizvodi`.`pogledan` AS `pogledan`, `korisnici`.`ime` AS `ime`, `korisnici`.`prezime` AS `prezime`, `kategorije`.`naziv` AS `naziv` FROM ((`proizvodi` join `korisnici` on((`proizvodi`.`autor` = `korisnici`.`id`))) join `kategorije` on((`proizvodi`.`kategorija` = `kategorije`.`id`))) ;

-- --------------------------------------------------------

--
-- Structure for view `pogledvesti`
--
DROP TABLE IF EXISTS `pogledvesti`;

DROP VIEW IF EXISTS `pogledvesti`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `pogledvesti`  AS SELECT `vesti`.`id` AS `id`, `vesti`.`naslov` AS `naslov`, `vesti`.`tekst` AS `tekst`, `vesti`.`kategorija` AS `kategorija`, `vesti`.`autor` AS `autor`, `vesti`.`vremeK` AS `vremeK`, `vesti`.`vremeI` AS `vremeI`, `vesti`.`obrisan` AS `obrisan`, `korisnici`.`ime` AS `ime`, `korisnici`.`prezime` AS `prezime`, `kategorije`.`naziv` AS `naziv` FROM ((`vesti` join `korisnici` on((`vesti`.`autor` = `korisnici`.`id`))) join `kategorije` on((`vesti`.`kategorija` = `kategorije`.`id`))) ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
