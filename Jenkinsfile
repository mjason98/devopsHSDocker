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

        stage("Run k8s"){
            steps{
                withCredentials([file(credentialsId: 'k8s_kube_config', variable: 'KFILE')]) {
                    
                    // delete previous ones
                    
                    sh 'kubectl --kubeconfig ${KFILE} delete service mjapp --ignore-not-found'

                    sh 'kubectl --kubeconfig ${KFILE} delete deployment mjapp --ignore-not-found'

                    // create new ones

                    sh 'kubectl --kubeconfig ${KFILE} create deployment mjapp --image=ttl.sh/mjapp:1h --port 4444'
                    
                    sh 'kubectl --kubeconfig ${KFILE} scale --replicas=2 deployment mjapp'

                    sh 'kubectl --kubeconfig ${KFILE} expose deployment mjapp --type=ClusterIP --port 4444'

                }
            }
        }

        // stage ("Health check"){
        //     steps{
        //         sh 'chmod +x server_check.sh'
        //         sh 'sh server_check.sh'
        //         // sh 'echo $?'
        //     }
        // }
    }
}