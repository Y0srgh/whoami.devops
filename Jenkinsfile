pipeline {
    agent any

    environment {
        IMAGE_NAME = 'y0srgh/whoami.dev:latest'
        DOCKER_CREDENTIALS_ID = 'dockerhub-credentials'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'master', url: 'https://github.com/Y0srgh/whoami.dev.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME .'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withDockerRegistry([credentialsId: DOCKER_CREDENTIALS_ID, url: '']) {
                    sh "docker push $IMAGE_NAME"
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sshagent (credentials: ['jenkins-ssh-key']) {
                    sh 'ssh -o StrictHostKeyChecking=no vagrant@192.168.56.11 "ansible-playbook -i ansible/inventory ansible/deploy.yml"'                    
                }
            }
        }
    }
}