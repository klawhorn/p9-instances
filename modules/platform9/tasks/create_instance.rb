#!/usr/bin/env ruby
require 'open3'
require_relative "../../ruby_task_helper/files/task_helper.rb"

class MyTask < TaskHelper 
  def task(user: 'your_mom', instance_name: 'new instance', image: 'centos_7_x86_64', flavor: 'vol.medium', network: 'network1', key_name: 'puppet-machine', **kwargs)
    
    # Set the environment variables that are needed for the openstack command
    ENV['OS_AUTH_URL']=kwargs[:'_target']['os_auth_url']
    ENV['OS_NOVA_URL']=kwargs[:'_target']['os_nova_url']
    ENV['OS_IDENTITY_API_VERSION']=kwargs[:'_target']['os_identity_api_version']
    ENV['OS_REGION_NAME']=kwargs[:'_target']['os_region_name']
    ENV['OS_USER_DOMAIN_ID']=kwargs[:'_target']['os_user_domain_id']
    ENV['OS_PROJECT_DOMAIN_ID']=kwargs[:'_target']['os_project_domain_id']
    ENV['OS_PROJECT_NAME']=kwargs[:'_target']['project_name']
    ENV['OS_USERNAME']="#{user}"
    ENV['OS_PASSWORD']=kwargs[:'_target']['password']
    
    # Run the openstack command to make a new instance
    stdout, sterr, status = Open3.capture3("openstack server create --image #{image} --flavor #{flavor} --key-name p9key --network #{network} #{instance_name} -f json")
    raise "Failed to provision #{sterr}" unless status.success?
    result = JSON.parse(stdout)
    
    # Print the instance id (next step is to get this into the next needed command)
    {'instance_name' => result['name'],
     'instance_id'   => result['id']}
  end
end

MyTask.run if __FILE__ == $0

