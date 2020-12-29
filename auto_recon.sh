#!/bin/bash

if which figlet >/dev/null;then
	figlet -k -f slant Auto-Recon
else
	echo "figlet was not installed, installing now"
	sudo apt install figlet
	echo "figlet was installed, restart the tool!"
	exit 0
fi
echo "[*] This is an Auto-Recon script"
echo "[!] Today's date is"
date

if [ -z $1 = ""]
then 
	echo "[!] Usage: ./autoRecon.sh <target> "
	exit 1
else
	echo "[!] Starting Auto-Recon"
fi
if which nmap >/dev/null; then
	echo "[!] Running Fast nmap scan"
else
	echo "[!] nmap is not installed"
	echo "[!] Start Installing"
	sudo apt install nmap
fi
nmap -F $1
echo '[!] Detailed scan using nmap...'
nmap -sC -sV -oA $1
echo '[!] Looking for hidden directories using gobuster...'
if which gobuster >/dev/null
then
	gobuster dir --url $1 -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt 
else
	echo "[!] gobuster is not installed, installing now"
	sudo apt install gobuster
	echo "Done"
fi
echo '[!] Scanning the target using nikto...'
nikto -h $1
echo '[!] Looking for sudomains..'
python3 /opt/Sublist3r/sublist3r.py -d $1
echo '+++++| Finished |+++++'

