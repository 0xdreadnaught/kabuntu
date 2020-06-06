#Install Kali type packages on Unbuntu 20.04
#Some apt-get install commands are redundant.
#This is so parts of the script can be disabled if desired.
#
#I'll update this script as I add/change things locally

#!/bin/bash

#Check if root or sudo
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

#Update system
apt-get update -y
apt-get upgrade -y
apt-get update -y
apt-get dist-upgrade -y

#Install general requirements
apt-get install -y unzip vim-gtk3 curl

#Install some nice to have utils
apt-get install mlocate
updatedb

#Install Ruby/Bundler
apt-get install -y ruby ruby-dev
gem install bundler

#Install Python3
apt-get install software-properties-common
apt-get install -y python3
apt-get install -y python3-pip
pip3 install --upgrade pip

#Install Metasploit
curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall 
chmod 755 msfinstall
./msfinstall
rm -f ./msfinstall
gem install rex-text
ln -s /opt/metasploit-framework/embedded/framework/tools/exploit/pattern_create.rb /usr/local/bin/pattern_create
ln -s /opt/metasploit-framework/embedded/framework/tools/exploit/pattern_offset.rb /usr/local/bin/pattern_offset

#Install Searchsploit
git clone https://github.com/offensive-security/exploitdb.git /opt/exploitdb
sed 's|path_array+=(.*)|path_array+=("/opt/exploitdb")|g' /opt/exploitdb/.searchsploit_rc > ~/.searchsploit_rc
ln -sf /opt/exploitdb/searchsploit /usr/local/bin/searchsploit

#Install Impacket
git clone https://github.com/SecureAuthCorp/impacket /opt/impacket
pip3 install /opt/impacket/

#Install Seclists
git clone https://github.com/danielmiessler/SecLists.git /opt/SecLists

#Install binaries
git clone https://github.com/offensive-security/exploitdb-bin-sploits /opt/bin-sploits

#Install wordlists
apt-get install -y gunzip
git clone https://github.com/3ndG4me/KaliLists /usr/share/wordlists
gunzip -c /usr/share/wordlists/rockyou.txt.gz > /usr/share/wordlists/rockyou.txt

#Install Nmap
apt-get install -y nmap

#Install SMBClient
apt-get install -y smbclient

#Install Evil WinRM
gem install evil-winrm

#Install Burp
echo "Download Burp Suite Community from here: https://portswigger.net/burp/communitydownload"
echo "Select Linux x64"
echo "Copy install script to /opt"
echo "Press enter to install Burp Suite"
updatedb
bspath=$(locate burpsuite_community_linux)
chmod +x $("$bspath")
$("$bspath")
mv /usr/local/bin/BurpSuiteCommunity /usr/local/bin/burpsuite
updatedb

#Install John the Ripper
apt-get install -y john

#Install Cewl
apt-get install -y cewl

#Install Crunch
apt-get install -y crunch

#Install Hydra
apt-get install -y hydra

#Install Hashcat
apt-get install -y hashcat

#Install CherryTree
cherrylatest=$(curl https://www.giuspen.com/cherrytree/\#dev | grep "\.deb" | grep "software" | awk '{print $NF}' | sed 's/</ /g' | sed 's/>/ /g' | awk '{print $2}' | tail -n 1)
wget https://giuspen.com/software/"$cherrylatest" -O /opt/"$cherrylatest"
dpkg -i /opt/"$cherrylatest"
apt --fix-broken install -y
dpkg -i /opt/"$cherrytree"
apt-get install -f

#Install SQLMap
apt-get install -y sqlmap
