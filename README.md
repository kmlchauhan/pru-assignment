Important notes -
==================

1. Kubernetes: 
   I have created one yml file for both Tomcat deployment and service.

2. Docker: 
   I have created the Vagrantfile to do the following tasks i.e.
     i. Create VM
    ii. Intsall Docker and download nginx image
   iii. Run Nginx container on 8087 host port
    iv. Run the command: vagrant up
     v. Access nginx - curl 192.168.33.10:8087

3. Ansible:
   Instructions:
   -------------
   To run these Ansible Playbooks please run these below commands:
    i. git clone https://github.com/kmlchauhan/pru-assignment.git && cd pru-assignment/ansible && git fetch && git checkout release-v0.2
   ii. ansible-playbook -i dev upgradeOS.yml

   Please note that, 
    i. updateOS role will take around 50 minutes to complete so please wait for this much time. I have tested the role and it's working fine.
       > Just to validate the run of above role you can run the command: uname -a
       > It will give you the latest kernel version
   ii. Also, currently mountXFS role is giving some error and that's why I have commented it in upgradeOS.yml playbook.
   
