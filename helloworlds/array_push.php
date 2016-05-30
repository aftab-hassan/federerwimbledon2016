<?php
/**
 * Created by PhpStorm.
 * User: aftab
 * Date: 5/30/2016
 * Time: 2:09 PM
 */

$stack = array();

for($i = 0;$i < 10;$i++)
{
    array_push($stack, "apple");
}
print_r($stack);
echo count($stack);
?>