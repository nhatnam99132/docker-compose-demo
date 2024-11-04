pipeline {
    agent { label 'docker-agent' }
    stages {
        stage('Clean Workspace') {
            steps {
                cleanWs()
            }
        }
        stage('Check and Stop Existing Containers') {
            steps {
                script {
                    def containerExists = sh(
                        script: "docker ps -q -f 'ancestor=docker-jug-app-reverse-proxy'",
                        returnStdout: true
                    ).trim()

                    if (containerExists) {
                        sh 'docker-compose down'
                    }
                }
            }
        }
        stage('Clone Repository') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], userRemoteConfigs: [[url: 'https://github.com/nhatnam99132/docker-compose-demo.git']]])
            }
        }
        stage('Build Docker Compose') {
            steps {
                script {
                    sh 'docker-compose build'
                }
            }
        }
        stage('Run Docker Compose') {
            steps {
                script {
                    sh 'docker-compose up -d'
                }
            }
        }
        stage('List Running Containers') {
            steps {
                script {
                    sh 'docker ps'
                }
            }
        }
    }
}
