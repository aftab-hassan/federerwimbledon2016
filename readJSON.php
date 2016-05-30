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
$pattern = "https://matchstat.com/tennis/match-stats/m/";
$exitpattern = "Recently Played";
while ( ($line = fgets($file)) !== false)
{
//    echo strlen($line);
//    echo $line;
    
    if ((strpos($line, $pattern) !== false))
        exit;

    if ((strpos($line, $pattern) !== false))
    {
//        /* <td style="text-align:center;"><i><a href="/wiki/Marupuram_(2016_film)" title="Marupuram (2016 film)">Marupuram</a></i></td> */
//        $data = GetBetween("title","</a></i></td>",$line);
//        $moviename = substr($data, strpos($data, ">") + 1);
//
//        /* otherwise the table formatting gets affected */
//        if(strlen($moviename) < 50)
//            array_push($movienamearray, $moviename);
//
//        $moviecount++;;
//        $i++;

        echo $line;
    }

}
fclose($file);

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