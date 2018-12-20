plan create::p9 (
  TargetSpec $nodes
) {
  run_command('curl https://bootstrap.pypa.io/get-pip.py | sudo -H python3', $nodes)
  run_command('pip install python-openstackclient', $nodes)
  run_task('create::instances_list', $nodes)
}