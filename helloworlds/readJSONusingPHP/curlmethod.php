<?php
/**
 * Created by PhpStorm.
 * User: aftab
 * Date: 5/30/2016
 * Time: 9:06 AM
 */

$url = "https://matchstat.com/tennis/match-stats/m/8348298";
$ch = curl_init();
curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_URL, $url);
$jsonstring = curl_exec($ch);
curl_close($ch);

$jsonobj = json_decode($jsonstring,true);
var_dump($jsonobj['stats'][0]);
echo $jsonobj['stats'][0]['match_stats_id'];
?>