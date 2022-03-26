node{
    stage('Clean up Workspace')
    {
      deleteDir()
      sh "docker stop myapp;docker rm myapp;docker rmi src:latest"
    }
    stage ('Checkout'){
           checkout scm
    }
    stage('Build Docker Image'){
       sh"docker build -t src ."
    }
    stage("Test New Image"){
    sh "docker run -d -p 8083:80 --name myapp src"
    sh 'wget localhost:8083 && echo "WE GOT IT" || echo "Failure"'
    }
}