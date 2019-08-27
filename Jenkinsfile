pipeline {

    agent any

    environment {
        ARM_ACCESS_KEY = ""
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
                    sh "chmod +x scripts/tfstate_config.sh"
                    sh "source scripts/tfstate_config.sh"
                    script {
                        env.ARM_ACCESS_KEY = readFile 'access_key.txt'
                    }
                    echo env.ARM_ACCESS_KEY
                    // sh "rm access_key.txt"
                    //sh "export ARM_ACCESS_KEY=${ARM_ACCESS_KEY}"
                    dir("terraform"){
                        sh "printenv | sort"
                        sh '''
                            terraform init -no-color \
                            -var "subscription_id=${AZURE_SUBSCRIPTION_ID}" \
                            -var "client_id=${AZURE_CLIENT_ID}" \
                            -var "client_secret=${AZURE_CLIENT_SECRET}" \
                            -var "tenant_id=${AZURE_TENANT_ID}"
                        '''
                        sh "terraform validate -no-color"
                        sh "terraform plan -no-color -var 'subscription_id=${AZURE_SUBSCRIPTION_ID}' -var 'client_id=${AZURE_CLIENT_ID}' -var 'client_secret=${AZURE_CLIENT_SECRET}' -var 'tenant_id=${AZURE_TENANT_ID}'"
                        sh "terraform apply -auto-approve -no-color -var 'subscription_id=${AZURE_SUBSCRIPTION_ID}' -var 'client_id=${AZURE_CLIENT_ID}' -var 'client_secret=${AZURE_CLIENT_SECRET}' -var 'tenant_id=${AZURE_TENANT_ID}'"
                    }
                }
            }
        }
    }
}
