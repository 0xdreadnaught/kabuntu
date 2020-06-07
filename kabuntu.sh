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
git clone "https://github.com/magnumripper/JohnTheRipper.git" /opt/john
apt-get install -y libssl-dev
savedir=$(pwd)
cd /opt/john/src
./configure
make -s clean
make -sj4
cd "$savedir"
echo "alias john='/opt/john/run/john'" >> ~/.bashrc
source ~/.bashrc
ln -s /opt/john/run/7z2john.pl /usr/local/bin/7z2john
cp /opt/john/run/zip2john.pl /usr/local/bin/zip2john
cp /opt/john/run/rar2john /usr/local/bin/rar2john
cp /opt/john/run/unshadow /usr/local/bin/unshadow

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

#Install SamDump2
apt-get install -y samdump2

#Install Gobuster
apt-get install -y gobuster

#Install Dirb
apt-get install -y dirb

#Install WFuzz
apt-get install -y wfuzz

#Install Beef Framework
git clone https://github.com/beefproject/beef /opt/beef
gem install eventmachine
gem install thin
gem install sinatra
gem install em-websocket
gem install uglifier
gem install ansi
gem install term-ansicolor
gem install espeak-ruby
gem install otr-activerecord
gem install sqlite3
gem install maxmind-db
gem install parseconfig
sed -i 's/  get_permission/ #get_permission/g' /opt/beef/install
sed -i 's/apt-get /apt-get -y /g' /opt/beef/install
/opt/beef/install
ln -s /opt/beef/beef /usr/local/bin/beef-xss
sed -i 's/passwd: "beef"/passwd: "kabuntu"/g' /opt/beef/config.yaml

#Install Nikto
apt-get install -y nikto

#Install ExifTool
apt-get install -y exiftool

#Install Steghide
apt-get install -y steghide

#Install Stegsolve
mkdir /opt/stegsolve
wget https://www.wechall.net/de/download/12/Stegsolve_jar -O /opt/stegsolve/stegsolve.jar
ln -s /opt/stegsolve/stegsolve.jar /usr/local/bin/stegsolve
chmod +x /opt/stegsolve/stegsolve.jar
chmod +x /usr/local/bin/stegsolve
updatedb

#Install Binwalk
apt-get install binwalk
