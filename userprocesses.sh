#!/bin/bash

read -p "Would you like the output to be sorted by memory or CPU consumption? (n) no, (m) memory, (c) CPU, (q) quit: " option

while ! [[ "$option" =~ ^[nmcq]$ ]] 
do
   read -p "Would you like the output to be sorted by memory or CPU consumption? (n) no, (m) memory, (c) CPU, (q) quit: " option
done

if [[ "$option" == "q" ]]; then 
   echo "OK. Bye." 
   exit 0 
fi

read -p "How many processes to show? (a) all or enter a number: " processes

while ! [[ "$processes" =~ ^[1-9][1-9]*$ || "$processes" == "a" ]]
do
   read -p "How many processes to show? (a) all or enter a number: " processes
done   

user=$(printenv USER)

if [[ "$processes" == "a" ]]; then
   if [[ "$option" == "n" ]]; then
      echo "$(ps aux | (head -n 1; grep ^$user))"
   elif [[ "$option" == "m" ]]; then
      echo "$(ps aux --sort -pmem | (head -n 1; grep ^$user))"
   elif [[ "$option" == "c" ]]; then
      echo "$(ps aux --sort -pcpu | (head -n 1; grep ^$user))"
   fi
else
   if [[ "$option" == "n" ]]; then
      echo "$(ps aux | (head -n 1; grep ^$user) | head -n $((processes+1)))"
   elif [[ "$option" == "m" ]]; then
      echo "$(ps aux --sort -pmem | (head -n 1; grep ^$user) | head -n $((processes+1)))"
   elif [[ "$option" == "c" ]]; then
      echo "$(ps aux --sort -pcpu | (head -n 1; grep ^$user) | head -n $((processes+1)))"
   fi
fi
