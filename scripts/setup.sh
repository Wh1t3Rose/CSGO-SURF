#!/bin/bash

server_dir="$HOME/csgo_test/csgo"
configs="$HOME/github/CSGO-SURF/csgo/addons/sourcemod/configs/"
cd_dir="eval cd "$HOME/github/CSGO-SURF/csgo/""

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "${RED}Removing Existing Addons Directory if Applicable. If You Don't Have an installed server to csgo_test, then this will Do nothing and is safe. Script will continue in 10 Secs...${NC}" && sleep 10
rm -rf $server_dir/addons

# make addons folder
test -e $server_dir/addons || mkdir $server_dir/addons

# metamod
echo -e "${GREEN}Installing Metamod...${NC}" && sleep 2
for dest in $server_dir/addons
do
cp -rf $HOME/github/CSGO-SURF/csgo/addons/metamod $dest
cp -rf $HOME/github/CSGO-SURF/csgo/addons/metamod.vdf $dest
done 

# sourcemod
echo -e "${GREEN}Downloading & Installing Sourcemod...${NC}" && sleep 2
url=$(curl -s https://sm.alliedmods.net/smdrop/1.8/sourcemod-latest-linux)
wget "https://sm.alliedmods.net/smdrop/1.8/$url"
tar -xvzf "${url##*/}" -C $server_dir

# Stripper Files
echo -e "${GREEN}Installing Stripper Files...${NC}" && sleep 2
for dest in $server_dir/addons/
do
cp -rf $HOME/github/CSGO-SURF/csgo/addons/stripper $dest
done

echo -e "${GREEN}Copying Over Pre-Configured SourceMod Config & Plugins...${NC}" && sleep 2
for dest in $server_dir/addons/
do
cp -rf $HOME/github/CSGO-SURF/csgo/addons/sourcemod $dest
done

echo -e "${GREEN}Copying Over Pre-Configured Config Files...${NC}" && sleep 2
# cfg files
rm -rf "$configs\database.cfg" "$configs\admins.cfg" "$configs\admin_groups.cfg"
for dest in $server_dir/cfg/
do
cp -rf $HOME/github/CSGO-SURF/csgo/cfg/sourcemod $dest
cp -rf $HOME/github/CSGO-SURF/csgo/cfg/* $dest
done

# map files
echo -e "${GREEN}Installing Map Files...${NC}" && sleep 2
wget "http://www.snthtk.darktech.org/forum/sharedfiles/maps.tar.bz2"
for dest in $server_dir/
do
find $server_dir/maps -maxdepth 1 -type f -delete
cp -f $HOME/github/CSGO-SURF/scripts/maps.tar.bz2 $dest
done

for dest in $server_dir
do
cp -rf $HOME/github/CSGO-SURF/csgo/maplist.txt $dest
cp -rf $HOME/github/CSGO-SURF/csgo/cfg/mapcycle.txt $dest
done

#Extract maps.tar.bz2
tar -xvjf $server_dir/maps.tar.bz2 -C $HOME/csgo_test/csgo && rm -f && rm '$server_dir/maps.tar.bz2' -f

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
for dest in $HOME/csgo_test
do
cp -rf $HOME/github/CSGO-SURF/scripts/start.sh $dest && cd $dest && sh start.sh
done
