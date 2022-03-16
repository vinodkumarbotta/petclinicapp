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
            steps {  
                withSonarQubeEnv('sonarQubeServer') {
                    sh "${sonarHome}/bin/sonar-scanner"
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
        stage("Deploy-Test"){
          
            steps {
                sshagent(credentials: ['aws-tomcat-creds']) {
                    script {
                         sh """                    
                           scp -o StrictHostKeyChecking=no ./target/*.war 13.235.246.230:/opt/tomcat/webapps
                        """
                    }
                       
                }
            }
        }
        stage("Deploy-UAT"){
            steps{
                script {
                    sh "Deploying to Test Environment"
                    
                }
            }
        }
        stage("Deploy-PRD"){
            input{
                 message "Do you want to proceed for production deployment?"
            }
            steps{
                script {
                    sh "Deploying to Test Environment"
                    
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}