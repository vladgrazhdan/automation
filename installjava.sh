#!/bin/bash

read -p "Are you sure you want to install Java? (y/n) " choice
if [ $choice = "y" ]; then
   echo "Checking installed Java version..."
   version=$(java -version 2>&1 | awk -F'"' '{print $2}')
   if [ $version = "11.0.11" ]; then	   
      echo "Java version $version is already installed"
   else 
      echo "Installing Java..."
      sudo apt install default-jre
      version=$(java -version 2>&1 | awk -F'"' '{print $2}')
      if [ $version = "11.0.11" ]; then
         echo "Java $version has been successfully installed"
      else "Java installation failed"
      fi
   fi
else
   echo "OK. Bye."
fi

