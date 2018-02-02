install_desktop_background() {
echo "Transforming Desktop Background"
	CDIR=$(pwd)
	cd /home/
	#apt-get install git
	git clone --recursive https://github.com/rinnimatthews/ECC-certis /home/ECC-certis >> $HOME/ECC-install.log 2>&1
sudo chmod 777 /home/ECC-certis/
sudo chmod 777 /home/ECC-certis/Images
#sudo chmod 777 /home/ECC-certis/link_files
#sudo chmod 777 /home/ECC-certis/link_files/CEH.sh
#sudo chmod 777 /home/ECC-certis/link_files/CND.sh
#sudo chmod 777 /home/ECC-certis/link_files/CHFI.sh
cp -R /home/ECC-certis/Images/CEH.png /usr/share/backgrounds/warty-final-ubuntu.png

#rm -f /home/ECC-certis

}
customize_default_icons() {
echo "Replacing default panel icons"
sudo gsettings set com.canonical.Unity.Launcher favorites "['nautilus-home.desktop','application://firefox.desktop','application://gnome-terminal.desktop']"
echo "default panel icons replaced"
}
__apt_get_install_noinput() {
    apt-get install -y -o DPkg::Options::=--force-confold $@; return $?
}
install_dependency_packages(){
packages="alien
openjdk-6-jdk
build-essential
bundler
libreadline-dev
libpq5
libpq-dev
libreadline5
libsqlite3-dev
libpcap-dev
git
git-core
gnupg2
autoconf
postgresql
pgadmin3
curl
zlib1g-dev
libxml2-dev
libxslt1-dev
vncviewer
libyaml-dev
git
hydra
libdb5.1
libnet1
libnids1.21
libpcap0.8-dev 
libssl1.0.0
libssl-dev
libwww-mechanize-shell-perl
openssl
perl
python-pip
python
python-dnspython
python-mechanize
python-slowaes
python-xlsxwriter
python-jsonrpclib
python-lxml
sslstrip
wireshark"
	packages="$packages"
echo "Installing Dependecy packages for ECC Tools"
   for PACKAGE in $packages; do
        __apt_get_install_noinput $PACKAGE >> $HOME/ECC-install.log 2>&1
        ERROR=$?
        if [ $ERROR -ne 0 ]; then
            echo "Install Failure: $PACKAGE (Error Code: $ERROR)"
        else
            echo "Installed Package: $PACKAGE"
        fi
    done
	echo "Updating Repository Package List ..."
    	apt-get update >> $HOME/ECC-install.log 2>&1 || return 1
}
install_recon_ng(){
   CDDR=$(pwd)
   cd /tmp/ECCTools/reconng
     #pip install -r REQUIREMENTS 
    cp -r /tmp/ECCTools/reconng /home/cast/
    cd $CDDR
}
install_perl_modules(){
	perl -MCPAN -e "install Net::CIDR"
	perl -MCPAN -e "install Net::Whois::ARIN"
	perl -MCPAN -e "install Object::InsideOut"
	perl -MCPAN -e "install Template"
	perl -MCPAN -e "install Test::Class"
	perl -MCPAN -e "install Test::MockObject"
	perl -MCPAN -e "install Net::hostent"
	perl -MCPAN -e "install Getopt::Long"
	perl -MCPAN -e "install IO::File"	
	perl -MCPAN -e "install Net::Wigle"
	perl -MCPAN -e "install Thread::Queue"
	perl -MCPAN -e "install Net::IP"
	perl -MCPAN -e "install Net::DNS"
	perl -MCPAN -e "install Net::Netmask"
	perl -MCPAN -e "install Net::Whois::IP"
	perl -MCPAN -e "install HTML::Parser"
	perl -MCPAN -e "install XML::Writer"
	perl -MCPAN -e "install String::Random"
	perl -MCPAN -e "install WWW::Mechanize"
}
install_dnsdict6(){
	CDDR=$(pwd)
	mkdir /tmp/dnsdict6
	cp thc-ipv6-1.8.tar.gz /tmp/dnsdict6/
	cd /tmp/dnsdict6
	tar xzvf thc-ipv6-1.8.tar.gz
	cd thc-ipv6-1.8/
	make
	make install
	cd $CDDR
}

install_fierce(){
	CDDR=$(pwd)
	mkdir /tmp/fierce
	cp -r fierce2 /tmp/fierce/
	cd /tmp/fierce/fierce2
	perl Makefile.PL
	make
	make test
	make install
	mkdir -p /pentest/enumeration/fierce/
	ln -s /usr/local/bin/fierce /pentest/enumeration/fierce/fierce
	cp -R tt ~/.fierce2/
	cd $CDDR
}
install_metasploit_dependencies(){
packages="openjdk-6-jdk
build-essential
bundler
libreadline-dev
libssl-dev
libpq5
libpq-dev
libreadline5
libsqlite3-dev
libpcap-dev
git-core
gnupg2
autoconf
postgresql
pgadmin3
curl
zlib1g-dev
libxml2-dev
libxslt1-dev
vncviewer
libyaml-dev"
#oracle-java8-installer"
	echo "Adding the Oracle Java Package Source Repository"
	add-apt-repository -y ppa:webupd8team/java  >> $HOME/ECC-install.log 2>&1 || return 1
	echo "Updating Repository Package List ..."
    	apt-get update >> $HOME/ECC-install.log 2>&1 || return 1

   #echo "Installing Metasploit deprintf "\n"pendency packages"
   #for PACKAGE in $packages; do
    #    __apt_get_install_noinput $PACKAGE >> $HOME/ECC-install.log 2>&1
    #    ERROR=$?
     #   if [ $ERROR -ne 0 ]; then
     #       echo "Install Failure: $PACKAGE (Error Code: $ERROR)"
     #   else
     #       echo "Installed Package: $PACKAGE"
     #   fi
    #done
		
	echo "Updating Repository Package List ..."
    	apt-get update >> $HOME/ECC-install.log 2>&1 || return 1
}
install_metasploit(){
	CDDR=$(pwd)
	cd /home/cast/
	echo "Installing and Configuring RVM"

	#gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
	#\curl -sSL https://get.rvm.io | bash -s stable --ruby
	curl -sSL https://rvm.io/mpapis.asc | gpg2 --import -
	curl -L hwget --quiet -O - https://raw.githubusercontent.com/LalithaKurma/ECCTest/master/CEHbootstrap.sh | sudo bash -s -- -i -s –yttps://get.rvm.io | bash -s stable
	source /usr/local/rvm/scripts/rvm
	echo "source /usr/local/rvm/scripts/rvm" >> ~/.bashrc
	source ~/.bashrc
	RUBYVERSION=$(wget https://raw.githubusercontent.com/rapid7/metasploit-framework/master/.ruby-version -q -O - )
	rvm install $RUBYVERSION
	rvm use $RUBYVERSION --default
	gem install bundler
	echo "Downloading and Installing Metasploit Framework..."
	git clone https://github.com/rapid7/metasploit-framework.git
	cd metasploit-framework/
	#rvm --install '.ruby-version'
	rvm --default use ruby-${RUByVERSION}@metasploit-framework
	gem install bundler
	gem install rubygems-bundler
	gem regenerate_binstubs
	gem install pg -v 0.19.0
	gem install multi_test -v 0.1.2	
	bundle install
	gem update bundler
	bundle install
	cd $CDDR
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
install_slowloris(){
	CDDR=$(pwd)
	cd /home/cast/
	git clone https://github.com/llaera/slowloris.pl
	cd $CDDR
}
install_ECC_Tools() {
	echo "Updating Ubuntu Repositories.."	
	apt-get update >> $HOME/ECC-install.log 2>&1 || return 1   
	install_metasploit_dependencies
	install_dependency_packages
	
	printf "\n"

	echo "ECC tools: Installing Perl Modules"
	install_perl_modules
	echo "ECC tools: Installed Perl Modules"
	printf "\n"

    echo "ECC tools: Copying ECC Tools"
	CDIR=$(pwd)
	git clone --recursive https://github.com/LalithaKurma/ECCTools /tmp/ECCTools >> $HOME/ECC-install.log 2>&1

	cd /tmp/ECCTools

		
	echo "* Info: Installing Nmap Tool..."        
	dpkg -i nmap_7.40-2_amd64.deb && apt install -f
        echo "ECC tools: Completed Nmap Tool Installation"
	printf "\n"

	echo "* Info: Installing Zenmap Tool..."        
	dpkg -i zenmap_7.40-2_all.deb && apt install -f
        echo "ECC tools: Completed Zenmap Tool Installation"
	printf "\n"

	echo "* Info: Installing hping3 Tool..."        
	dpkg -i hping3_3.a2.ds2-7_amd64.deb && apt install -f
        echo "ECC tools: Completed hping3 Tool Installation"
	printf "\n"

	echo "* Info: Installing Whois Tool..."        
	dpkg -i whois_5.2.14_amd64.deb && apt install -f
        echo "ECC tools: Completed Whois Tool Installation"	
	printf "\n"
	
	echo "* Info: Installing dsniff Tool..." 
	dpkg -i dsniff_2.4b1+debian-22_amd64.deb && apt install -f
        echo "ECC tools: Completed dsniff Tool Installation"
	printf"\n"
	
	echo "* Info: Installing recon-ng Tool..."
	install_recon_ng
	echo "ECC tools: Completed recon-ng Installation"
	printf "\n"
		
		
	echo "* Info: Installing dnsenum Tool..."        
	dpkg -i dnsenum_1.2.4.2-6_all.deb && apt install -f
        echo "ECC tools: Completed dnsenum Installation"
	printf "\n"
	
	echo "* Info: Installing dnsdict6 Tool..."
	install_dnsdict6
	echo "ECC tools: Completed dnsdict6 Installation"
	
	echo "* Info: Installing fierce Tool..."        
	install_fierce
        echo "ECC tools: Completed fierce Installation"
	printf "\n"

	echo "* Info: Installing SE-Toolkit..."
	install_setoolkit
        echo "ECC tools: Completed SEToolkit Installation"
	printf "\n"

	echo "* Info: Installing slowloris.pl Tool..."
	install_slowloris
	echo "ECC tools: Completed slowloris.pl Installation"
	printf "\n"	
	
	install_metasploit
	echo "ECC tools: Completed Metasploit Framework Installation"
	printf "\n"

        cd $CDIR
	rm -r -f /tmp/ECCTools
}

complete_message() {
    echo
    echo "Installation Complete!"
}

#Calling to install ECC-Tools    
echo "ECC: Welcome CEH"
install_ECC_Tools
install_desktop_background
customize_default_icons
complete_message
