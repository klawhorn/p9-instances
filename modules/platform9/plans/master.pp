plan platform9::master (
  TargetSpec $nodes
) {
  # Run the task to create the instance
  # run_task('platform9::create_instance', $nodes)
  
  # Run the task to set the network and ip
  # run_task('platform9::set_networks', $nodes)
  
  # Optional step to do the magic incantation to adjust the hostname (for installs that need to demo agentless functionality within)
    # yum update
    # vi /etc/hostname w/ nodename.p9.puppet.net
    # add a line at the end of /etc/hosts with a line like: 192.168.0.10 katiel.slice.puppetlabs.net katiel
    # restart the systemd-hostnamed service
    # run hostname -f to verify that the hostname was reset 
    
  # Install PE on the machine
    # install wget sudo yum install wget zip unzip file
    # wget the build for PE, open the tar, run the installer
    # make some magic for: 
      # In the install steps, when prompted to add the console admin password to the conf file, update the puppet master host param w/the fqdn:
      # "puppet_enterprise::puppet_master_host": "%{::trusted.certname}" → "puppet_enterprise::puppet_master_host": "katiel.slice.puppetlabs.net"
    # run puppet on the master
    
    # Final output should be the floating ip and the hostname so the user can go put up the dnszones PR
    # OR maybe another task can put up the pr? 
}