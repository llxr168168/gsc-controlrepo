REPO = "gsc"
REPOFULLNAME = "GSC_Controlrepo"
EMAIL_RECIPIENTS = 'matt.cengic@sherwin.com,brian.wagner@sherwin.com,jason.t.pappas@sherwin.com'


SERVER = "cpopupmasp01"
SSH_OPTS = "ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no webdeploy@$SERVER"

node{
  try{
    stage('Checkout SCM'){
      checkout scm
    }
    stage ('Run script'){
        def output = sh returnStdout: true, script: "${SSH_OPTS} sudo /usr/local/sbin/r10kdocker.sh ${REPO}_${env.BRANCH_NAME}"
        println output
    }
    stage ('Run merge script '){ 
        def output = sh returnStdout: true, script: "${SSH_OPTS} sudo /usr/local/sbin/mergecheck.sh ${REPOFULLNAME} ${env.BRANCH_NAME}" 
        println output 
    } 
   stage ('Email success'){
     emailext (
       subject: "R10K BUILD SUCCESS: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
       body: """SUCCESS: Job ${env.JOB_NAME} [${env.BUILD_NUMBER}]  \n\nFeel free to filter me if you don't want to see successes. Check console output at: ${env.BUILD_URL} """,
       recipientProviders: [[$class: 'DevelopersRecipientProvider']],
       to: EMAIL_RECIPIENTS
     )
    }
   }
   catch (Exception e){
     emailext ( 
       subject: "R10K BUILD FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
       body: """FAILED: Job ${env.JOB_NAME} [${env.BUILD_NUMBER}]: ${e}.   \n\nCheck console output at: ${env.BUILD_URL}   """,
       recipientProviders: [[$class: 'DevelopersRecipientProvider']],
       to: EMAIL_RECIPIENTS
     )
     error("Build failed: ${e}")
    }
}
