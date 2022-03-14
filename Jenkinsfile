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
            def sonarHome = tool name: 'SonarScanner', type: 'hudson.plugins.sonar.SonarRunnerInstallation'
            steps{
                script {
                    sh "${sonarHome}/bin/sonar-scanner "
                }
            }
        }
    }
}