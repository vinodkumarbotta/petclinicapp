pipeline {
    agent any

    stages{
        stage("buildApp"){
            steps{
                script {
                    sh """./mvnw package
                         mv ./target/*.war ./target/petApp-${BUILD_NUMBER}.war
                    """
                    
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
                sleep time: 30000, unit: 'MILLISECONDS'
                script {
                        def qg = waitForQualityGate()
                        if (qg.status != 'OK') {
                            error "Pipeline aborted due to quality gate failure: ${qg.status}"
                        }
                }
            }
        }
        // stage("Quality Gate") {
        //     steps {
        //         timeout(time: 3, unit: 'MINUTES') {
        //         waitForQualityGate abortPipeline: true, credentialsId: 'sonartoken'}
        //     }
        // }
        stage("Artifacts"){
             steps {
                     rtUpload (
                    // Obtain an Artifactory server instance, defined in Jenkins --> Manage Jenkins --> Configure System:
                    serverId: "Artifactory-1",
                    spec: """{
                            "files": [
                                    {
                                        "pattern": "./target/*.war",
                                        "target": "petApp/buildResults/"
                                    }
                                ]
                            }"""
                )
               
            }
        }
    }
    post {
        always {
            cleanWs()
        }
    }
}