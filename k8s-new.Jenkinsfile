pipeline {
    agent any
    environment {
            registry_url = "http://184.72.168.66:80"
            registry = "184.72.168.66:80/javaapp/petapp"
            registryCredential = 'venkat-harborhub'
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
              docker.withRegistry(registry_url, registryCredential ) {
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
        stage(" execute Ansible") {
          steps {
                ansiblePlaybook credentialsId: 'ec2-user', disableHostKeyChecking: true, installation: 'Ansible', inventory: 'inventory', playbook: 'k8s-deploy.yaml'
          }    
        }  
        
    }

    post {
        always {
           cleanWs()
        }
    }
}
