pipeline {

    agent any

    environment {
        ARM_SUBSCRIPTION_ID = ""
        ARM_CLIENT_ID = ""
        ARM_CLIENT_SECRET = ""
        ARM_TENANT_ID = ""
    }

    stages {

        stage("TF - Build Infra") {
            agent {
                docker {
                    image "adfinissygroup/terraform-azure"
                    args "--entrypoint='' -u root"
                }
            }
            steps {
                withCredentials([azureServicePrincipal('AZURE_TERRAFORM_TEST')]) {
                    sh "az login --service-principal -u ${AZURE_CLIENT_ID} -p ${AZURE_CLIENT_SECRET} --tenant ${AZURE_TENANT_ID}"
                    sh 'chmod +x scripts/tfstate_config.sh'
                    sh 'source scripts/tfstate_config.sh'

                    dir("terraform"){
                        sh "terraform init -no-color"
                        sh "terraform validate -no-color"
                        sh "terraform plan -no-color -var 'subscription_id=${AZURE_SUBSCRIPTION_ID}' -var 'client_id=${AZURE_CLIENT_ID}' -var 'client_secret=${AZURE_CLIENT_SECRET}' -var 'tenant_id=${AZURE_TENANT_ID}'"
                        sh "terraform apply -auto-approve -no-color -var 'subscription_id=${AZURE_SUBSCRIPTION_ID}' -var 'client_id=${AZURE_CLIENT_ID}' -var 'client_secret=${AZURE_CLIENT_SECRET}' -var 'tenant_id=${AZURE_TENANT_ID}'"
                    }
                }
            }
        }
    }
}
