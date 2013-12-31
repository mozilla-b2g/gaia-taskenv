from ubuntu
maintainer James Lal <james@lightsofapollo.com

# start by installing all our ubuntu packages
run apt-get -y update
run apt-get -y install git-core \
                       curl \
                       wget \
                       firefox \
                       build-essential \
                       xvfb

# Then add our non-root user
run useradd tester --create-home
user tester
workdir /home/tester
run wget https://raw.github.com/isaacs/nave/master/nave.sh
run chmod u+x nave.sh
run BASH=1 SHELL=bash /bin/bash nave.sh install stable

# start in the nave subshell
entrypoint ["/home/tester/nave.sh", "use", "stable"]
