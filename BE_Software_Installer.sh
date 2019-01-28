#!/bin/bash
###########################################################
# BedRock Server Software
# Copyright TheWalker0 2018
#
# https://github.com/TheWalker0/BedRock_Server_Installer
###########################################################

if [[ $EUID -ne 0 ]]; then
  echo "* This script must be executed with root privileges (sudo)." 1>&2
  exit 1
fi

function detect_distro {
  echo "$(python -c 'import platform ; print platform.dist()[0]')" | awk '{print tolower($0)}'
}

function detect_os_version {
  echo "$(python -c 'import platform ; print platform.dist()[1].split(".")[0]')"
}

function check_os {
  if [ "$OS" == "ubuntu" ]; then
    if [ "$OS_VERSION" == "16" ]; then
      SUPPORTED=true
    elif [ "$OS_VERSION" == "18" ]; then
      SUPPORTED=true
    else
      SUPPORTED=false
    fi
  elif [ "$OS" == "debian" ]; then
    if [ "$OS_VERSION" == "8" ]; then
      SUPPORTED=true
    elif [ "$OS_VERSION" == "9" ]; then
      SUPPORTED=true
    else
      SUPPORTED=false
    fi
  elif [ "$OS" == "centos" ]; then
    if [ "$OS_VERSION" == "7" ]; then
      SUPPORTED=false
    else
      SUPPORTED=false
    fi
  else
    SUPPORTED=true
  fi
  if [ "$SUPPORTED" == true ]; then
    echo "* $OS $OS_VERSION is supported."
  else
    echo "* $OS $OS_VERSION is not supported"
    print_error "Unsupported OS"
    exit 1
  fi
}

function print_brake {
  for ((n=0;n<$1;n++));
    do
      echo -n "#"
    done
    echo ""
}

function mode2 {
  print_brake 40
  echo "* Write in which Directory you want to install your server."
  echo "* Example: /home/hello/Desktop/BedRockServer/ or /root/BedRockServer/"
  print_brake 40
  echo -n "* Write Directory: "
  read DIR
  apt-get update && apt-get upgrade -y && mkdir "$DIR" && cd "$DIR" && wget https://minecraft.azureedge.net/bin-linux/bedrock-server-1.8.1.2.zip && unzip bedrock-server-1.8.1.2.zip && rm -r bedrock-server-1.8.1.2.zip && git clone https://github.com/TheWalker0/startbs && chmod +x start.sh && apt-get install curl libcurl4 && screen -d -m -S Vanilla ./start.sh
}

function main {
  print_brake 40
  echo "* BE Software installation script "
  echo "* Detecting operating system."
  OS=$(detect_distro);
  OS_VERSION=$(detect_os_version)
  echo "* Running $OS version $OS_VERSION."
  print_brake 40

  check_os

  echo "* [1] - Automatic Directory"
  echo -e "* [2] - Custom Directory"

  echo ""

  echo -n "* Select mode to install be server Software: "
  read MODE

  if [ "$MODE" == "1" ]; then
  	#apt-get update && apt-get upgrade -y && 
  	#apt install screen -y            dopo zip
    apt-get update && apt-get upgrade -y && mkdir BedRock_Server_Software && cd BedRock_Server_Software && wget https://minecraft.azureedge.net/bin-linux/bedrock-server-1.8.1.2.zip && unzip bedrock-server-1.8.1.2.zip && rm -r bedrock-server-1.8.1.2.zip && apt install screen -y  && git clone https://github.com/TheWalker0/startbs && chmod +x start.sh && apt-get install curl libcurl4 && screen -d -m -S ./start.sh
  elif [ "$MODE" == "2" ]; then
  	mode2
  else
    # exit
    print_error "Invalid option."
    main
  fi
}

function goodbye {
  print_brake 62
  echo "* BedRock Server Software successfully installed"
  echo ""
  echo "* Installation on $OS"
  print_brake 62

  exit 0
}

# start main function
main
goodbye