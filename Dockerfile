from lightsofapollo/node:0.10.26
maintainer James Lal <james@lightsofapollo.com>

# start by installing all our ubuntu packages
run apt-get -yq update
run apt-get -yq install git-core curl wget firefox build-essential xvfb

# Then add our non-root user
env HOME /home/tester
env PATH $PATH:/home/tester/bin
run useradd tester --create-home
workdir /home/tester

# get node ready
add ./bin/git_branch_taskrunner /home/tester/bin/git_branch_taskrunner
add ./bin/entrypoint /home/tester/bin/entrypoint
run chmod u+x ./bin/git_branch_taskrunner
run chmod a+x ./bin/entrypoint
run ls -la bin/entrypoint
user tester
entrypoint ["/home/tester/bin/entrypoint"]
