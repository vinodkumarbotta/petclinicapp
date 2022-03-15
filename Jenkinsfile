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
             steps {
                rtUpload (
                    // Obtain an Artifactory server instance, defined in Jenkins --> Manage Jenkins --> Configure System:
                    serverId: Artifactory-1,
                    spec: """{
                            "files": [
                                    {
                                        "pattern": "./target/*.war",
                                        "target": "petApp/buildResults"
                                    }
                                ]
                            }"""
                )
            }
        }
    }
}