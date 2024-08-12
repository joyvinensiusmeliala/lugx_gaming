# lugx_gaming

pipeline {
    agent any 
    
    environment {
        registry = 'joyvinensius/lugx_gaming'
        registryCredential = 'dockerhub_id' // ID credential Docker Hub
        dockerImage = ''
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
    }
}
