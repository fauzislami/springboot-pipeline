pipeline {
    agent any

    tools {
        maven 'maven'
        jdk 'jdk8'
    }

    environment {
        APPLICATION_NAME = "springtest"
        VERSION = "1"
        DOCKER_CREDENTIAL_ID = "docker-creds-id"
    }

    stages {
        stage('Building code') {
            steps {
                sh 'chmod +x testenv.sh'
                sh './testenv.sh'
                sh 'mvn clean compile install'
            }
        }

        stage('Unit testing') {
            steps {
                sh 'mvn test'
            }
            post {
                always {
                     catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                         junit 'target/surefire-reports/*.xml'
                         sh 'mvn package'
                     }
                }
            }
        }

        stage('Build and Push Image ') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io', "$DOCKER_CREDENTIAL_ID") {
                        def customImage = docker.build("docker.io/islamifauzi/$APPLICATION_NAME:$VERSION")
                            customImage.push()

                     }
                }
            }
       }
    }
}
