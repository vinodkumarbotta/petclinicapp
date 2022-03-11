pipeline {

    agent any

    stages{

        stage("buildApp"){
            steps{
                script {
                    sh "./mvnw jetty:run-wa"
                    
                }
            }
        }
    }
}