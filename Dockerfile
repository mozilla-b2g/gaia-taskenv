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

# get node ready
env PATH /home/tester/.n/bin:$PATH
env N_PREFIX /home/tester/.n/
run wget https://raw.github.com/visionmedia/n/master/bin/n
run chmod u+x n
run ./n 0.10.24
