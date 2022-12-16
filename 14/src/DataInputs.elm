module DataInputs exposing (..)

testdata : String
testdata = """498,4 -> 498,6 -> 496,6
503,4 -> 502,4 -> 502,9 -> 494,9"""

data : String
data = """
515,60 -> 515,52 -> 515,60 -> 517,60 -> 517,55 -> 517,60 -> 519,60 -> 519,50 -> 519,60 -> 521,60 -> 521,56 -> 521,60 -> 523,60 -> 523,53 -> 523,60 -> 525,60 -> 525,53 -> 525,60
515,60 -> 515,52 -> 515,60 -> 517,60 -> 517,55 -> 517,60 -> 519,60 -> 519,50 -> 519,60 -> 521,60 -> 521,56 -> 521,60 -> 523,60 -> 523,53 -> 523,60 -> 525,60 -> 525,53 -> 525,60
502,32 -> 507,32
522,47 -> 522,43 -> 522,47 -> 524,47 -> 524,41 -> 524,47 -> 526,47 -> 526,39 -> 526,47 -> 528,47 -> 528,39 -> 528,47
516,32 -> 521,32
501,161 -> 501,152 -> 501,161 -> 503,161 -> 503,157 -> 503,161 -> 505,161 -> 505,155 -> 505,161 -> 507,161 -> 507,154 -> 507,161 -> 509,161 -> 509,155 -> 509,161
512,30 -> 517,30
522,47 -> 522,43 -> 522,47 -> 524,47 -> 524,41 -> 524,47 -> 526,47 -> 526,39 -> 526,47 -> 528,47 -> 528,39 -> 528,47
522,84 -> 522,76 -> 522,84 -> 524,84 -> 524,75 -> 524,84 -> 526,84 -> 526,81 -> 526,84 -> 528,84 -> 528,74 -> 528,84 -> 530,84 -> 530,79 -> 530,84 -> 532,84 -> 532,77 -> 532,84 -> 534,84 -> 534,78 -> 534,84 -> 536,84 -> 536,80 -> 536,84
522,84 -> 522,76 -> 522,84 -> 524,84 -> 524,75 -> 524,84 -> 526,84 -> 526,81 -> 526,84 -> 528,84 -> 528,74 -> 528,84 -> 530,84 -> 530,79 -> 530,84 -> 532,84 -> 532,77 -> 532,84 -> 534,84 -> 534,78 -> 534,84 -> 536,84 -> 536,80 -> 536,84
520,130 -> 520,133 -> 515,133 -> 515,138 -> 533,138 -> 533,133 -> 525,133 -> 525,130
506,34 -> 511,34
529,112 -> 529,116 -> 526,116 -> 526,122 -> 541,122 -> 541,116 -> 535,116 -> 535,112
498,13 -> 498,15 -> 492,15 -> 492,23 -> 506,23 -> 506,15 -> 501,15 -> 501,13
522,84 -> 522,76 -> 522,84 -> 524,84 -> 524,75 -> 524,84 -> 526,84 -> 526,81 -> 526,84 -> 528,84 -> 528,74 -> 528,84 -> 530,84 -> 530,79 -> 530,84 -> 532,84 -> 532,77 -> 532,84 -> 534,84 -> 534,78 -> 534,84 -> 536,84 -> 536,80 -> 536,84
523,63 -> 523,66 -> 515,66 -> 515,71 -> 529,71 -> 529,66 -> 528,66 -> 528,63
501,161 -> 501,152 -> 501,161 -> 503,161 -> 503,157 -> 503,161 -> 505,161 -> 505,155 -> 505,161 -> 507,161 -> 507,154 -> 507,161 -> 509,161 -> 509,155 -> 509,161
512,173 -> 517,173
522,84 -> 522,76 -> 522,84 -> 524,84 -> 524,75 -> 524,84 -> 526,84 -> 526,81 -> 526,84 -> 528,84 -> 528,74 -> 528,84 -> 530,84 -> 530,79 -> 530,84 -> 532,84 -> 532,77 -> 532,84 -> 534,84 -> 534,78 -> 534,84 -> 536,84 -> 536,80 -> 536,84
498,13 -> 498,15 -> 492,15 -> 492,23 -> 506,23 -> 506,15 -> 501,15 -> 501,13
545,94 -> 550,94
539,100 -> 544,100
522,47 -> 522,43 -> 522,47 -> 524,47 -> 524,41 -> 524,47 -> 526,47 -> 526,39 -> 526,47 -> 528,47 -> 528,39 -> 528,47
529,112 -> 529,116 -> 526,116 -> 526,122 -> 541,122 -> 541,116 -> 535,116 -> 535,112
553,100 -> 558,100
501,170 -> 506,170
515,60 -> 515,52 -> 515,60 -> 517,60 -> 517,55 -> 517,60 -> 519,60 -> 519,50 -> 519,60 -> 521,60 -> 521,56 -> 521,60 -> 523,60 -> 523,53 -> 523,60 -> 525,60 -> 525,53 -> 525,60
498,13 -> 498,15 -> 492,15 -> 492,23 -> 506,23 -> 506,15 -> 501,15 -> 501,13
522,84 -> 522,76 -> 522,84 -> 524,84 -> 524,75 -> 524,84 -> 526,84 -> 526,81 -> 526,84 -> 528,84 -> 528,74 -> 528,84 -> 530,84 -> 530,79 -> 530,84 -> 532,84 -> 532,77 -> 532,84 -> 534,84 -> 534,78 -> 534,84 -> 536,84 -> 536,80 -> 536,84
515,60 -> 515,52 -> 515,60 -> 517,60 -> 517,55 -> 517,60 -> 519,60 -> 519,50 -> 519,60 -> 521,60 -> 521,56 -> 521,60 -> 523,60 -> 523,53 -> 523,60 -> 525,60 -> 525,53 -> 525,60
498,13 -> 498,15 -> 492,15 -> 492,23 -> 506,23 -> 506,15 -> 501,15 -> 501,13
522,84 -> 522,76 -> 522,84 -> 524,84 -> 524,75 -> 524,84 -> 526,84 -> 526,81 -> 526,84 -> 528,84 -> 528,74 -> 528,84 -> 530,84 -> 530,79 -> 530,84 -> 532,84 -> 532,77 -> 532,84 -> 534,84 -> 534,78 -> 534,84 -> 536,84 -> 536,80 -> 536,84
522,84 -> 522,76 -> 522,84 -> 524,84 -> 524,75 -> 524,84 -> 526,84 -> 526,81 -> 526,84 -> 528,84 -> 528,74 -> 528,84 -> 530,84 -> 530,79 -> 530,84 -> 532,84 -> 532,77 -> 532,84 -> 534,84 -> 534,78 -> 534,84 -> 536,84 -> 536,80 -> 536,84
522,84 -> 522,76 -> 522,84 -> 524,84 -> 524,75 -> 524,84 -> 526,84 -> 526,81 -> 526,84 -> 528,84 -> 528,74 -> 528,84 -> 530,84 -> 530,79 -> 530,84 -> 532,84 -> 532,77 -> 532,84 -> 534,84 -> 534,78 -> 534,84 -> 536,84 -> 536,80 -> 536,84
546,100 -> 551,100
522,84 -> 522,76 -> 522,84 -> 524,84 -> 524,75 -> 524,84 -> 526,84 -> 526,81 -> 526,84 -> 528,84 -> 528,74 -> 528,84 -> 530,84 -> 530,79 -> 530,84 -> 532,84 -> 532,77 -> 532,84 -> 534,84 -> 534,78 -> 534,84 -> 536,84 -> 536,80 -> 536,84
542,97 -> 547,97
522,84 -> 522,76 -> 522,84 -> 524,84 -> 524,75 -> 524,84 -> 526,84 -> 526,81 -> 526,84 -> 528,84 -> 528,74 -> 528,84 -> 530,84 -> 530,79 -> 530,84 -> 532,84 -> 532,77 -> 532,84 -> 534,84 -> 534,78 -> 534,84 -> 536,84 -> 536,80 -> 536,84
535,97 -> 540,97
533,108 -> 533,109 -> 538,109 -> 538,108
522,47 -> 522,43 -> 522,47 -> 524,47 -> 524,41 -> 524,47 -> 526,47 -> 526,39 -> 526,47 -> 528,47 -> 528,39 -> 528,47
509,32 -> 514,32
513,34 -> 518,34
515,60 -> 515,52 -> 515,60 -> 517,60 -> 517,55 -> 517,60 -> 519,60 -> 519,50 -> 519,60 -> 521,60 -> 521,56 -> 521,60 -> 523,60 -> 523,53 -> 523,60 -> 525,60 -> 525,53 -> 525,60
520,130 -> 520,133 -> 515,133 -> 515,138 -> 533,138 -> 533,133 -> 525,133 -> 525,130
507,164 -> 512,164
501,161 -> 501,152 -> 501,161 -> 503,161 -> 503,157 -> 503,161 -> 505,161 -> 505,155 -> 505,161 -> 507,161 -> 507,154 -> 507,161 -> 509,161 -> 509,155 -> 509,161
501,161 -> 501,152 -> 501,161 -> 503,161 -> 503,157 -> 503,161 -> 505,161 -> 505,155 -> 505,161 -> 507,161 -> 507,154 -> 507,161 -> 509,161 -> 509,155 -> 509,161
557,103 -> 562,103
538,94 -> 543,94
515,60 -> 515,52 -> 515,60 -> 517,60 -> 517,55 -> 517,60 -> 519,60 -> 519,50 -> 519,60 -> 521,60 -> 521,56 -> 521,60 -> 523,60 -> 523,53 -> 523,60 -> 525,60 -> 525,53 -> 525,60
522,84 -> 522,76 -> 522,84 -> 524,84 -> 524,75 -> 524,84 -> 526,84 -> 526,81 -> 526,84 -> 528,84 -> 528,74 -> 528,84 -> 530,84 -> 530,79 -> 530,84 -> 532,84 -> 532,77 -> 532,84 -> 534,84 -> 534,78 -> 534,84 -> 536,84 -> 536,80 -> 536,84
520,130 -> 520,133 -> 515,133 -> 515,138 -> 533,138 -> 533,133 -> 525,133 -> 525,130
520,130 -> 520,133 -> 515,133 -> 515,138 -> 533,138 -> 533,133 -> 525,133 -> 525,130
498,13 -> 498,15 -> 492,15 -> 492,23 -> 506,23 -> 506,15 -> 501,15 -> 501,13
522,84 -> 522,76 -> 522,84 -> 524,84 -> 524,75 -> 524,84 -> 526,84 -> 526,81 -> 526,84 -> 528,84 -> 528,74 -> 528,84 -> 530,84 -> 530,79 -> 530,84 -> 532,84 -> 532,77 -> 532,84 -> 534,84 -> 534,78 -> 534,84 -> 536,84 -> 536,80 -> 536,84
523,63 -> 523,66 -> 515,66 -> 515,71 -> 529,71 -> 529,66 -> 528,66 -> 528,63
501,28 -> 506,28
505,173 -> 510,173
531,87 -> 531,88 -> 543,88
515,60 -> 515,52 -> 515,60 -> 517,60 -> 517,55 -> 517,60 -> 519,60 -> 519,50 -> 519,60 -> 521,60 -> 521,56 -> 521,60 -> 523,60 -> 523,53 -> 523,60 -> 525,60 -> 525,53 -> 525,60
522,84 -> 522,76 -> 522,84 -> 524,84 -> 524,75 -> 524,84 -> 526,84 -> 526,81 -> 526,84 -> 528,84 -> 528,74 -> 528,84 -> 530,84 -> 530,79 -> 530,84 -> 532,84 -> 532,77 -> 532,84 -> 534,84 -> 534,78 -> 534,84 -> 536,84 -> 536,80 -> 536,84
520,130 -> 520,133 -> 515,133 -> 515,138 -> 533,138 -> 533,133 -> 525,133 -> 525,130
522,84 -> 522,76 -> 522,84 -> 524,84 -> 524,75 -> 524,84 -> 526,84 -> 526,81 -> 526,84 -> 528,84 -> 528,74 -> 528,84 -> 530,84 -> 530,79 -> 530,84 -> 532,84 -> 532,77 -> 532,84 -> 534,84 -> 534,78 -> 534,84 -> 536,84 -> 536,80 -> 536,84
522,84 -> 522,76 -> 522,84 -> 524,84 -> 524,75 -> 524,84 -> 526,84 -> 526,81 -> 526,84 -> 528,84 -> 528,74 -> 528,84 -> 530,84 -> 530,79 -> 530,84 -> 532,84 -> 532,77 -> 532,84 -> 534,84 -> 534,78 -> 534,84 -> 536,84 -> 536,80 -> 536,84
524,126 -> 524,127 -> 528,127 -> 528,126
515,60 -> 515,52 -> 515,60 -> 517,60 -> 517,55 -> 517,60 -> 519,60 -> 519,50 -> 519,60 -> 521,60 -> 521,56 -> 521,60 -> 523,60 -> 523,53 -> 523,60 -> 525,60 -> 525,53 -> 525,60
522,84 -> 522,76 -> 522,84 -> 524,84 -> 524,75 -> 524,84 -> 526,84 -> 526,81 -> 526,84 -> 528,84 -> 528,74 -> 528,84 -> 530,84 -> 530,79 -> 530,84 -> 532,84 -> 532,77 -> 532,84 -> 534,84 -> 534,78 -> 534,84 -> 536,84 -> 536,80 -> 536,84
501,161 -> 501,152 -> 501,161 -> 503,161 -> 503,157 -> 503,161 -> 505,161 -> 505,155 -> 505,161 -> 507,161 -> 507,154 -> 507,161 -> 509,161 -> 509,155 -> 509,161
523,63 -> 523,66 -> 515,66 -> 515,71 -> 529,71 -> 529,66 -> 528,66 -> 528,63
508,28 -> 513,28
501,161 -> 501,152 -> 501,161 -> 503,161 -> 503,157 -> 503,161 -> 505,161 -> 505,155 -> 505,161 -> 507,161 -> 507,154 -> 507,161 -> 509,161 -> 509,155 -> 509,161
523,63 -> 523,66 -> 515,66 -> 515,71 -> 529,71 -> 529,66 -> 528,66 -> 528,63
511,167 -> 516,167
549,97 -> 554,97
541,91 -> 546,91
522,47 -> 522,43 -> 522,47 -> 524,47 -> 524,41 -> 524,47 -> 526,47 -> 526,39 -> 526,47 -> 528,47 -> 528,39 -> 528,47
522,47 -> 522,43 -> 522,47 -> 524,47 -> 524,41 -> 524,47 -> 526,47 -> 526,39 -> 526,47 -> 528,47 -> 528,39 -> 528,47
520,34 -> 525,34
522,47 -> 522,43 -> 522,47 -> 524,47 -> 524,41 -> 524,47 -> 526,47 -> 526,39 -> 526,47 -> 528,47 -> 528,39 -> 528,47
515,60 -> 515,52 -> 515,60 -> 517,60 -> 517,55 -> 517,60 -> 519,60 -> 519,50 -> 519,60 -> 521,60 -> 521,56 -> 521,60 -> 523,60 -> 523,53 -> 523,60 -> 525,60 -> 525,53 -> 525,60
501,161 -> 501,152 -> 501,161 -> 503,161 -> 503,157 -> 503,161 -> 505,161 -> 505,155 -> 505,161 -> 507,161 -> 507,154 -> 507,161 -> 509,161 -> 509,155 -> 509,161
522,47 -> 522,43 -> 522,47 -> 524,47 -> 524,41 -> 524,47 -> 526,47 -> 526,39 -> 526,47 -> 528,47 -> 528,39 -> 528,47
501,161 -> 501,152 -> 501,161 -> 503,161 -> 503,157 -> 503,161 -> 505,161 -> 505,155 -> 505,161 -> 507,161 -> 507,154 -> 507,161 -> 509,161 -> 509,155 -> 509,161
505,30 -> 510,30
543,103 -> 548,103
510,146 -> 515,146
522,84 -> 522,76 -> 522,84 -> 524,84 -> 524,75 -> 524,84 -> 526,84 -> 526,81 -> 526,84 -> 528,84 -> 528,74 -> 528,84 -> 530,84 -> 530,79 -> 530,84 -> 532,84 -> 532,77 -> 532,84 -> 534,84 -> 534,78 -> 534,84 -> 536,84 -> 536,80 -> 536,84
498,173 -> 503,173
498,13 -> 498,15 -> 492,15 -> 492,23 -> 506,23 -> 506,15 -> 501,15 -> 501,13
501,161 -> 501,152 -> 501,161 -> 503,161 -> 503,157 -> 503,161 -> 505,161 -> 505,155 -> 505,161 -> 507,161 -> 507,154 -> 507,161 -> 509,161 -> 509,155 -> 509,161
523,63 -> 523,66 -> 515,66 -> 515,71 -> 529,71 -> 529,66 -> 528,66 -> 528,63
515,60 -> 515,52 -> 515,60 -> 517,60 -> 517,55 -> 517,60 -> 519,60 -> 519,50 -> 519,60 -> 521,60 -> 521,56 -> 521,60 -> 523,60 -> 523,53 -> 523,60 -> 525,60 -> 525,53 -> 525,60
522,47 -> 522,43 -> 522,47 -> 524,47 -> 524,41 -> 524,47 -> 526,47 -> 526,39 -> 526,47 -> 528,47 -> 528,39 -> 528,47
498,13 -> 498,15 -> 492,15 -> 492,23 -> 506,23 -> 506,15 -> 501,15 -> 501,13
515,60 -> 515,52 -> 515,60 -> 517,60 -> 517,55 -> 517,60 -> 519,60 -> 519,50 -> 519,60 -> 521,60 -> 521,56 -> 521,60 -> 523,60 -> 523,53 -> 523,60 -> 525,60 -> 525,53 -> 525,60
533,108 -> 533,109 -> 538,109 -> 538,108
517,146 -> 522,146
515,60 -> 515,52 -> 515,60 -> 517,60 -> 517,55 -> 517,60 -> 519,60 -> 519,50 -> 519,60 -> 521,60 -> 521,56 -> 521,60 -> 523,60 -> 523,53 -> 523,60 -> 525,60 -> 525,53 -> 525,60
501,161 -> 501,152 -> 501,161 -> 503,161 -> 503,157 -> 503,161 -> 505,161 -> 505,155 -> 505,161 -> 507,161 -> 507,154 -> 507,161 -> 509,161 -> 509,155 -> 509,161
513,144 -> 518,144
515,170 -> 520,170
501,161 -> 501,152 -> 501,161 -> 503,161 -> 503,157 -> 503,161 -> 505,161 -> 505,155 -> 505,161 -> 507,161 -> 507,154 -> 507,161 -> 509,161 -> 509,155 -> 509,161
520,130 -> 520,133 -> 515,133 -> 515,138 -> 533,138 -> 533,133 -> 525,133 -> 525,130
515,60 -> 515,52 -> 515,60 -> 517,60 -> 517,55 -> 517,60 -> 519,60 -> 519,50 -> 519,60 -> 521,60 -> 521,56 -> 521,60 -> 523,60 -> 523,53 -> 523,60 -> 525,60 -> 525,53 -> 525,60
523,63 -> 523,66 -> 515,66 -> 515,71 -> 529,71 -> 529,66 -> 528,66 -> 528,63
522,84 -> 522,76 -> 522,84 -> 524,84 -> 524,75 -> 524,84 -> 526,84 -> 526,81 -> 526,84 -> 528,84 -> 528,74 -> 528,84 -> 530,84 -> 530,79 -> 530,84 -> 532,84 -> 532,77 -> 532,84 -> 534,84 -> 534,78 -> 534,84 -> 536,84 -> 536,80 -> 536,84
519,173 -> 524,173
532,100 -> 537,100
524,126 -> 524,127 -> 528,127 -> 528,126
522,84 -> 522,76 -> 522,84 -> 524,84 -> 524,75 -> 524,84 -> 526,84 -> 526,81 -> 526,84 -> 528,84 -> 528,74 -> 528,84 -> 530,84 -> 530,79 -> 530,84 -> 532,84 -> 532,77 -> 532,84 -> 534,84 -> 534,78 -> 534,84 -> 536,84 -> 536,80 -> 536,84
522,84 -> 522,76 -> 522,84 -> 524,84 -> 524,75 -> 524,84 -> 526,84 -> 526,81 -> 526,84 -> 528,84 -> 528,74 -> 528,84 -> 530,84 -> 530,79 -> 530,84 -> 532,84 -> 532,77 -> 532,84 -> 534,84 -> 534,78 -> 534,84 -> 536,84 -> 536,80 -> 536,84
529,112 -> 529,116 -> 526,116 -> 526,122 -> 541,122 -> 541,116 -> 535,116 -> 535,112
522,84 -> 522,76 -> 522,84 -> 524,84 -> 524,75 -> 524,84 -> 526,84 -> 526,81 -> 526,84 -> 528,84 -> 528,74 -> 528,84 -> 530,84 -> 530,79 -> 530,84 -> 532,84 -> 532,77 -> 532,84 -> 534,84 -> 534,78 -> 534,84 -> 536,84 -> 536,80 -> 536,84
521,148 -> 526,148
504,167 -> 509,167
522,84 -> 522,76 -> 522,84 -> 524,84 -> 524,75 -> 524,84 -> 526,84 -> 526,81 -> 526,84 -> 528,84 -> 528,74 -> 528,84 -> 530,84 -> 530,79 -> 530,84 -> 532,84 -> 532,77 -> 532,84 -> 534,84 -> 534,78 -> 534,84 -> 536,84 -> 536,80 -> 536,84
529,112 -> 529,116 -> 526,116 -> 526,122 -> 541,122 -> 541,116 -> 535,116 -> 535,112
520,130 -> 520,133 -> 515,133 -> 515,138 -> 533,138 -> 533,133 -> 525,133 -> 525,130
514,148 -> 519,148
510,141 -> 515,141
515,60 -> 515,52 -> 515,60 -> 517,60 -> 517,55 -> 517,60 -> 519,60 -> 519,50 -> 519,60 -> 521,60 -> 521,56 -> 521,60 -> 523,60 -> 523,53 -> 523,60 -> 525,60 -> 525,53 -> 525,60
515,60 -> 515,52 -> 515,60 -> 517,60 -> 517,55 -> 517,60 -> 519,60 -> 519,50 -> 519,60 -> 521,60 -> 521,56 -> 521,60 -> 523,60 -> 523,53 -> 523,60 -> 525,60 -> 525,53 -> 525,60
533,108 -> 533,109 -> 538,109 -> 538,108
524,126 -> 524,127 -> 528,127 -> 528,126
550,103 -> 555,103
515,60 -> 515,52 -> 515,60 -> 517,60 -> 517,55 -> 517,60 -> 519,60 -> 519,50 -> 519,60 -> 521,60 -> 521,56 -> 521,60 -> 523,60 -> 523,53 -> 523,60 -> 525,60 -> 525,53 -> 525,60
501,161 -> 501,152 -> 501,161 -> 503,161 -> 503,157 -> 503,161 -> 505,161 -> 505,155 -> 505,161 -> 507,161 -> 507,154 -> 507,161 -> 509,161 -> 509,155 -> 509,161
529,103 -> 534,103
504,26 -> 509,26
529,112 -> 529,116 -> 526,116 -> 526,122 -> 541,122 -> 541,116 -> 535,116 -> 535,112
508,170 -> 513,170
523,63 -> 523,66 -> 515,66 -> 515,71 -> 529,71 -> 529,66 -> 528,66 -> 528,63
499,34 -> 504,34
522,47 -> 522,43 -> 522,47 -> 524,47 -> 524,41 -> 524,47 -> 526,47 -> 526,39 -> 526,47 -> 528,47 -> 528,39 -> 528,47
529,112 -> 529,116 -> 526,116 -> 526,122 -> 541,122 -> 541,116 -> 535,116 -> 535,112
495,32 -> 500,32
507,148 -> 512,148
515,60 -> 515,52 -> 515,60 -> 517,60 -> 517,55 -> 517,60 -> 519,60 -> 519,50 -> 519,60 -> 521,60 -> 521,56 -> 521,60 -> 523,60 -> 523,53 -> 523,60 -> 525,60 -> 525,53 -> 525,60
501,161 -> 501,152 -> 501,161 -> 503,161 -> 503,157 -> 503,161 -> 505,161 -> 505,155 -> 505,161 -> 507,161 -> 507,154 -> 507,161 -> 509,161 -> 509,155 -> 509,161
531,87 -> 531,88 -> 543,88
536,103 -> 541,103
501,161 -> 501,152 -> 501,161 -> 503,161 -> 503,157 -> 503,161 -> 505,161 -> 505,155 -> 505,161 -> 507,161 -> 507,154 -> 507,161 -> 509,161 -> 509,155 -> 509,161
522,84 -> 522,76 -> 522,84 -> 524,84 -> 524,75 -> 524,84 -> 526,84 -> 526,81 -> 526,84 -> 528,84 -> 528,74 -> 528,84 -> 530,84 -> 530,79 -> 530,84 -> 532,84 -> 532,77 -> 532,84 -> 534,84 -> 534,78 -> 534,84 -> 536,84 -> 536,80 -> 536,84
522,47 -> 522,43 -> 522,47 -> 524,47 -> 524,41 -> 524,47 -> 526,47 -> 526,39 -> 526,47 -> 528,47 -> 528,39 -> 528,47
498,30 -> 503,30
492,34 -> 497,34
529,112 -> 529,116 -> 526,116 -> 526,122 -> 541,122 -> 541,116 -> 535,116 -> 535,112
"""
