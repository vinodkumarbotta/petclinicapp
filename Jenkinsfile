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
    }
}