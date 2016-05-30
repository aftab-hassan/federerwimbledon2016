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

//getting links to stats of all 45 matches
$allmatchURLs = array();
$pattern = "https://matchstat.com/tennis/match-stats/m/";
$exitpattern = "Recently Played";

$file = fopen($pageURL,"r");
$matchCount = 0;
while ( ($line = fgets($file)) !== false)
{
//    echo strlen($line);
//    echo $line;

    if ((strpos($line, $exitpattern) !== false))
    {
        //        exit;
        break;
    }

    if ((strpos($line, $pattern) !== false))
    {
        $matchCount++;

        if($matchCount > 1)
        {
//            <a class="btn-stats" href="https://matchstat.com/tennis/match-stats/m/8339482">
            $url = GetBetween("href=\"","\">",$line);
            array_push($allmatchURLs,$url);
        }
    }
}
fclose($file);
//print_r($allmatchURLs);

//iterating all matchURLs and pushing stats to $rogernovakArray
//this is an array of 45 matches * 2 players == 90 records
$rogernovakArray = array();
//for($i = 0; $i < count($allmatchURLs); $i++)
for($i = 0; $i < 1; $i++)
{
//    $url = "https://matchstat.com/tennis/match-stats/m/8348298";
    $url = $allmatchURLs[$i];
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_URL, $url);
    $jsonstring = curl_exec($ch);
    curl_close($ch);

    $jsonobj = json_decode($jsonstring,true);
//    var_dump($jsonobj['stats'][0]);
//    echo $jsonobj['stats'][0]['match_stats_id'];

    $jsonobj['stats'][0]['newfield'] = 99;
    $jsonobj['stats'][1]['newfield'] = 199;

    array_push($rogernovakArray,$jsonobj['stats'][0]);
    array_push($rogernovakArray,$jsonobj['stats'][1]);
}
print_r($rogernovakArray);
?>