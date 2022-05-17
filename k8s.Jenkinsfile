pipeline {
    agent any
    environment {
            registry = "vsiraparapu/petclinicapp"
            registryCredential = 'venkat-dockerhub'
            dockerImage = ''
    }
    stages{
        stage("buildApp"){
            steps{
                script {
                    sh """./mvnw package
                         mv ./target/*.war ./target/petApp-${BUILD_NUMBER}.war
                         ls -lrt ./target/petApp*.war
                    """
                    
                }
            }
        }
        stage("codeAnalysis"){
            environment {
              def sonarHome = tool name: 'SonarScanner'
            }
            steps {  
                withSonarQubeEnv('k8s-sonarqube') {
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
        stage('Building image') {
            steps{
              script {
                dockerImage = docker.build registry + ":$BUILD_NUMBER"
              }
            }
        }
        stage('Deploy Image') {
          steps{
            script {
              docker.withRegistry( '', registryCredential ) {
                dockerImage.push()
              }
            }
          }
        }
        stage('Remove Old Images') {
          steps{
            sh "docker rmi $registry:$BUILD_NUMBER"
          }
        }
        stage('Deploy on K8S') {
         steps {
            script {
               sh "sed -i 's/petclinicapp:latest/petclinicapp:${env.BUILD_NUMBER}/g' k8s-deployments/petclinicapp-deploy.yaml"
               kubernetesDeploy kubeconfigId: 'k8s-config', 
               configs: 'k8s-deployments/petclinicapp-deploy.yaml',
               enableConfigSubstitution: true

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