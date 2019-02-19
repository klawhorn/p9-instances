plan platform9::agent (
  TargetSpec $nodes
) {
  # Run the task to create the instance
  # run_task('platform9::create_instance', $nodes)
  
  # Run the task to set the network and ip
  # run_task('platform9::set_networks', $nodes)
  
  # Run the bootstrap::pe task against the floating ip to install the agent 
  
  # Sign the cert on the master 
  
  # Run puppet on the agent
}