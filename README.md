# ACTIVE DIRECTORY ATTACK

Active Directory Attack (AD_Attack.sh) is a tool written in bash that collects some of the most well-known tools in the industry but grouped together to perform specific attacks on Active Directory environments. The tools it uses are:
NMAP
SMBCLIENT
IMPACKET
LDAPSEARCH
CRACKMAPEXEC
JOHN THE RIPPER

Here are some of the attacks that are performed during the process:
1. Scanning specific ports to confirm whether it's an active directory.
2. Null sessions
3. Directory searches without authentication
4. Password cracking
5. AS-REPRousting

## INSTALL

The tool works on the Kali Linux version as some packages are installed by default.

## USAGE

The tool is very easy to use, you just need to edit the script and change the global variables that are located at the beginning of the script for the ones that correspond to your environment::

AD_IP="172.26.16.117"

Domain="dark.local"

Domain_Name="dc=dark,dc=local"

Users_File='users_test.txt'

Dict_JTR='/usr/share/john/password.lst'

After that, just run the command and wait for the results:

sh AD_Attack.sh

## ROADMAP

1. Include more attacks towards the active directory.
	1. User Enumeration
	2. Kerberousting
	3. PasswordSpray
	4. And more
2. Optimize the code.
3. Migrate to a language like Python.

## License

Copyright (c) 2023 iron_fortress


Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.


## Credits

This application uses the following tools:

- [Nmap](https://nmap.org/) for network exploration and service identification.
- [SMBclient](https://www.samba.org/samba/docs/current/man-html/smbclient.1.html) for interacting with SMB/CIFS servers.
- [Impacket](https://github.com/SecureAuthCorp/impacket) for network protocol manipulation and vulnerability exploitation.
- [LDAPsearch](https://linux.die.net/man/1/ldapsearch) for searching and retrieving information from LDAP servers.
- [CrackMapExec](https://github.com/byt3bl33d3r/CrackMapExec) for security auditing and domain exploration.
- [John the Ripper](https://www.openwall.com/john/) for password recovery and brute-force testing.

We thank the developers and contributors of these tools for their contribution to the information security community.


## Contact

Twitter: @iron_fortress

## Disclaimer

This tool is intended for educational purposes only. You should only use it with the express permission of the owner of the technology infrastructure that you are testing. Unauthorized or malicious use of this tool is strictly prohibited.

The author of this tool accepts no responsibility for any damage or illegal use that may result from the use of this tool. By using this tool, you agree to use it responsibly and at your own risk.
