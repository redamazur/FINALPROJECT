
###installtion AZCLI
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
az account set --subscription "a94e75c3-eb53-4976-9cbf-eac8d430d6d4"
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -

### installation terraform
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install terraform

### installation ansible
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt-get install ansible -y

git clone https://github.com/redamazur/FINALPROJECT.git
git clone https://github.com/redamazur/AnsibleEPRB.git
cd FINALPROJECT/
az login
####il faut s'identifier sur Azure #####
# cd ..
terraform init
terraform plan -out terraform_plan.tfplan
terraform apply terraform_plan.tfplan
####il faut enregistrer la clé sur ~/AnsibleEPRB/sslFile.pem #####
echo vi ~/AnsibleEPRB/sslFile.pem
echo chmod 0400 ~/AnsibleEPRB/sslFile.pem
echo echo cd ../AnsibleEPRB
echo  ansible-playbook Dev_Web_installation.yaml
echo  ansible-playbook Dev_App_installation.yaml
echo  ansible-playbook Dev_Bdd_installation.yaml
pause
