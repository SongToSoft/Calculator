# Calculator
Console calculator based on lexical expression parsing.

Calculator supports operations:
1. binary: +, -, *, /, (, ), ^(degree must be in brackets)
2. unary: +, -

# Run
Go to directory and write smt like:
```
ruby Calculator.rb "(38+2*14-(21 / 7 +(23 - 1))*4 + (((11 * 14*100 - 1 - (3) * 11))))^2"
235070224
```
Use -i for show all operation:
```
ruby Calculator.rb "(3*(11)^(2)-3)" -i
(3*(11)^(2)-3)
["(", "3", "*", "(", "11", ")", "^", "(", "2", ")", "-", "3", ")"]
Brackets values: 3*(11)^(2)-3
3*(11)^(2)-3
["3", "*", "(", "11", ")", "^", "(", "2", ")", "-", "3"]
Brackets values: 11
11
["11"]
Brackets values: 2
2
["2"]
11 ^ 2 = 121.0
["3", "*", 121.0, "-", "3"]
3 * 121.0 = 363.0
[363.0, "-", "3"]
363.0 - 3 = 360.0
360.0
```
Calculator works with floating point numbers:
```
ruby Calculator.rb "-4.123*(-1)/(-10*(-2.1)^(-2))"
-1.818243
```
