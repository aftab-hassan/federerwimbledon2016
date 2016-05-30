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

/* getting links to stats of all 46 matches */
$allmatchURLs = array();
$urlPattern = "https://matchstat.com/tennis/match-stats/m/";
$exitPattern = "Recently Played";
$winnerPattern = "data-winner";
$tournamentnamePattern = "<td class=\"tmt\">";

$file = fopen($pageURL,"r");
$matchCount = 0;
while ( ($line = fgets($file)) !== false)
{
    echo "\n";

//    echo strlen($line);
//    echo $line;

    /* break */
    if ((strpos($line, $exitPattern) !== false))
    {
        //        exit;
        break;
    }

    /* tournament name */
    if ((strpos($line, $exitPattern) !== false))
    {
        echo $line;
    }

    /* winner */
    if ((strpos($line, $exitPattern) !== false))
    {
        echo $line;
    }

    /* match URL */
    if ((strpos($line, $urlPattern) !== false))
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
//$rogernovakArray = array();
////for($i = 0; $i < count($allmatchURLs); $i++)
//for($i = 0; $i < 5; $i++)
//{
//    $url = $allmatchURLs[$i];
//    $ch = curl_init();
//    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
//    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
//    curl_setopt($ch, CURLOPT_URL, $url);
//    $jsonstring = curl_exec($ch);
//    curl_close($ch);
//
//    $jsonobj = json_decode($jsonstring,true);
//
//    array_push($rogernovakArray,$jsonobj['stats'][0]);
//    array_push($rogernovakArray,$jsonobj['stats'][1]);
//}
//print_r($rogernovakArray);
//
//
///* writing to csv file */
//$fp = fopen('data.csv', 'w');
//foreach ($rogernovakArray as $fields) {
//    fputcsv($fp, $fields);
//}
//fclose($fp);
?>