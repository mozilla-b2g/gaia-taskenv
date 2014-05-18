from lightsofapollo/node:0.10.26
maintainer James Lal <james@lightsofapollo.com>

# start by installing all our ubuntu packages
run sudo apt-get -y update
run sudo apt-get -yq install git-core curl wget firefox build-essential xvfb python-pip

env HOME /home/tester
env PATH $PATH:/home/tester/bin
run mkdir -p /home/tester
workdir /home/tester

# run this first so docker caches this easier
run git clone http://github.com/mozilla-b2g/gaia.git /home/tester/git_checkout/

# get node ready
add ./bin/entrypoint /home/tester/bin/entrypoint
run chmod a+x ./bin/entrypoint
# this entrypoint is bash with Xvfb running by default
entrypoint ["/home/tester/bin/entrypoint"]
