node{
    stage('Clean up Workspace')
    {
      deleteDir()
    }
    stage ('Checkout'){
           checkout scm
    }
    stage('Build Docker Image'){
       sh"ls;docker build -t src ."
    }
}