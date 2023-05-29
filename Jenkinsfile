pipeline {
    agent any

    stages {
        stage("Install dependecies"){
            steps{
                sh 'pip3 install -r requirements.txt'
            }
        }

        stage("Test"){
            steps{
                sh 'python3 -m pytest .'
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
                sh 'echo $?'
                sh "curl -s 192.168.105.3:4444/api"
                sh 'echo $?'
            }
        }
    }
}