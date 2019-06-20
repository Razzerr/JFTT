#!/bin/bash

`flex -o Zad1.yy.cpp Zad1.l`
`g++ -o Zad1 Zad1.yy.cpp -lfl`