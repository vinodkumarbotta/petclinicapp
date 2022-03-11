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
            steps{
                script {
                    sh "/opt/sonar/bin/sonar-scanner "
                }
            }
        }
    }
}