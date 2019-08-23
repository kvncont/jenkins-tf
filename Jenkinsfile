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

        // stage('TF - Plan'){
        //     agent { docker 'hashicorp/terraform' }
        //     steps {
        //         sh "terraform init"
        //         sh "terraform plan"
        //     }
        // }

        // stage('TF - Apply'){
        //     agent { docker 'hashicorp/terraform' }
        //     steps {
        //         sh "terraform apply -auto-approve"
        //     }
        // }

    }
}