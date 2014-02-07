from lightsofapollo/node:0.10.24
maintainer James Lal <james@lightsofapollo.com>

# start by installing all our ubuntu packages
run apt-get -y update
run apt-get -y install git-core \
                       curl \
                       wget \
                       firefox \
                       build-essential \
                       xvfb

# Then add our non-root user
env HOME /home/tester
run useradd tester --create-home
workdir /home/tester

# get node ready
add ./bin/git_branch_taskrunner /home/tester/bin/git_branch_taskrunner
add ./entrypoint /entrypoint
run chmod u+x /entrypoint
run chmod u+x /home/tester/bin/git_branch_taskrunner
user tester
entrypoint ["/entrypoint"]
