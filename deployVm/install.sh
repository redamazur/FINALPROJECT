curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
az account set --subscription "a94e75c3-eb53-4976-9cbf-eac8d430d6d4"
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install terraform
sudo apt-get install ansible -y
git clone https://github.com/redamazur/FINALPROJECT.git
git clone https://github.com/redamazur/AnsibleEPRB.git
cd FINALPROJECT/
terraform init
terraform plan -out terraform_plan.tfplan
terraform apply terraform_plan.tfplan
cd ../AnsibleEPRB
ansible-playbook terraformeRepo.yaml
