#!/bin/bash

#Script for testing calculator

function StartTest 
{
    # $1 - id, $2 - expression, $3 - result 
    ruby Calculator.rb "$2" > testfile
    if grep -q $3 "testfile";
    then
        echo $1 "PASS"
    else
        echo $1 "FAIL"
    fi
    rm -rf testfile
}

StartTest 1 "1+2" "3"
StartTest 2 "1+2*4" "9"
StartTest 3 "(1+2)*4" "12"
StartTest 4 "(((11- 3) / 4))^(-2)" "0.25"
StartTest 5 "3  * (((11- 3) / 4))^(-2)" "0.75"
StartTest 6 "3.2*(((11.1313- 3.31241) / 4.2))^(-2)" "0.92333298925"
StartTest 7 "((13.5 - 1.5) * (11 + 4- (3*2)))^4" "136048896"
StartTest 8 "(38+2*14-(21 / 7 +(23 - 1))*(4) + (((11 * 14*100 - 1 - (3) * 11-3))))^(2)" "234978241.0"
StartTest 9 "4.123*(-1)/(-10*(-2.1)^(-2))" "1.818243"
StartTest 10 "4325512 ----- 12321 ++++++++9" "4313200"