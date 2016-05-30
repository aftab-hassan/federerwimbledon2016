<?php
/**
 * Created by PhpStorm.
 * User: aftab
 * Date: 5/30/2016
 * Time: 9:06 AM
 */

$url = "https://matchstat.com/tennis/match-stats/m/8348298";
$jsonstring = file_get_contents($url);
echo $jsonstring;
$jsonobj = json_decode($jsonstring);
var_dump($jsonobj);
?>