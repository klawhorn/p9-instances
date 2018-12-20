#!/usr/bin/env ruby
require 'open3'
require_relative "../../ruby_task_helper/files/task_helper.rb"

class MyTask < TaskHelper 
  def task(instance_name: 'new instance', image: 'centos_7_x86_64', flavor: 'vol.medium', **kwargs)
    ENV['OS_AUTH_URL']='https://puppet.platform9.net/keystone/v3'
    ENV['OS_NOVA_URL']='https://puppet.platform9.net/nova/v2.1'
    ENV['OS_IDENTITY_API_VERSION']='3'
    ENV['OS_REGION_NAME']="Portland"
    ENV['OS_USER_DOMAIN_ID']='default'
    ENV['OS_PROJECT_DOMAIN_ID']='default'
    ENV['OS_PROJECT_NAME']=kwargs[:'_target']['project_name']
    ENV['OS_USERNAME']=kwargs[:'_target']['user']
    ENV['OS_PASSWORD']=kwargs[:'_target']['password']
    stdout, sterr, status = Open3.capture3("openstack server create --image #{image} --flavor #{flavor} #{instance_name} -f json")
    raise "Failed to provision #{sterr}" unless status.success?
    result = JSON.parse(stdout)
    instance_id = result['id']
    {'instance_id' => instance_id}
  end
end

MyTask.run if __FILE__ == $0

