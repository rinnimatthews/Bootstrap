
install_ECC_Tools() {
  # Installing Burp suite from ECCTools Github Repository
  echo "ECC tools: Installing CEH-v10 Tools"
	CDIR=$(pwd)
	mkdir /tmp/ECC-tools
	git clone --recursive https://github.com/rinnimatthews/ECC-tools /tmp/ECC-tools >> $HOME/ECC-install.log 2>&1
	cd /tmp/ECC-tools
	#bash burpsuite_free_linux_v1_7_16.sh >> $HOME/ECC-install.log 2>&1
        #gdebi netdiscover_0.3beta7~pre+svn118-1_amd64.deb	
	echo "* Info: Installing Nmap Tool..."        
	dpkg -i nmap_7.40-2_amd64.deb && apt install -f
        echo "ECC tools: Completed Nmap Tool Installation"
	echo "* Info: Installing NetDiscover Tool..."        
	dpkg -i netdiscover_0.3beta7~pre+svn118-1_amd64.deb && apt install -f
	echo "ECC tools: Completed NetDiscover Tool Installation"
	echo "* Info: Installing hping3 Tool..."        
	dpkg -i hping3_3.a2.ds2-7_amd64.deb && apt install -f
        echo "ECC tools: Completed hping3 Tool Installation"
	echo "* Info: Installing Whois Tool..."        
	dpkg -i whois_5.2.14_amd64.deb && apt install -f
        echo "ECC tools: Completed Whois Tool Installation"
	#echo "* Info: Installing SNMPCHECK Tool..."        
	#dpkg -i snmpcheck_1.9-0kali1_all.deb && apt install -f
        #echo "ECC tools: Completed SNMPCHECK Tool Installation"

        cd $CDIR
	rm -r -f /tmp/ECC-tools
}

complete_message() {
    echo
    echo "Installation Complete!"
}


#Calling to install ECC-Tools    
echo "Welcome to EC-Council OS Installation Suite"
install_ECC_Tools
complete_message


