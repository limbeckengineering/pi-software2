#This is the configuration file for the surfacePi used in Limbeck Engineering's current project.
#!/bin/bash



if (( $EUID != 0 )); then 
   echo "$(tput setaf 1)This must be run as root. Try 'sudo bash $0'.$(tput sgr0)" 
   exit 1 
fi

echo "$(tput setaf 2) This scripts will configure your Surface Raspberry Pi for _________________________.$(tput sgr0)"

echo "$(tput setaf 2)Software currently compatible with RASPBIAN only.$(tput sgr0)"
echo "$(tput setaf 2)Internet connection required.$(tput sgr0)"
read -p "$(tput bold ; tput setaf 1)Press [Enter] if download origonated in /home/pi 
               [Ctrl-C] to abort and restart instillation...$(tput sgr0)"

echo "$(tput bold ; tput setaf 1)Remember$(tput sgr0) $(tput setaf 3)Enable Camera and then reboot in Raspi-Config $(tput sgr0)"

read -p "$(tput bold ; tput setaf 1)Press [Enter] to begin, [Ctrl-C] to abort...$(tput sgr0)"

echo "$(tput setaf 3)Creating directories needed in installation...$(tput sgr0)"
cd /home/pi
mkdir scripts
cd scripts
mkdir java

echo "$(tput setaf 3)Moving motorcontrol.sh into /home/pi/scripts $(tput sgr0)"
mv /home/pi/pi-software/software/motorcontrol.sh /home/pi/scripts
echo "$(tput setaf 3)Done.$(tput sgr0)"

echo "$(tput setaf 3)Updating Raspbian Packages....$(tput sgr0)"
apt-get update -q -y

echo "$(tput setaf 3)Installing Java 7...$(tput sgr0)"
apt-get install openjdk-7-jre
apt-get install openjdk-7-jdk

echo "$(tput setaf 3)Installing the latest RXTX Libraries...$(tput sgr0)"
apt-get install librxtx-java

echo "$(tput setaf 3)Moving files located in: RPiSerial...$(tput sgr0)"
cd RPiSerial
mv /home/pi/pi-software/RPiSerial/i686-unknown-linux-gnu /usr/lib/jvm/java-7-openjdk-common/jre/lib
mv /home/pi/pi-software/RPiSerial/RXTXcomm.jar /usr/lib/jvm/java-7-openjdk-common/jre/lib
echo "$(tput setaf 3)Serial communication software installed sucessfully.$(tput sgr0)"

echo "$(tput setaf 3)Downloading ServoBlaster (in /home/pi/PiBits)...$(tput sgr0)"
cd /home/pi
git clone git://github.com/richardghirst/PiBits.git

echo "$(tput setaf 3)Making the userspace version of ServoBlaster...$(tput sgr0)" 
cd /home/pi/PiBits/ServoBlaster/user
make 


echo "$(tput setaf 3)Deleting uneeded files from PiBits...$(tput sgr0)"
rm -f /home/pi/PiBits/MouseScan
rm -f /home/pi/PiBits/MPU6050-Pi-Demo
rm -f /home/pi/PiBits/PiFmDma

echo "$(tput setaf 3)ServoBlaster sucessfully installed.$(tput sgr0)"
sudo raspi-config



