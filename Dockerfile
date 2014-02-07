from lightsofapollo/node:0.10.25
maintainer James Lal <james@lightsofapollo.com>

# start by installing all our ubuntu packages
run apt-get -yq update
run apt-get -yq install git-core curl wget firefox build-essential xvfb

# Then add our non-root user
env HOME /home/tester
run useradd tester --create-home
workdir /home/tester

# get node ready
add ./bin/git_branch_taskrunner /home/tester/bin/git_branch_taskrunner
run chmod u+x /home/tester/bin/git_branch_taskrunner
user tester
