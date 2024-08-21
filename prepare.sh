sudo apt update
sudo apt upgrade
sudo apt-get install ffmpeg
sudo apt-get install git-core
cd $HOME
mkdir CFDEM
cd CFDEM
git clone https://github.com/minglisyr/CFDEMcoupling-PUBLIC.git
cd $HOME
mkdir LIGGGHTS
cd LIGGGHTS
git clone https://github.com/minglisyr/LIGGGHTS-PUBLIC.git
git clone https://github.com/minglisyr/LPP-Python3.git lpp
cd $HOME
mkdir OpenFOAM
cd OpenFOAM
git clone https://github.com/OpenFOAM/OpenFOAM-5.x.git
git clone https://github.com/OpenFOAM/ThirdParty-5.x.git
cd OpenFOAM-5.x
sudo apt-get install build-essential flex bison cmake zlib1g-dev libboost-system-dev libboost-thread-dev libopenmpi-dev openmpi-bin gnuplot libreadline-dev libncurses-dev libxt-dev libscotch-dev libptscotch-dev paraview
#sudo apt install vtk
#sudo apt install libvtk9-dev
sudo apt install python3-pip
pip3 install numpy
sudo apt update
sudo apt upgrade
echo -e "\nexport WM_NCOMPPROCS=4\nsource \$HOME/OpenFOAM/OpenFOAM-5.x/etc/bashrc" >> ~/.bashrc
source ~/.bashrc
cd $WM_PROJECT_DIR
./Allwmake

cd $HOME/CFDEM
mv CFDEMcoupling-PUBLIC CFDEMcoupling-PUBLIC-$WM_PROJECT_VERSION

cat << 'EOF' >> ~/.bashrc

#================================================#
#- source cfdem env vars
export CFDEM_VERSION=PUBLIC
export CFDEM_PROJECT_DIR=$HOME/CFDEM/CFDEMcoupling-$CFDEM_VERSION-$WM_PROJECT_VERSION
export CFDEM_PROJECT_USER_DIR=$HOME/CFDEM/$LOGNAME-$CFDEM_VERSION-$WM_PROJECT_VERSION
export CFDEM_bashrc=$CFDEM_PROJECT_DIR/src/lagrangian/cfdemParticle/etc/bashrc
export CFDEM_LIGGGHTS_SRC_DIR=$HOME/LIGGGHTS/LIGGGHTS-PUBLIC/src
export CFDEM_LIGGGHTS_MAKEFILE_NAME=auto
export CFDEM_LPP_DIR=$HOME/LIGGGHTS/lpp/src
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/LIGGGHTS/LIGGGHTS-PUBLIC/lib/vtk/build/lib
. $CFDEM_bashrc
#================================================#
EOF
source ~/.bashrc
cfdemCompCFDEMall
