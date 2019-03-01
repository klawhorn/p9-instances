#!/usr/bin/env ruby
require 'open3'
require_relative "../../ruby_task_helper/files/task_helper.rb"

class MyTask < TaskHelper 
  def task(user: 'your_mom', instance_name: 'testing1', network: 'network1', ext_network: 'external', **kwargs)
    
    # Set the environment variables that are needed for the openstack command
    ENV['OS_AUTH_URL']=kwargs[:'_target']['os_auth_url']
    ENV['OS_NOVA_URL']=kwargs[:'_target']['os_nova_url']
    ENV['OS_IDENTITY_API_VERSION']=kwargs[:'_target']['os_identity_api_version']
    ENV['OS_REGION_NAME']=kwargs[:'_target']['os_region_name']
    ENV['OS_USER_DOMAIN_ID']=kwargs[:'_target']['os_user_domain_id']
    ENV['OS_PROJECT_DOMAIN_ID']=kwargs[:'_target']['os_project_domain_id']
    ENV['OS_PROJECT_NAME']=kwargs[:'_target']['project_name']
    ENV['OS_USERNAME']="#{user}"
    # use this var when you are using the password flag at the end of the task invocation
    # ENV['OS_PASSWORD']=kwargs[:'_target']['password']
    # use this var when you are putting the password into the inventory.yaml file
    ENV['OS_PASSWORD']=kwargs[:'_target']['os_password']
    
    ## TO-DO: Need conditional logic here for whether a network got set or not. 
    # will probably need some kind of polling logic, because after creation the network is not ready right away. Time is spent "spawning"
    
    # Run the openstack set the network for the node
    #stdout, sterr, status = Open3.capture3("openstack server add network #{node} #{network}")
    #raise "Failed to provision #{sterr}" unless status.success?
    
    # Create a new floating ip
    stdout, sterr, status = Open3.capture3("openstack floating ip create #{ext_network} -f json")
    raise "Failed to provision #{sterr}" unless status.success?
    floating_ip = JSON.parse(stdout)['name']
    
    # Assign the ip to the instance
    stdout, sterr, status = Open3.capture3("openstack server add floating ip #{instance_name} #{floating_ip}")
    raise "Failed to provision #{sterr}" unless status.success?
    
    # Print the node details to the console
    stdout, sterr, status = Open3.capture3("openstack server show #{instance_name}")
    raise "Failed to provision #{sterr}" unless status.success?
    print stdout 
  end
end

MyTask.run if __FILE__ == $0

