<?php
class ABC {
    static function get_category($sector_name, $industry_name)
    {
        $mysqli = new mysqli("localhost", "root", "", "dubai");

        $query = "SELECT `c`.`id` `cid`, `c`.`name` `sector`, `i`.`id` `iid`, `i`.`name` `industry`, `i`.`parent_id` FROM `categories` `c`
        LEFT JOIN (
            SELECT * FROM `categories`
            WHERE `name` LIKE '%$industry_name%'
        ) `i` ON `i`.`parent_id` = `c`.`id`
        WHERE `c`.`name` LIKE '%$sector_name%'
        LIMIT 1";

        $sid = null;
        $iid = null;

        if ($result = $mysqli->query($query)) {
            $row = $result->fetch_object();

            $sid = $row->cid;
            $iid = $row->iid;

            if (!$row->iid) {
                $mysqli->query("INSERT INTO `categories` (`name`, `parent_id`) VALUES ('$industry_name', {$row->cid})");
                $iid = $mysqli->insert_id;
            }
        }
        else {
            $mysqli->query("INSERT INTO `categories` (`name`, `parent_id`) VALUES ('$sector_name',0)");
            $sid = $mysqli->insert_id;

            $mysqli->query("INSERT INTO `categories` (`name`, `parent_id`) VALUES ('$industry_name',$sid)");
            $iid = $mysqli->insert_id;
        }

        return array($sid, $iid);
    }
}
var_dump(ABC::get_category('sector3', 'industry2'));

// SELECT `c`.`id` `cid`, `c`.`name` `sector`, `i`.`id` `iid`, `i`.`name` `industry`, `i`.`parent_id` FROM `categories` `c`
// LEFT JOIN (
//     SELECT * FROM `categories`
//     WHERE `name` LIKE '%industry2%'
// ) `i` ON `i`.`parent_id` = `c`.`id`
// WHERE `c`.`name` LIKE '%sector2%';
?>
