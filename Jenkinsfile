@Library('jenkins-shared-lib') _
pipeline {
    agent any
    parameters{
        choiceName: 'action',choices: 'create\ndelete', description: 'Choose Create or Destroy'
    }

    stages {
        

        stage('Git Checkout') {
            when{
            expression{
                param.action == 'create'
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
            when{
            expression{
                param.action == 'create'
            }
        }
            steps {
                script {
                    maventest()
                    
                }
            }
        }

        stage('Integration Test Maven') {
            when{
            expression{
                param.action == 'create'
            }
        }
            steps {
                script {
                    mvnintegration()
                    
                }
            }
        }
    }
}
