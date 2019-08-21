REPO = "gsc"
CONTROLREPO="GSC_controlrepo"
EMAIL_RECIPIENTS = 'matt.cengic@sherwin.com,brian.wagner@sherwin.com,jason.t.pappas@sherwin.com'

node{
  try{
    stage('Checkout SCM'){
      checkout scm
    }
    stage ('Run r10k via ansible'){
      withCredentials([file(credentialsId: 'sa_ansible_ssh_key', variable: 'ANSIBLEKEY')]) {
        sh "cd ansible/; ansible-playbook -u sa-ansible --private-key='${ANSIBLEKEY}' -e 'r10kenv=${REPO}_${env.BRANCH_NAME}' -i inventory.ini runr10k.yml"
      }
    }
    stage ('Run merge via ansible'){
      withCredentials([file(credentialsId: 'sa_ansible_ssh_key', variable: 'ANSIBLEKEY')]) {
        sh "cd ansible/; ansible-playbook -u sa-ansible --private-key='${ANSIBLEKEY}' -e 'controlrepo=${CONTROLREPO} branchname=${env.BRANCH_NAME}' -i inventory.ini promote.yml"
      }
    }
   stage ('Teams success'){
        sh "cd scripts; python post2teams.py 'Success deploying ${env.BUILD_TAG}' 'More info available at link below.'"
    }
   }
   catch (Exception e){
     sh "cd scripts; python post2teams.py 'Error deploying ${env.BUILD_TAG}' 'More info available at link below.'"
     error("Build failed: ${e}")
    }
}
