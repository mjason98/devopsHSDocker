pipeline {
    agent any

    tools {
        go 'go_config_1204'
    }

    stages {
        stage("Test"){
            steps{
                sh 'go test .'
            }
        }

        stage("Build"){
            steps{
                sh 'go version'
                sh 'go build main.go'
                archiveArtifacts artifacts: 'main', followSymlinks: false
            }
        }

        stage("Build Docker Container"){
            steps{
                sh 'docker build . --tag ttl.sh/mjapp:1h'
            }
        }

        stage("Push Docker Container"){
            steps{
                sh 'docker push ttl.sh/mjapp:1h'
            }
        }

        stage("Pull Docker image"){
            steps{
                withCredentials([sshUserPrivateKey(credentialsId: 'target_cred', keyFileVariable: 'KEY_FILE', passphraseVariable: 'PASSF', usernameVariable: 'USERNAME')]) {
                    // some block
                    sh 'ssh-keyscan 192.168.105.3 > ~/.ssh/known_hosts'
                    
                    sh "ssh -l ${USERNAME} -i ${KEY_FILE} 192.168.105.3 -C docker pull ttl.sh/mjapp:1h"
                }
            }
        }

        stage("Run Docker image"){
            steps{
                withCredentials([sshUserPrivateKey(credentialsId: 'target_cred', keyFileVariable: 'KEY_FILE', passphraseVariable: 'PASSF', usernameVariable: 'USERNAME')]) {
                    // some block
                    sh 'ssh-keyscan 192.168.105.3 > ~/.ssh/known_hosts'
                    
                    // stop the previus image
                    sh "ssh -l ${USERNAME} -i ${KEY_FILE} 192.168.105.3 -C docker rm --force mj_app"

                    sh "ssh -l ${USERNAME} -i ${KEY_FILE} 192.168.105.3 -C docker run --detach --publish 4444:4444 --name mj_app ttl.sh/mjapp:1h"
                }
            }
        }

        stage ("Health check"){
            steps{
                // jenmins can detect if its not 0
                sh "curl -s 192.168.105.3:4444/api"
            }
        }
    }
}