# Calculator
Console calculator based on lexical expression parsing.

# Run
Go to directory and write smt like:
```
ruby Calculator.rb "(38+2*14-(21 / 7 +(23 - 1))*4 + (((11 * 14*100 - 1 - (3) * 11))))^2"
235070224
```
-i - used for show all operation
```
ruby Calculator.rb "(3*(11)^2 - 3)" -i
(3*(11)^2-3)
["(", "3", "*", "(", "11", ")", "^", "2", "-", "3", ")"]
Brackets values: 3*(11)^2-3
3*(11)^2-3
["3", "*", "(", "11", ")", "^", "2", "-", "3"]
Brackets values: 11
11
["11"]
11 ^ 2 = 121
["3", "*", 121, "-", "3"]
3 * 121 = 363
[363, "-", "3"]
[360]
360
```
