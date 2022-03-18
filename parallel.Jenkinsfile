pipeline {
    agent any
        triggers {
       // cron '* * * * *'
        GenericTrigger(
            genericVariables: [
            [key: 'ref', value: '$.ref']
            ],
            causeString: 'Triggered on $ref',
            token: 'abc123',
            tokenCredentialId: '',
            printContributedVariables: true,
            printPostContent: true,
            silentResponse: false,
            regexpFilterText: '$ref',
        )
    }

    stages {
        stage("Compile & Build Binary") {
            parallel {
                stage("Build Linux") {
                   
                    //agent { label 'linux-os1 && linux-os2' }
                    steps{
                        echo "Running Build for Linux"
                        echo " The environment is ${params.PARAMETER_01}"
                    }
                    
                }
                stage("Build Windows") {
                     //agent { label 'windows-os1 && windows-os2' }
                    steps{
                        echo "Running Build for Windows"
                    }
                    
                }
                stage("Build MacOS") {
                    //agent { label 'windows-os1 && windows-os2' }
                    steps{
                        echo "Running Build for MacOS"
                    }
                    
                }
            }
        }

        stage("Code Analysis"){
            steps{
                echo "Running Code Analysis"
            }
        }
    }

    post {
        aborted{
           slackSend channel: '# jenkins-batch3', message: "*ABORTED:* Job ${env.JOB_NAME} build ${env.BUILD_NUMBER} \n More info at: ${env.BUILD_URL}"
        }
        failure {
             slackSend channel: '# jenkins-batch3', message: "*FAILIED:* Job ${env.JOB_NAME} build ${env.BUILD_NUMBER} \n More info at: ${env.BUILD_URL}"
        }
        success{
            slackSend channel: '# jenkins-batch3', message: "*SUCCESS:* Job ${env.JOB_NAME} build ${env.BUILD_NUMBER} \n More info at: ${env.BUILD_URL}"
        }
        always { 
            cleanWs()
        }

    }
}
