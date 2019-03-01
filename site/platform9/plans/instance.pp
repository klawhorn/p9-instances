plan platform9::instance (
  String $nodeName,
  String $imageType,
  String $flavor,
  String $network,
  String $ext_network,
  String $key_name,
  String $user,
) {
  # Run the task to create the instance
  run_task('platform9::create_instance', platform9, image => $imageType, flavor => $flavor, network => $network, key_name => $key_name, instance_name => $nodeName, user => $user)
  
  # Run the task to set the network and ip
  run_task('platform9::set_networks', platform9, instance_name => $nodeName, network => $network, ext_network => $ext_network, user => $user)
  
  # Run the task to install PE
  # run_task('bootstrap::linux', $server)
}