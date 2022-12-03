<?php

$codes = array(
  "A" => "r",
  "B" => "p",
  "C" => "s",
);

$handStrategy = array(
  "rX" => "s",
  "rY" => "r",
  "rZ" => "p",

  "pX" => "r",
  "pY" => "p",
  "pZ" => "s",

  "sX" => "p",
  "sY" => "s",
  "sZ" => "r"
);

$scores = array(
  "r" => 1,
  "p" => 2,
  "s" => 3
);

$outcomes = array(
  "rr" => 3,
  "pp" => 3,
  "ss" => 3,

  "rp" => 6,
  "rs" => 0,

  "pr" => 0,
  "ps" => 6,

  "sr" => 6,
  "sp" => 0
);

$file = fopen("data", "r");

$totalScore = 0;
while(!feof($file)) {
  $line = fgets($file);

  if (trim($line) != "") {
    $opponent = $codes[$line[0]];
    $hand = $handStrategy[$opponent . $line[2]];
    $totalScore += ($outcomes[$opponent . $hand] + $scores[$hand]);
  }
}

fclose($file);

echo $totalScore;
