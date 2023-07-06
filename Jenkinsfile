@Library('jenkins-shared-lib') _

pipeline {
    agent any

    parameters{
        choice(name: 'action', choices: 'create\ndelete', description: 'Choose Create or Destroy')
        string(name: 'ImageName', description: "Name of docker build", defaultValue: "javapp")
        string(name: 'ImageTag', description: "Tage of docker build", defaultValue: "v1")
        string(name: 'HubUserName', description: "DockerHub username", defaultValue: "fadedstarboy")
        string(name: 'Region', description: "Region of EKS", defaultValue: 'us-east-1')
        string(name: "cluster", description: "Name of eks_cluster", defaultValue: 'demo-cluster1')

    }
    environment{
        ACCESS_KEY = credentials('AWS_ACCESS_KEY')
        SECRET_KEY = credentials('AWS_SECRET_KEY')

    }


    stages {
        stage('Git Checkout') {
            when {
                expression {
                    params.action == 'create'
                }
            }
            steps {
                script {
                    gitCheckout(
                        branch: "main",
                        url: "https://github.com/fadedstarboy/ultimate-cicd.git"
                    )
                }
            }
        }

/*         stage('Unit Test Maven') {
            when {
                expression {
                    params.action == 'create'
                }
            }
            steps {
                script {
                    maventest()
                }
            }
        }

        stage('Integration Test Maven') {
            when {
                expression {
                    params.action == 'create'
                }
            }
            steps {
                script {
                    mvnintegration()
                }
            }
        }

        stage('Static Code Analysis Test SonarQube') {
            when {
                expression {
                    params.action == 'create'
                }
            }
            steps {
                script {
                    def creds = 'jenkins-sona'
                    staticcode(creds)
                }
            }
        }

        stage('Maven Build') {
            when {
                expression {
                    params.action == 'create'
                }
            }
            steps {
                script {
                    mvnbuild()
                }
            }
        }

        stage('Docker Image Build') {
            when {
                expression {
                    params.action == 'create'
                }
            }
            steps {
                script {
                    dockerbuild("${params.ImageName}","${params.ImageTag}","${params.HubUserName}")

                }
            }
        }

        /* stage('Docker Image Scan Trivy') {
            when {
                expression {
                    params.action == 'create'
                }
            }
            steps {
                script {
                    dockerimagescan("${params.ImageName}","${params.ImageTag}","${params.HubUserName}")

                }
            }
        }

        stage('Docker Image Push : DockerHub') {
            when {
                expression {
                    params.action == 'create'
                }
            }
            steps {
                script {
                    dockerimagepush("${params.ImageName}","${params.ImageTag}","${params.HubUserName}")

                }
            }
        } */

        stage('Creating EKS CLuster : Terraform') {
            when {
                expression {
                    params.action == 'create'
                }
            }
            steps {
                script {
                    dir('eks_mod'){
                        sh """
                        terraform init
                        terraform plan -var 'access_key=$ACCESS_KEY' -var 'secret_key=$SECRET_KEY' -var 'region=${params.Region}' --var-file="./config/terraform.tfvars"
                        terraform apply -var 'access_key=$ACCESS_KEY' -var 'secret_key=$SECRET_KEY' -var 'region=${params.Region}' --var-file="./config/terraform.tfvars" -auto-approve                      
                        """
                    }
                    
                }
            }
        }

        stage('Connect to EKS') {
            when {
                expression {
                    params.action == 'create'
                }
            }
            steps {
                script {
                    dir('eks_mod'){
                        sh """
                        aws configure set aws_access_key_id $ACCESS_KEY 
                        aws configure set aws_secret_access_key $SECRET_KEY
                        aws configure set region ${params.Region}
                        aws eks --region ${params.Region} update-kubeconfig --name ${params.cluster}
                        """
                    }
                    
                }
            }
        }

        stage('Deployment on EKS') {
            when {
                expression {
                    params.action == 'create'
                }
            }
            steps {
                script {
                    def appply = false
                    try{
                        input message: 'Please confirm if you want to deploy on EKS', ok: 'Yes, proceed'
                        apply = true
                    }
                    catch(err){
                        apply = false
                        currentBuild.result = 'UNSTABLE'
                    }
                    if(apply){
                        sh """
                        kubectl apply -f .
                        """
                    }

                }
            }
        }




        

    }
}
