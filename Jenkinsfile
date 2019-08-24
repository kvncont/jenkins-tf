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
                withCredentials([azureServicePrincipal(credentialsId: "AZURE_TERRAFORM_TEST",
                                    subscriptionIdVariable: "SUBS_ID",
                                    clientIdVariable: "CLIENT_ID",
                                    clientSecretVariable: "CLIENT_SECRET",
                                    tenantIdVariable: "TENANT_ID")]) {
                    script {
                        ARM_SUBSCRIPTION_ID = env.SUBS_ID
                        ARM_CLIENT_ID = env.CLIENT_ID
                        ARM_CLIENT_SECRET = env.CLIENT_SECRET
                        ARM_TENANT_ID = env.TENANT_ID 
                    }
                    sh "az login --service-principal -u ${ARM_CLIENT_ID} -p ${ARM_CLIENT_SECRET} --tenant ${ARM_TENANT_ID}"
                    dir("terraform"){
                        sh "terraform init -no-color"
                        sh "terraform validate -no-color"
                        sh "terraform plan -no-color -var 'subscription_id=${ARM_SUBSCRIPTION_ID}' -var 'client_id=${ARM_CLIENT_ID}' -var 'client_secret=${ARM_CLIENT_SECRET}' -var 'tenant_id=${ARM_TENANT_ID}'"
                        sh "terraform apply -auto-approve -no-color -var 'subscription_id=${ARM_SUBSCRIPTION_ID}' -var 'client_id=${ARM_CLIENT_ID}' -var 'client_secret=${ARM_CLIENT_SECRET}' -var 'tenant_id=${ARM_TENANT_ID}'"
                    }
                }
            }
        }
    }
}
