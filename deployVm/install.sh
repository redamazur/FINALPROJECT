###depuis azure CLI
git clone https://github.com/redamazur/PLB.git

######################
##### pour la DEV ###
######################

cd PLB/deployVm ##DEV
terraform init
terraform plan -out terraform_plan.tfplan
terraform apply terraform_plan.tfplan
## copier la cle SSL sur deployCle.pem
vi deployCle.pem
chmod 0400 deployCle.pem
# recuperer l'adresse ip
ssh -i deployCle.pem azureuser@xx.xx.xx.xx


###installtion AZCLI
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -

### installation terraform
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install terraform

### installation ansible
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt-get install ansible -y
ansible-galaxy collection install community.mysql

git clone https://github.com/redamazur/PLB.git
git clone https://github.com/redamazur/AnsibleEPRB.git
cd PLB/

##pour la Prod:
cd ProdVM/ ##DEV
terraform init
terraform plan -out terraform_plan.tfplan
terraform apply terraform_plan.tfplan
####il faut enregistrer la clé sur ~/AnsibleEPRB/sslFile.pem #####

chmod 0400 ~/AnsibleEPRB/sslFile.pem
cd ../../AnsibleEPRB
ansible-playbook Dev_Web_installation.yaml
ansible-playbook Dev_App_installation.yaml
ansible-playbook Dev_Bdd_installation.yaml


########################################################

######################
##### pour la PROD ###
######################
git clone https://github.com/redamazur/PLB.git
cd ~/PLB/ProddeployVm/
terraform init
terraform plan -out terraform_plan.tfplan
terraform apply terraform_plan.tfplan
## copier la cle SSL sur deployCle.pem
vi deployCle.pem
chmod 0400 deployCle.pem
# recuperer l'adresse ip
ssh -i deployCle.pem azureuser@xx.xx.xx.xx
cd Dev_Vm/
terraform init
terraform plan -out terraform_plan.tfplan
####il faut enregistrer la clé sur ~/AnsibleEPRB/sslFile.pem #####

chmod 0400 ~/AnsibleEPRB/sslFile.pem
cd ../../AnsibleEPRB
ansible-playbook Dev_Web_installation.yaml
ansible-playbook Dev_App_installation.yaml
ansible-playbook Dev_Bdd_installation.yaml
