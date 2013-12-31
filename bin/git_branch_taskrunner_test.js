suite('git_branch_taskrunner', function() {
  var exec = require('child_process').exec,
      fs = require('fs');

  var TEST_REPO = 'https://github.com/taskcluster/testrepo.git';
  var BRANCHES = {
    master: 'master',
    other: 'otherperson'
  };

  // run the task generator
  function runtask(repo, branch, cmd, callback) {
    var argv = [
      __dirname + '/git_branch_taskrunner',
      repo,
      branch,
      cmd
    ].join(' ');

    return exec(
      argv,
      callback
    );
  }

  // get a special file from the checkout which contains the branch name
  function whoami() {
    return fs.readFileSync('git_checkout/whoami', 'utf8').trim();
  }

  test('success - master', function(done) {
    var uniq = '_RAINBOW_';
    var proc = runtask(
      TEST_REPO,
      BRANCHES.master,
      '\'echo "' + uniq + '"\'',
      function(err, stdout, stderr) {
        assert.ok(stdout.indexOf(uniq) !== -1, 'ran command');
        assert.equal(whoami(), BRANCHES.master);
        assert.equal(proc.exitCode, 0);
        done(err);
      }
    );
  });

  test('planned exit code 222', function(done) {
    var proc = runtask(
      TEST_REPO,
      BRANCHES.other,
      "'exit 222'",
      function(err, stdout, stderr) {
        assert.equal(whoami(), BRANCHES.other);
        assert.equal(proc.exitCode, 222);
        done();
      }
    );
  });

  test('error fetching repo', function(done) {
    var badRepo = 'https://github.com/taskcluster/testrepo_WTFS_MISSING.git';
    var proc = runtask(
      badRepo,
      BRANCHES.other,
      "'exit 0'",
      function(err, stdout, stderr) {
        assert.ok(err);
        assert.ok(stderr.indexOf('not found') !== -1, 'fails on git');
        assert.ok(stderr.indexOf(badRepo) !== -1, 'fails with ', badRepo);
        done();
      }
    );
  });
});
