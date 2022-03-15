pipeline {
    agent any

    stages{
        stage("buildApp"){
            steps{
                script {
                    sh "./mvnw package"
                    
                }
            }
        }
        stage("codeAnalysis"){
            environment {
              def sonarHome = tool name: 'SonarScanner'
            }
            steps{
                script {
                    sh "${sonarHome}/bin/sonar-scanner "
                }
            }
        }
        stage("checkQualityGate"){
            steps{
                script {
                    echo "Checking QG"
                }
            }
        }
        stage("Artifacts"){
            steps{
                script {
                    echo "pushing to Artifactory"
                }
            }
        }
    }
}