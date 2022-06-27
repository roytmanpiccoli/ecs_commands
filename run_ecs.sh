 !/bin/sh



echo export CURRENT_DIR=$(pwd) >> ~/.bashrc
echo CURRENT_DIR

cd "$CURRENT_DIR"
sudo chmod +x 1_tools_install.sh
sudo chmod +x 2_increase_disk_size.sh
sudo chmod +x 3_packages_install.sh


./1_tools_install.sh
./2_increase_disk_size.sh
./3_packages_install.sh