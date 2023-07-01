@Library('shared-lib-jenkins') _
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
    }
}
