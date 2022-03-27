// node{
//     stage('Clean up Workspace')
//     {
//       deleteDir()
//       sh "docker stop myapp;docker rm myapp;docker rmi src:latest"
//     }
//     stage ('Checkout'){
//            checkout scm
//     }
//     stage('Build Docker Image'){
//        sh"docker build -t src ."
//     }
//     stage("Test New Image"){
//     sh "docker run -d -p 8083:80 --name myapp src"
//     sh 'wget localhost:8083 && echo "WE GOT IT" || echo "Failure"'
//     }
// }


def artifactory = Artifactory.server('artifactory')

pipeline {
    agent any
    stages {
         stage('Clean up Workspace'){
                  steps {
                     deleteDir()
                     sh "docker stop myapp;docker rm myapp;docker rmi src:latest"
                  }

         }
       stage ('Checkout'){
          steps{
            checkout scm
          }

        }
        stage ('Artifactory configuration') {
            steps {
                rtServer (
                    id: "artifactory"
                )
            }
        }

        stage('Build') {
            steps {
                sh"docker build -t src ."
                sh "docker build . -t   artifactory/example-repo-local:$currentBuild.number"
            }
        }

        stage ('Push image to Artifactory') {
            steps {
                script {
                    def rtDocker = Artifactory.docker server: artifactory
                    def dockerBuildInfo1 = rtDocker.push("artifactory/example-repo-local:$currentBuild.number", "docker-repo")
                }
            }
        }
    }
}