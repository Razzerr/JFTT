#!/bin/bash

`flex -o Zad4.yy.cpp Zad4.l`
`g++ -o Zad4 Zad4.yy.cpp -lfl`