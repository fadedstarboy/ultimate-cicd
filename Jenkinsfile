@Library('jenkins-shared-lib') _

pipeline {
    agent any

    parameters {
        choice(name: 'action', choices: 'create\ndelete', description: 'Choose Create or Destroy')
        string(name: 'ImageName', description: "Name of docker build", defaultValue: "javapp")
        string(name: 'ImageTag', description: "Tage of docker build", defaultValue: "v1")
        string(name: 'HubUserName', description: "name of Application", defaultValue: "fadedstarboy")

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

        stage('Unit Test Maven') {
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
        } */

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
        }

    }
}
