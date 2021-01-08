#!/usr/bin/bash
#rowbot's port scanner
#offsecnewbie.com

IP=$1
echo "Scanning with rustscan to quickly give you ports to start working on"
rustscan -a $1 --ulimit 5000 -- -no-nmap
echo "Using nmap scanning for ports"
ports=$(nmap -p- --min-rate=1000 -T4 $1 | grep ^[0-9] | cut -d '/' -f 1 | tr '\n' ',' | sed s/,$//); 
echo -e "Ports found: $ports";
echo -e "Nmap scanning those ports";
nmap -A -sC -sV -p$ports $1 -oX $1.xml;
echo -e "Searching for known exploits in searchsploit...you might get lucky"
searchsploit -v --nmap $1.xml
rm $1.xml
echo -e  "Don't forget to scan UDP ports if you cant find a foothold using TCP ports"
