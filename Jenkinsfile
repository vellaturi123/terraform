pipeline {
    agent any

    stages {
        stage('init') {
            steps {
                sh 'terraform init'
            }
        }
        stage('validate'){
          steps{
            sh 'terraform validate'
         }
       }
        stage('plan'){
          steps{
            sh 'terraform plan'
          }
         }
      
    }
}
