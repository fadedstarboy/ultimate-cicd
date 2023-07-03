@Library('jenkins-shared-lib') _

pipeline {
    agent any

    parameters {
        choice(name: 'action', choices: 'create\ndelete', description: 'Choose Create or Destroy')
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

    }
}
