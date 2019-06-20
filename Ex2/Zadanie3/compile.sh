#!/bin/bash

`flex -o Zad3.yy.cpp Zad3.l`
`g++ -o Zad3 Zad3.yy.cpp -lfl`