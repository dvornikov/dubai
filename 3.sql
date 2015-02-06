DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `parent_id` int(11) NOT NULL DEFAULT '0',
    `name` varchar(255) NOT NULL DEFAULT '',
    PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
insert into `categories` (`parent_id`, `name`) values
(0, 'sector1'),
(0, 'sector2'),
(0, 'sector3'),
(1, 'industry1'),
(1, 'industry2'),
(1, 'industry3');
