__apt_get_install_noinput() {
    apt-get install -y -o DPkg::Options::=--force-confold $@; return $?
}

#install_dsniff_dependencies(){
#packages="libdb5.1
#libnet1
#libnids1.21"
#   echo "Installing dsniff dependency packages"
#   for PACKAGE in $packages; do
#        __apt_get_install_noinput $PACKAGE >> $HOME/ECC-install.log #2>&1
 #       ERROR=$?
 #       if [ $ERROR -ne 0 ]; then
 #           echo "Install Failure: $PACKAGE (Error Code: $ERROR)"
 #       else
 #           echo "Installed Package: $PACKAGE"
 #       fi
 #   done
#}

install_snmpcheck_dependencies(){
packages="ruby
ruby-snmp
libnumber-bytes-human-perl
libnet-snmp-perl"
   echo "Installing snmpcheck dependency packages"
   for PACKAGE in $packages; do
        __apt_get_install_noinput $PACKAGE >> $HOME/ECC-install.log 2>&1
        ERROR=$?
        if [ $ERROR -ne 0 ]; then
            echo "Install Failure: $PACKAGE (Error Code: $ERROR)"
        else
            echo "Installed Package: $PACKAGE"
        fi
    done
}

install_ECC_Tools() {
  echo "ECC tools: Installing CEH-v10 Tools"
	CDIR=$(pwd)
	mkdir /tmp/ECC-tools
	git clone --recursive https://github.com/rinnimatthews/ECC-tools /tmp/ECC-tools >> $HOME/ECC-install.log 2>&1
	cd /tmp/ECC-tools
	#bash burpsuite_free_linux_v1_7_16.sh >> $HOME/ECC-install.log 2>&1
        #gdebi netdiscover_0.3beta7~pre+svn118-1_amd64.deb

	#echo "* Info: Installing SNMP Tool..."        
	#dpkg -i snmp_5.4.3~dfsg-2.8+deb7u1_amd64.deb && apt install -f
        #echo "ECC tools: Completed SNMP Tool Installation"	
	echo "* Info: Installing Nmap Tool..."        
	#dpkg -i nmap_7.40-2_amd64.deb && apt install -f
        echo "ECC tools: Completed Nmap Tool Installation"
	echo "* Info: Installing NetDiscover Tool..."        
	#dpkg -i netdiscover_0.3beta7~pre+svn118-1_amd64.deb && apt install -f
	echo "ECC tools: Completed NetDiscover Tool Installation"
	echo "* Info: Installing hping3 Tool..."        
	#dpkg -i hping3_3.a2.ds2-7_amd64.deb && apt install -f
        echo "ECC tools: Completed hping3 Tool Installation"
	echo "* Info: Installing Whois Tool..."        
	#dpkg -i whois_5.2.14_amd64.deb && apt install -f
        echo "ECC tools: Completed Whois Tool Installation"
	echo "* Info: Installing dsniff Tool..."        
	#install_dsniff_dependencies
	#dpkg -i dsniff_2.4b1+debian-22_amd64.deb && apt install -f
        echo "ECC tools: Completed dsniff Tool Installation"
	#echo "* Info: Installing SNMPCHECK Tool..."        
	install_snmpcheck_dependencies
	dpkg -i snmpcheck_1.9-0kali1_all.deb && apt install -f
        #echo "ECC tools: Completed SNMPCHECK Tool Installation"

        cd $CDIR
	rm -r -f /tmp/ECC-tools
}
#install_setoolkit(){
#echo "ECC tools: Installing SE-Toolkit"
#	CDIR=$(pwd)
#cd /tmp
#git clone https://github.com/trustedsec/social-engineer-toolkit/ set/
#cd /tmp/set
#python setup.py install
# cd $CDIR
#rm -r -f /tmp/set
#echo "ECC tools: Completed SEToolkit Installation"
#}

complete_message() {
    echo
    echo "Installation Complete!"
}


#Calling to install ECC-Tools    
echo "Welcome to EC-Council OS Installation Suite"
install_ECC_Tools
#install_setoolkit
complete_message


