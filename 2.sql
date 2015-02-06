DROP TABLE IF EXISTS `products`;
CREATE TABLE `products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(500) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
INSERT INTO `products` (`name`) SELECT CONCAT('product_', @row := @row + 1) FROM
(select 0 union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) t,
(select 0 union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) t2,
(select 0 union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) t3,
(select 0 union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) t4,
(SELECT @row:=0) t5;
-- (select 0 union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) t,
-- (select 0 union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) t2,
-- (select 0 union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) t3,
-- (select 0 union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) t4,
-- (select 0 union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) t5,
-- (SELECT @row:=0) t6;

DROP TABLE IF EXISTS `warehouse`;
CREATE TABLE `warehouse` (
    `date` date NOT NULL,
    `products_id` int(11) NOT NULL,
    `balance` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
INSERT INTO `warehouse` (`balance`, `date`, `products_id`) SELECT FLOOR(RAND() * 100), NOW() - INTERVAL FLOOR(RAND() * 14) DAY, `id` FROM `products`;

DROP TABLE IF EXISTS `agents`;
CREATE TABLE `agents` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `shop_id` int(11) NOT NULL,
    `name` varchar(500) NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
INSERT INTO `agents` (`shop_id`, `name`) SELECT @row + 1, CONCAT('agent_', @row := @row + 1) FROM
(select 0 union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) t,
(select 0 union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) t2,
(select 0 union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) t3,
(select 0 union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) t4,
(SELECT @row:=0) t5;

-- судя по date — это готовая статистика, а не лог продаж.
DROP TABLE IF EXISTS `agent_stats`;
CREATE TABLE `agent_stats` (
    `agent_id` int(11) NOT NULL,
    `products_id` int(11) NOT NULL,
    `date` date NOT NULL,
    `orders` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
INSERT INTO `agent_stats` (`agent_id`, `products_id`, `date`, `orders`) SELECT `agents`.id `agent_id`, `products`.`id` `products_id`, NOW() - INTERVAL FLOOR(RAND() * 14) DAY, FLOOR(RAND() * 100) FROM `products`, `agents` ORDER BY RAND() LIMIT 1000;
