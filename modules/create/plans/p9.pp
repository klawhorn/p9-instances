plan create::p9 (
  TargetSpec $nodes
) {
  run_task('create::instances_list', $nodes)
}