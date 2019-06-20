#!/bin/bash

`flex -o Zad2.yy.cpp Zad2.l`
`g++ -o Zad2 Zad2.yy.cpp -lfl`