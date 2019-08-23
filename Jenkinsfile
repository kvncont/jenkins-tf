pipeline {

    agent none

    environment {
        ARM_CLIENT_ID = ''
        ARM_CLIENT_SECRET = ''
        ARM_SUBSCRIPTION_ID = ''
        ARM_TENANT_ID = ''
    }

    stages {

        stage('AZ - Login') {
            agent { docker 'microsoft/azure-cli:2.0.61' }
            steps {
                withCredentials([azureServicePrincipal('AZURE_TERRAFORM_TEST')]) {
                    sh "az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET --tenant $AZURE_TENANT_ID"
                }
            }
        }

        stage('TF - Config'){
            agent {
                docker {
                    image 'hashicorp/terraform'
                    args '--entrypoint="" -u root'
                }
            }
            steps {
                dir('terraform') {
                    sh "terraform -v"
                    sh "terraform plan terraform/"
                }
            }
        }

        // stage('TF - Apply'){
        //     agent { docker 'hashicorp/terraform' }
        //     steps {
        //         sh "terraform apply -auto-approve"
        //     }
        // }

    }
}