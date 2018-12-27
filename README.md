## p9-instances creation

(WIP)
# Prereqs:

1. Need python, pip, and openstack installed
* `curl https://bootstrap.pypa.io/get-pip.py | sudo -H python3'`
* `pip install python-openstackclient`

2. Platform9 requirements
* Need to have a tenant and user account set up 
* Need to generate an ssh key and add to your account 
** NAMING MATTERS: don't include any spaces in your name (ie p9key vs p9 key)

3. inventory.yaml changes
* update with the name of your project
* detail for your platform9 project can be found by navigating to Access and Security on the left nav, clicking the API Access tab at the top of the page, then scrolling to the bottom to the section labeled "Openstack RC"

When you run the create::p9_instance task, add the --password flag at the end and enter your platform9 credentials.

