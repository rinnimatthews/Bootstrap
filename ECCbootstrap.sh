__apt_get_install_noinput() {
    apt-get install -y -o DPkg::Options::=--force-confold $@; return $?
}

install_main_dependencies(){
packages="dpkg
git"
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

install_dsniff_dependencies(){
packages="libdb5.1
libnet1
libnids1.21"
   echo "Installing dsniff dependency packages"
   for PACKAGE in $packages; do
       __apt_get_install_noinput $PACKAGE >> $HOME/ECC-install.log #2>&1
       ERROR=$?
       if [ $ERROR -ne 0 ]; then
           echo "Install Failure: $PACKAGE (Error Code: $ERROR)"
       else
           echo "Installed Package: $PACKAGE"
       fi
   done
}

install_snmpcheck_dependencies(){
packages="libsnmp15"
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

install_setoolkit_dependencies(){
packages="python"
   echo "Installing setoolkit dependency packages"
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

install_sslstrip_dependencies(){
#packages="ruby
#ruby-snmp
#libnumber-bytes-human-perl
#libnet-snmp-perl
#sslstrip"

packages="sslstrip"
   echo "Installing sslstrip dependency packages"
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

install_hydra_dependencies(){
#packages="ruby
#ruby-snmp
#libnumber-bytes-human-perl
#libnet-snmp-perl
#hydra"

packages="hydra"
   echo "Installing hydra dependency packages"
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

install_wpscan_dependencies(){
packages="git
docker
libcurl4-openssl-dev
libxml2
libxml2-dev
libxslt1-dev
ruby2.0
ruby-dev
build-essential
libgmp-dev
zlib1g-dev"

   echo "Installing wpscan dependency packages"
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


install_setoolkit(){
CDIR=$(pwd)
cd /tmp
git clone https://github.com/trustedsec/social-engineer-toolkit/ set/
cd /tmp/set
python setup.py install
cd $CDIR
rm -r -f /tmp/set
}

install_wpscan(){
CDIR=$(pwd)
cd /tmp
git clone https://github.com/wpscanteam/wpscan.git /tmp/wpscan
cd /tmp/wpscan
sudo gem install bundler && bundle install --without test
cd $CDIR
rm -r -f /tmp/wpscan
}


install_ECC_Tools() {
  echo "ECC tools: Installing CEH-v10 Tools"
	CDIR=$(pwd)
	mkdir /tmp/ECC-tools
	git clone --recursive https://github.com/rinnimatthews/ECC-tools /tmp/ECC-tools >> $HOME/ECC-install.log 2>&1
	cd /tmp/ECC-tools

	install_main_dependencies
# 1	
	echo "* Info: Installing Nmap Tool..."        
	dpkg -i nmap_7.40-2_amd64.deb && apt install -f
        echo "ECC tools: Completed Nmap Tool Installation"
# 2	
	echo "* Info: Installing NetDiscover Tool..."        
	dpkg -i netdiscover_0.3beta7~pre+svn118-1_amd64.deb && apt install -f
	echo "ECC tools: Completed NetDiscover Tool Installation"
# 3	
	echo "* Info: Installing hping3 Tool..."        
	dpkg -i hping3_3.a2.ds2-7_amd64.deb && apt install -f
        echo "ECC tools: Completed hping3 Tool Installation"
# 4	
	echo "* Info: Installing Whois Tool..."        
	dpkg -i whois_5.2.14_amd64.deb && apt install -f
        echo "ECC tools: Completed Whois Tool Installation"
#5	
	echo "* Info: Installing dsniff Tool..."        
	install_dsniff_dependencies
	dpkg -i dsniff_2.4b1+debian-22_amd64.deb && apt install -f
        echo "ECC tools: Completed dsniff Tool Installation"
# No
#	echo "* Info: Installing SNMP Tool..."  
#	#install_snmpcheck_dependencies  
#       dpkg -i libsnmp15_5.4.3~dfsg-2.8+deb7u1_amd64.deb && apt install -f   
#	dpkg -i snmp_5.4.3~dfsg-2.8+deb7u1_amd64.deb && apt install -f
#       echo "ECC tools: Completed SNMP Tool Installation"	
# No
#	echo "* Info: Installing SNMPCHECK Tool..."        
#	install_snmpcheck_dependencies
#	dpkg -i snmpcheck_1.9-0kali1_all.deb && apt install -f
#       echo "ECC tools: Completed SNMPCHECK Tool Installation"
# 6
	echo "* Info: Installing sslstrip Tool..."        
	install_sslstrip_dependencies
#	dpkg -i sslstrip_0.9-1_all.deb && apt install -f
        echo "ECC tools: Completed sslstrip Tool Installation"
# 7	
	echo "* Info: Installing Hydra Tool..." 
	install_hydra_dependencies  
#	dpkg -i hydra_8.0-1_amd64.deb && apt install -f
        echo "ECC tools: Completed Hydra Tool Installation"
# 8	
	echo "* Info: Installing SE-Toolkit..."
	install_setoolkit_dependencies        
	install_setoolkit
        echo "ECC tools: Completed SEToolkit Installation"
# 9
	echo "* Info: Installing wpscan Tool..."        
	install_wpscan_dependencies
	install_wpscan
        echo "ECC tools: Completed wpscan Tool Installation"

        cd $CDIR
	rm -r -f /tmp/ECC-tools
	echo "ECC tools: Completed installing CEH-v10 Tools"
}


complete_message() {
    echo
    echo "EC OS Installation Complete!"
}


#Calling to install ECC-Tools    
echo "Welcome to EC-Council OS Installation Suite"
install_ECC_Tools
complete_message
