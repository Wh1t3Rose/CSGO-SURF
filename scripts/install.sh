#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Set Install Dir
server_dir="$HOME/csgo_surf"

# download steamcmd
cd $HOME
echo -e "${RED}Deleting steamcmd & csgo_surf directories if they exist...${NC}" && sleep 2
rm -rf steamcmd
rm -rf csgo_surf
echo -e "${GREEN}Downloading & Installing SteamCmd...${NC}" && sleep 2
wget http://media.steampowered.com/installer/steamcmd_linux.tar.gz
mkdir steamcmd
tar -xvzf steamcmd_linux.tar.gz -C steamcmd
rm steamcmd_linux.tar.gz*
cd steamcmd

# download srcds for csgo (740)
./steamcmd.sh +login anonymous +force_install_dir $server_dir +app_update 740 validate +quit
./steamcmd.sh +login anonymous +force_install_dir $server_dir +app_update 740 validate +quit 

# copy directories to server
echo -e "${GREEN}Starting Setup Script...${NC}" && sleep 3
sh $HOME/github/CSGO-SURF/scripts/setup.sh

# add start script
cp -f script/start.$server_dir

# fixes some annoying spam
#sed -i 's/Rank/\/\/Rank/g' $server_dir/botprofile.db 

