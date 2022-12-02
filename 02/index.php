<?php

$codes = array(
  "A" => "r",
  "X" => "r",

  "B" => "p",
  "Y" => "p",

  "C" => "s",
  "Z" => "s"
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
    $hand = $codes[$line[2]];
    $totalScore += ($outcomes[$opponent . $hand] + $scores[$hand]);
  }
}

fclose($file);

echo $totalScore;
