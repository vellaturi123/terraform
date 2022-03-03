pipeline {
    agent any

    stages {
        stage('checkout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: '3013f295-9c76-4da0-9bb8-5f478372d5eb', url: 'https://github.com/vellaturi123/terraform.git']]])
            }
        }
        stage('init') {
            steps {
                sh ("terraform init")
            }
        }
        stage('validate'){
          steps{
            sh ("terraform validate")
         }
       }
        stage('plan'){
          steps{
            sh ("terraform plan")
          }
         }
      
    }
}
