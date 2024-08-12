pipeline {
    agent any 

    environment {
        registry = 'joyvinensius/lugx_gaming'
        registryCredential = 'dockerhub_id' // ID credential Docker Hub
        dockerImage = ''
        KUBERNETES_NAMESPACE = 'lugx-gaming'
        KUBERNETES_CREDENTIAL_ID = 'kubernetes' // ID credential Kubernetes yang disimpan
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
                    // Menggunakan credential Kubernetes secara langsung
                    withKubeConfig([credentialsId: "${KUBERNETES_CREDENTIAL_ID}"]) {
                        // Set the current context's namespace
                        sh "kubectl config set-context --current --namespace=${KUBERNETES_NAMESPACE}"
                        
                        // Cek jika namespace ada, jika tidak, buat namespace
                        sh """
                        if ! kubectl get namespace ${KUBERNETES_NAMESPACE} > /dev/null 2>&1; then
                            kubectl create namespace ${KUBERNETES_NAMESPACE}
                        fi
                        """
                        
                        // Deploy the application by replacing the BUILD_NUMBER and applying the YAML
                        sh "sed 's|{{BUILD_NUMBER}}|${env.BUILD_NUMBER}|g' \"${WORKSPACE}/kubernetes/deployment.yaml\" | kubectl apply -f - --namespace=${KUBERNETES_NAMESPACE}"
                        
                        // Apply the service configuration
                        sh "kubectl apply -f \"${WORKSPACE}/kubernetes/service.yaml\" --namespace=${KUBERNETES_NAMESPACE}"
                    }
                }
            }
        }
    }
}
