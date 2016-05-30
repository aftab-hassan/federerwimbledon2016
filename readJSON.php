<?php
/**
 * Created by PhpStorm.
 * User: aftab
 * Date: 5/30/2016
 * Time: 9:06 AM
 */

//helper function to get text between two pointers in a string
function GetBetween($var1="",$var2="",$pool){
    $temp1 = strpos($pool,$var1)+strlen($var1);
    $result = substr($pool,$temp1,strlen($pool));
    $dd=strpos($result,$var2);
    if($dd == 0){
        $dd = strlen($result);
    }

    return substr($result,0,$dd);
}

//this is the page which contains all the stats
$pageURL = "https://matchstat.com/tennis/h2h-odds-bets/Roger%20Federer/Novak%20Djokovic";

//this is an array of 45 matches * 2 players == 90 records
$rogernovakArray = array();

//getting links to stats of all 45 matches
$allmatchURL = array();
$pattern = "https://matchstat.com/tennis/match-stats/m/";
$exitpattern = "Recently Played";

$file = fopen($pageURL,"r");
$matchCount = 0;
while ( ($line = fgets($file)) !== false)
{
//    echo strlen($line);
//    echo $line;

    if ((strpos($line, $exitpattern) !== false))
        exit;

    if ((strpos($line, $pattern) !== false))
    {
        $matchCount++;

        if($matchCount > 1)
        {
//            <a class="btn-stats" href="https://matchstat.com/tennis/match-stats/m/8339482">
            echo GetBetween("href=\"","\">",$line);
            array_push($allmatchURL,GetBetween("href=\"","\">",$line));
        }
    }
}
fclose($file);
var_dump($allmatchURL);

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