# New PE instances in platform9

(WIP)
## Prereqs:

1. Need python, pip, and openstack installed on your local machine
    * `curl https://bootstrap.pypa.io/get-pip.py | sudo -H python3'`
    * `pip install python-openstackclient`

2. Platform9 requirements
    * Need to have a tenant and user account set up 
    * Need to generate an ssh key and add to your account 
      * NAMING MATTERS: don't include any spaces in your name (ie p9key vs p9 key)

3. Update the inventory.yaml file with your tenant information
    * Detail for your platform9 project can be found by navigating to Access and Security on the left nav, clicking the API Access tab at the top of the page, then scrolling to the bottom to the section labeled "Openstack RC"
    * Replace "Katie Lawhorn" with the value for your project_name (see OS_PROJECT_NAME in the section described above)

## Creating a new platform 9 node
WIP: PLAN NOT WORKING YET

Right now you have to run the tasks individually. Replace your desired node name and your user name in the commands below, and have your platform9 password ready to enter.
  * `bolt task run platform9::create_instance -n platform9 image=centos_7_x86_64 flavor=vol.medium network=network1 instance_name=<name for new instance> user=<your username> --password`

  * `bolt task run platform9:set_networks -n platform9 node=<name for new instance> network=network1 ext_network=external user=<your username> --password`

NEXT UP: 
1. Magic incantation for changing the hostname settings
2. Installing PE
3. Integrate the bootstrap task for making a new agent node

