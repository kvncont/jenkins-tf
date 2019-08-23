pipeline {

    agent any

    stages {

        stage('AZ - Login') {
            steps {
                withCredentials([azureServicePrincipal('azure-service-principal')]) {
                    sh "az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET --tenant $AZURE_TENANT_ID"
                }
            }
        }

        stage('TF - Plan'){
            steps {
                sh "terraform init"
                sh "terraform plan"
            }
        }

        stage('TF - Apply'){
            steps {
                sh "terraform apply -auto-approve"
            }
        }

    }
}