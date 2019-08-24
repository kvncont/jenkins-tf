pipeline {

    agent any
    
    environment {
        ARM_SUBSCRIPTION_ID = ""
        ARM_CLIENT_ID = ""
        ARM_CLIENT_SECRET = ""
        ARM_TENANT_ID = ""
    }

    stages {

        stage("AZ - Login SP") {
            agent { docker "microsoft/azure-cli:2.0.61" }
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
                }
            }
        }

        stage("TF - Config"){
            agent {
                docker {
                    image "adfinissygroup/terraform-azure:latest"
                    args "--entrypoint='' -u root -e ARM_SUBSCRIPTION_ID=${ARM_SUBSCRIPTION_ID} -e ARM_CLIENT_ID=${ARM_CLIENT_ID} -e ARM_CLIENT_SECRET=${ARM_CLIENT_SECRET} -e ARM_TENANT_ID=${ARM_TENANT_ID}"
                }
            }
            steps {
                dir("terraform"){
                    sh "terraform init -no-color"
                    sh "terraform validate -no-color"
                    sh "terraform plan -no-color"
                    sh "terraform apply -auto-approve -no-color"
                }
            }
        }
    }
}
