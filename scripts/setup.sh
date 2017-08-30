#!/bin/bash

server_dir="$HOME/csgo_surf/csgo"
cd_dir="eval cd "$HOME/github/CSGO-SURF/csgo/""

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "${RED}Removing Existing Addons Directory if Applicable. If You Don't Have an installed Server to cso_surf Then This Will Do Nothing and is Safe. Script will continue in 10 Secs...${NC}" && sleep 10
rm -rf $server_dir/addons/

# make addons folder
test -e $server_dir/addons || mkdir $server_dir/addons

# metamod
echo -e "${GREEN}Installing Metamod...${NC}" && sleep 2
for dest in $server_dir/
do
cp -rf $HOME/github/CSGO-SURF/csgo/addons $dest
done 

# sourcemod
echo -e "${GREEN}Downloading & Installing Sourcemod...${NC}" && sleep 2
url=$(curl -s https://sm.alliedmods.net/smdrop/1.8/sourcemod-latest-linux)
wget "https://sm.alliedmods.net/smdrop/1.8/$url"
tar -xvzf "${url##*/}" -C $server_dir

echo -e "${GREEN}Copying over PreConfiguGREEN Sourcemod Files...${NC}" && sleep 2
mkdir $server_dir/addons/sourcemod
cp -rf $HOME/github/CSGO-SURF/csgo/addons/sourcemod $server_dir/addons/sourcemod

# metamod vdf file
for dest in $server_dir/addons/
do
cp -rf $HOME/github/CSGO-SURF/csgo/addons/metamod.vdf $dest
done

echo -e "${GREEN}Copying Over Pre-ConfiguGREEN Config Files...${NC}" && sleep 2
# cfg files 
for dest in $server_dir/cfg/
do
cp -rf $HOME/github/CSGO-SURF/csgo/cfg/sourcemod $dest
cp -rf $HOME/github/CSGO-SURF/csgo/cfg/* $dest
done

# map files
echo -e "${GREEN}Installing Map Files...${NC}" && sleep 2	
for dest in $server_dir/
do
find $server_dir/maps -maxdepth 1 -type f -delete
cp -f $HOME/github/CSGO-SURF/csgo/* $dest
done

#Extract maps.tar.bz2
tar -xvjf $HOME/csgo_surf/csgo/maps.tar.bz2 -C $HOME/csgo_surf/csgo && rm -f && rm '$server_dir/maps.tar.bz2' -f

# extract individual maps and nav files
echo -e "${RED}Still Installing Map Files Please Be Patient...${NC}" && sleep 5
for i in $server_dir/maps/*.bsp.bz2; do 
    bzip2 -d "$i"
done

for i in $server_dir/maps/*.nav.bz2; do 
    bzip2 -d "$i"
done

# Copy start script and start server
echo -e "${GREEN}Copying Over Start Script and Starting Server...${NC}" && sleep 5
for dest in $HOME/csgo_surf
do
cp -rf $HOME/github/CSGO-SURF/scripts/start.sh $dest && cd $dest && sh start.sh
done
