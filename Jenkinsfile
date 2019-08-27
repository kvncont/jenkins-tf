pipeline {

    agent any

    stages {

        stage("Terraform - Build Infrastructure") {
            agent {
                docker {
                    image "adfinissygroup/terraform-azure"
                    args "--entrypoint='' -u root"
                }
            }
            steps {
                withCredentials([azureServicePrincipal('AZURE_TERRAFORM_TEST'), azureStorage('TFSTATE')]) {
                    dir("terraform"){
                        sh '''
                            terraform init -no-color \
                            -var "subscription_id=${AZURE_SUBSCRIPTION_ID}" \
                            -var "client_id=${AZURE_CLIENT_ID}" \
                            -var "client_secret=${AZURE_CLIENT_SECRET}" \
                            -var "tenant_id=${AZURE_TENANT_ID}" \
                            -backend-config "access_key=${AZURE_STORAGE_ACCOUNT_KEY}"
                        '''
                        sh "terraform validate -no-color"

                        sh '''
                            terraform plan -no-color \
                            -var "subscription_id=${AZURE_SUBSCRIPTION_ID}" \
                            -var "client_id=${AZURE_CLIENT_ID}" \
                            -var "client_secret=${AZURE_CLIENT_SECRET}" \
                            -var "tenant_id=${AZURE_TENANT_ID}"
                        '''

                        sh '''
                            terraform apply -auto-approve -no-color \
                            -var "subscription_id=${AZURE_SUBSCRIPTION_ID}" \
                            -var "client_id=${AZURE_CLIENT_ID}" \
                            -var "client_secret=${AZURE_CLIENT_SECRET}" \
                            -var "tenant_id=${AZURE_TENANT_ID}"
                        '''
                    }
                }
            }
        }
    }
}
