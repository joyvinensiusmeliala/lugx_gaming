pipeline {
    agent any 

    environment {
        registry = 'joyvinensius/lugx_gaming'
        registryCredential = 'dockerhub_id' // ID credential Docker Hub
        dockerImage = ''
        KUBERNETES_NAMESPACE = 'lugx-gaming'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/joyvinensiusmeliala/lugx_gaming']])
            }
        }

        stage('Build Docker image') {
            steps {
                script {
                    dockerImage = docker.build(registry)
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('', registryCredential) {
                        dockerImage.push('latest')
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    // Menggunakan kredensial kubeconfig
                    withKubeConfig(credentialsId: 'kubernetes_k3s_master') {
                        // Deploy aplikasi dari direktori Jenkins
                        sh "sed 's|{{BUILD_NUMBER}}|${env.BUILD_NUMBER}|g' ${WORKSPACE}/kubernetes/deployment.yaml | kubectl apply -f - --namespace=${KUBERNETES_NAMESPACE}"
                        // Terapkan LoadBalancer service dari direktori Jenkins
                        sh "kubectl apply -f ${WORKSPACE}/kubernetes/service.yaml --namespace=${KUBERNETES_NAMESPACE}"
                    }
                }
            }
        }
    }
}
