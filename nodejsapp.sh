#!/bin/bash

read -p "Please enter logs directory name: " log_directory

echo "Checking user..."
user_exists=$(grep -c myapp /etc/passwd)
if [[ $user_exists -eq 0 ]]; then
   echo "User myapp doesn't exist. Creating user..."
   sudo useradd -c myapp -m myapp
else
   echo "User myapp exists."
fi

echo "Checking logs directory..."
[[ -d /home/myapp/$log_directory ]] && echo "Directory /home/myapp/$log_directory exists." ||
echo "Directory does not exist. Creating...$(sudo mkdir /home/myapp/$log_directory)"

echo "Changing directory persmissions..."
sudo chown myapp:myapp /home/myapp/$log_directory
sudo chmod 755 /home/myapp/$log_directory

echo "Changing the directory..."
cd /home/myapp

echo "Fetcing the list of available updates..."
sudo apt -y update

echo "Installing Node.js..."
sudo apt -y install nodejs

echo "Installing npm..."
sudo apt -y install npm

echo "Checkin installed versions of Node,js and npm..."
echo "Node.js version $(nodejs --version) is installed"
echo "npm version $(npm -version) is installed"

echo "Downloading project..."
sudo -u myapp bash -c "wget https://"

echo "Unpacking..."
sudo -u myapp bash -c "tar -xzf .tgz"

echo "Changing the directory..."
cd package

echo "Setting up environment variables..."
sudo -u myapp bash -c "export APP_ENV=dev DB_USER=myuser DB_PWD=mysecret LOG_DIR=/home/myapp/$log_directory; npm install; node server.js &"

sleep 2

echo "Checking Node.js status..."
node_status=$(pgrep -f server.js)
if [[ "$node_status" != "" ]]; then 
   node_port=$(sudo netstat -tulpan 2>/dev/null | grep node | awk -F':::' '{print $2}')
   echo "Node.js PID "${node_status}" is running and listening on port "${node_port}""
else
   echo "Node.js is not running"
fi
