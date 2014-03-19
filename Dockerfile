from lightsofapollo/node:0.10.26
maintainer James Lal <james@lightsofapollo.com>

# start by installing all our ubuntu packages
run apt-get -yq update && apt-get -yq install git-core curl wget firefox build-essential xvfb && apt-get clean
run apt-get -yq install python-pip

# Then add our non-root user
env HOME /home/tester
env PATH $PATH:/home/tester/bin
run mkdir -p /home/tester
workdir /home/tester

# get node ready
add ./bin/git_branch_taskrunner /home/tester/bin/git_branch_taskrunner
add ./bin/github_pr /home/tester/bin/github_pr
add ./bin/entrypoint /home/tester/bin/entrypoint
run chmod u+x ./bin/git_branch_taskrunner
run chmod u+x ./bin/github_pr
run chmod a+x ./bin/entrypoint
run ls -la bin/entrypoint
run git clone http://github.com/mozilla-b2g/gaia.git /home/tester/git_checkout/
entrypoint ["/home/tester/bin/entrypoint"]
