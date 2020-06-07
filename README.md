# kabuntu
Deploy Kali type tools on Ubuntu 20.x

This is a work in progress. I will continue to update the script as I add more to the system.

The script could be much more efficient, but I've broken apart the packages so people can easily exclude things they don't want.

# Usage
Run the script as root, or with sudo.

chmod +x ./kabuntu.sh

./kabuntu

# Notes
- Beef password changed to "kabuntu". It won't run with the default in /opt/beef/config.yaml.
- Beef command symlinked to beef-xss to prevent conflict with a different beef package.

# Current Packages
Ruby/Bundler

Python3

Metasploit

Searchsploit

Impacket

Seclists

Offsec Binaries

wordlists

Nmap

SMBClient

Evil WinRM

Burp

John the Ripper

Cewl

Crunch

Hydra

Hashcat

CherryTree

SQLMap

SamDump2

Gobuster

Dirb

WFuzz

Beef Framework

Nikto
