pipeline {

    agent none

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
                docker 'hashicorp/terraform'
                args '-v terraform/:/terraform --entrypoint=validate /terraform/main.tf'
            }
            steps {
                // sh "terraform init"
                // sh "terraform plan"
                // sh "terraform apply -auto-approve"
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