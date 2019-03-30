CREATE TABLE IF NOT EXISTS `owned_shops` (
  `identifier` varchar(250) DEFAULT NULL,
  `ShopNumber` int(11) DEFAULT NULL,
  `money` int(11) DEFAULT '0',
  `ShopValue` int(11) DEFAULT NULL,
  `LastRobbery` int(11) DEFAULT '0',
  `ShopName` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `owned_shops` (`identifier`, `ShopNumber`, `money`, `ShopValue`, `LastRobbery`, `ShopName`) VALUES
  ('0', 1, 0, 140000, 1549643682, '0'),
  ('0', 2, 0, 110000, 1549643682, '0'),
  ('0', 3, 0, 125000, 1549643682, '0'),
  ('0', 4, 0, 145000, 1549643682, '0'),
  ('0', 5, 0, 75000, 1549643682, '0'),
  ('0', 6, 0, 125000, 1549643682, '0'),
  ('0', 7, 0, 80000, 1549643682, '0'),
  ('0', 8, 0, 135000, 1549643682, '0'),
  ('0', 9, 0, 135000, 1549643682, '0'),
  ('0', 10, 0, 150000, 1549643682, '0'),
  ('0', 12, 0, 75000, 1549643682, '0'),
  ('0', 13, 0, 75000, 1549643682, '0'),
  ('0', 14, 0, 140000, 1549643682, '0'),
  ('0', 15, 0, 150000, 1549643682, '0'),
  ('0', 16, 0, 215000, 1549643682, '0'),
  ('0', 18, 0, 115000, 1549643682, '0'),
  ('0', 11, 0, 115000, 1549643682, '0'),
  ('0', 19, 0, 70000, 1549643682, '0'),
  ('0', 20, 0, 85000, 1549643682, '0'),
  ('0', 17, 0, 80000, 1549643682, '0');
  
CREATE TABLE IF NOT EXISTS `shipments` (
  `id` int(11) DEFAULT NULL,
  `identifier` varchar(50) DEFAULT NULL,
  `label` varchar(50) DEFAULT NULL,
  `item` varchar(50) DEFAULT NULL,
  `price` varchar(50) DEFAULT NULL,
  `count` varchar(50) DEFAULT NULL,
  `time` int(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE IF NOT EXISTS `shops` (
  `ShopNumber` int(11) NOT NULL DEFAULT '0',
  `src` varchar(50) NOT NULL,
  `count` int(11) NOT NULL,
  `item` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `price` int(11) NOT NULL,
  `label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
