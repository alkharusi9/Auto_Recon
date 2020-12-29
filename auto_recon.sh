#!/bin/bash
# Written by Alsalt Alkharoosi

if which figlet >/dev/null;then
	figlet -k -f slant Auto-Recon
else
	echo "figlet was not installed, installing now"
	sudo apt install figlet
	echo "figlet was installed, restart the tool!"
fi
echo "[*] This is an Auto-Recon script"
echo "[*] Today's date is"
date

if [ -z "${1}"];then 
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
sleep 3
sudo nmap -A $1 -oA detailed-scan
echo '[!] Looking for hidden directories using gobuster...'
target="$1"
target2="https://"$target
echo "[!] The target is:"$target2
sleep 3
if which gobuster >/dev/null
then
	gobuster dir --url $target2 -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt 
else
	echo "[!] gobuster is not installed, installing now"
	sudo apt install gobuster
	echo "Done"
fi
sleep 3
echo '[!] Scanning the target using nikto...'
nikto -h $1
sleep 3
echo "[!] Looking for subdomains using sublist3r"
if which sublist3r 2>/dev/null;then
	python3 /opt/Sublist3r/sublist3r.py -d $1
else
	echo "[!] It seems sublist3r is not installed, installing now"
	sudo apt install sublist3r 
	echo "[!] Done"
echo '+++++| Finished |+++++'


