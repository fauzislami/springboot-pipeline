pipeline {
    agent any

    tools {
        maven 'maven'
        jdk 'jdk8'
    }

    environment {
        APPLICATION_NAME = "springtest"
        VERSION = "1.1"
        DOCKER_CREDENTIAL_ID = "docker-creds-id"
        APP_MANIFEST_DIR = "argocd-springtest"
        APP_MANIFEST_REPO = "https://github.com/fauzislami/argocd-springtest.git"
        GIT_USERNAME = "islamifauzi"
        GIT_PASSWD = credentials ('git-passwd')
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
                    docker.withRegistry('https://registry-1.docker.io/v2/', "$DOCKER_CREDENTIAL_ID") {
                        def customImage = docker.build("islamifauzi/$APPLICATION_NAME:$VERSION")
                            customImage.push()

                     }
                }
            }
       }

       stage('Modify manifest') {
           steps {
               sh '''
               rm -rf $APP_MANIFEST_DIR
               git config --global user.email "islamifauzi@gmail.com"
               git config --global user.name "islamifauzi"
               git config --global http.sslVerify false
               git clone $APP_MANIFEST_REPO
               cd $APP_MANIFEST_DIR
               sed -E -i -e 's%(islamifauzi/springtest:).*%\1'"${VERSION}"'%' springtest-deployment.yml
               git add .
               git commit -m "update version to $VERSION"
               git push https://${GIT_USERNAME}:${GIT_PASSWD}@github.com/fauzislami/argocd-springtest.git
               '''


           }
       }
    }
}
