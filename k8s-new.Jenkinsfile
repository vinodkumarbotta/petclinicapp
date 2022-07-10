pipeline {
    agent any
    environment {
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
              docker.withRegistry('184.72.168.66:80', registryCredential ) {
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
        // stage('Deploy on K8S') {
        //  steps {
        //     script {
        //        sh "sed -i 's/petclinicapp:latest/petclinicapp:${env.BUILD_NUMBER}/g' k8s-deployments/petclinicapp-deploy.yaml"
        //        kubernetesDeploy kubeconfigId: 'k8s-config', 
        //        configs: 'k8s-deployments/petclinicapp-deploy.yaml',
        //        enableConfigSubstitution: true

        //     }
        //  }
        // }
        
    }

    post {
        always {
           cleanWs()
        }
    }
}
