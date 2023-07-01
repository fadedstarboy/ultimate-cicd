@Library('jenkins-shared-lib') _
pipeline {
    agent any

    stages {
        stage('Git Checkout') {
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
            steps {
                script {
                    maventest()
                    
                }
            }
        }

        stage('Integration Test Maven') {
            steps {
                script {
                    mvnintegration()
                    
                }
            }
        }
    }
}
