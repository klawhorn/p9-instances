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
      * Remember the name, you'll need it for the plans/tasks

3. Update the inventory.yaml file with your tenant information
    * Detail for your platform9 project can be found by navigating to Access and Security on the left nav, clicking the API Access tab at the top of the page, then scrolling to the bottom to the section labeled "Openstack RC"
    * Replace "Katie Lawhorn" with the value for your project_name (see OS_PROJECT_NAME in the section described above)
    * To use the plan, right now you'll need to uncomment the "os_password" key and add your platform9 password to the inventory file. If you do not wish to do this, you can run the tasks individually but will need to adjust the password vars that are set within the task files. See the commented lines. 

## Creating a new platform 9 node

### Running the plan
Go to the inventory.yaml file, and put your password into the "os_password" key so that the tasks can use it directly rather than having to enter it into each task invocation. Then run the following bolt plan invocation, replacing the parameters with your desired values. **Be careful about your password, don't check it into your version control! If you are not comfortable using the plan this way, you can run adjust the task files to use the password _target val, and run the tasks individually and enter your password when prompted.**

  * `bolt plan run platform9::instance nodeName=opal5 imageType=centos_7_x86_64 flavor=vol.small network=network1 ext_network=external key_name=p9key user=katie.lawhorn@puppet.com`
  
### Running the tasks individually.
Replace with your desired node name, the name of the ssh key you added to platform9, and your user name in the commands below, and have your platform9 password ready to enter. You can also change the image type or the flavor to suit your needs.

  * `bolt task run platform9::create_instance -n platform9 image=centos_7_x86_64 flavor=vol.small network=network1 key_name=<ssh key in p9> instance_name=<name for new instance> user=<your username> --password`
  
  * `bolt task run platform9::set_networks -n platform9 node=<name for new instance> network=network1 ext_network=external user=<your username> --password`

NEXT UP:
1. Installing an agent on your new node 
2. Installing PE
3. Integrate the bootstrap task for making a new agent node

