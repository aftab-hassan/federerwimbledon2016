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
$winnerArray = array();
$tournamentnameArray = array();
$scoreArray = array();
$dateArray = array();$nextLineDate = 0;
$roundArray = array();$nextLineRound = 0;
$urlPattern = "https://matchstat.com/tennis/match-stats/m/";
$exitPattern = "Recently Played";
$winnerPattern = "data-winner";
$tournamentnamePattern = "<td class=\"tmt\">";
$scorePattern = "<td class=\"score\">";
$datePattern = "<tr class=\"date h2h-entry\">";
$roundPattern = "<td class=\"rnd\">";

$file = fopen($pageURL,"r");
$matchCount = 0;
while ( ($line = fgets($file)) !== false)
{
//    echo strlen($line);
//    echo $line;

    /* break */
    if ((strpos($line, $exitPattern) !== false))
    {
        //        exit;
        break;
    }

//    /* <td class="tmt"><a href="https://matchstat.com/tennis/tournaments/m/Australian%20Open/2016">Australian Open</a></td> */
//    /* tournament name */
//    if ((strpos($line, $tournamentnamePattern) !== false))
//    {
//        $tournamentname = GetBetween("\">","</a>",$line);
//        $tournamentname = $tournamentname."</a>";
//        $tournamentname = GetBetween("\">","</a>",$tournamentname);
//        array_push($tournamentnameArray,$tournamentname);
//    }
//
//    /* <td class="w h2h-winner" data-winner="A"><a href="https://matchstat.com/tennis/player/Novak%20Djokovic">Novak Djokovic</a> </td> */
//    /* winner */
//    if ((strpos($line, $winnerPattern) !== false))
//    {
//        $winner = GetBetween("\">","</a>",$line);
//        $winner = $winner."</a>";
//        $winner = GetBetween("\">","</a>",$winner);
//        array_push($winnerArray,$winner);
//    }
//
//    /* match URL */
//    if ((strpos($line, $urlPattern) !== false))
//    {
//        $matchCount++;
//
//        if($matchCount > 1)
//        {
////            <a class="btn-stats" href="https://matchstat.com/tennis/match-stats/m/8339482">
//            $url = GetBetween("href=\"","\">",$line);
//            array_push($allmatchURLs,$url);
//        }
//    }

    /* <td class="score">7-5 6-2</td> */
    /* match score */
    if ((strpos($line, $scorePattern) !== false))
    {
        $score = GetBetween("\"score\">","</td>",$line);
        array_push($scoreArray,$score);
    }

    /* <tr class="date h2h-entry">
                                <td>46/2015</td>
     */
    /* match date */
    if($nextLineDate == 1)
    {
        $matchDate = GetBetween("<td>","</td>",$line);
        array_push($dateArray,$matchDate);
    }
    if ((strpos($line, $datePattern) !== false))
        $nextLineDate = 1;
    else
        $nextLineDate = 0;

    /* <td class="rnd">
                                    RR A
     */
    /* round */
    if($nextLineRound == 1)
    {
        array_push($roundArray,trim($line));
    }
    if ((strpos($line, $roundPattern) !== false))
        $nextLineRound = 1;
    else
        $nextLineRound = 0;
}
fclose($file);
//print_r($allmatchURLs);
//print_r($tournamentnameArray);
//print_r($winnerArray);
print_r($scoreArray);
print_r($dateArray);
print_r($roundArray);

////iterating all matchURLs and pushing stats to $rogernovakArray
////this is an array of 45 matches * 2 players == 90 records
//$rogernovakArray = array();
//for($i = 0; $i < count($allmatchURLs); $i++)
////for($i = 0; $i < 5; $i++)
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
//    //padding tournament name
//    $jsonobj['stats'][0]['tournament'] = $tournamentnameArray[$i];
//    $jsonobj['stats'][1]['tournament'] = $tournamentnameArray[$i];
//
//    //padding winner information
//    if($jsonobj['stats'][0]['player_fullname'] == $winnerArray[$i])
//    {
//        $jsonobj['stats'][0]['win'] = 1;
//        $jsonobj['stats'][1]['win'] = 0;
//    }
//    else
//    {
//        $jsonobj['stats'][0]['win'] = 0;
//        $jsonobj['stats'][1]['win'] = 1;
//    }
//
//    array_push($rogernovakArray,$jsonobj['stats'][0]);
//    array_push($rogernovakArray,$jsonobj['stats'][1]);
//}
//print_r($rogernovakArray);
//
///* writing to csv file */
//$fp = fopen('data.csv', 'w');
//fputcsv($fp, array_keys($rogernovakArray[0]));
//foreach ($rogernovakArray as $fields) {
//    fputcsv($fp, $fields);
//}
//fclose($fp);
?>