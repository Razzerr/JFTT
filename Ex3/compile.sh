#!/bin/bash

`bison -o infix_calc.tab.cpp infix_calc.y`
`g++ -lm -o infix_calc infix_calc.tab.cpp -lfl`