<?php
/**
 * Created by PhpStorm.
 * User: aftab
 * Date: 5/30/2016
 * Time: 9:06 AM
 */

//this is the page which contains all the stats
$pageURL = "https://matchstat.com/tennis/h2h-odds-bets/Roger%20Federer/Novak%20Djokovic";

//this is an array of 45 matches * 2 players == 90 records
$rogernovakArray = array();

//getting links to stats of all 45 matches
$allmatchURL = array();
$file = fopen($pageURL,"r");
while ( ($line = fgets($file)) !== false)
{
    echo strlen($line);
//    echo $line;
}
fclose($file);

//$handle = fopen($pageURL, "r");
//if ($handle) {
//    while (($line = fgets($handle)) !== false) {
//        // process the line read.
//        echo strlen($line);
//    }
//
//    fclose($handle);
//} else {
//    // error opening the file.
//}

//$matchURL = "https://matchstat.com/tennis/match-stats/m/8348298";
//$ch = cmatchURL_init();
//curl_setopt($ch, CmatchURLOPT_SSL_VERIFYPEER, false);
//curl_setopt($ch, CmatchURLOPT_RETURNTRANSFER, true);
//curl_setopt($ch, CmatchURLOPT_matchURL, $matchURL);
//$jsonstring = cmatchURL_exec($ch);
//cmatchURL_close($ch);
//
//$jsonobj = json_decode($jsonstring,true);
//
//array_push($rogernovakArray,$jsonobj['stats'][0]);
//
//var_dump($rogernovakArray);
?>