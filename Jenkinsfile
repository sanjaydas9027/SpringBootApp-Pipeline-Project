pipeline {
    environment {
        registry = "sanjaydas9027/spring-boot-app1"
        registryCredential = 'DOCKER_CRED'
        DOCKER_IMAGE = "${registry}:${BUILD_NUMBER}"
        SONAR_URL = "http://3.111.119.179:9000/"
    }
    agent any

    stages {
        stage('Unit Test') {
            steps {
                script {
                    sh 'cd spring-boot-app && mvn test'
                }
            }
        }

        stage('Static Code Analysis: SonarQube') {
            steps {
                withCredentials([string(credentialsId: 'sonarqube', variable: 'SONAR_AUTH_TOKEN')]) {
                    sh "cd spring-boot-app && mvn sonar:sonar -Dsonar.login=$SONAR_AUTH_TOKEN -Dsonar.host.url=${SONAR_URL}"
                }
            }
            post {
                always {
                    dir('spring-boot-app/target/sonar') {
                        sh "cat *.txt"
                    }
                }
            }
        }

        stage('Build') {
            steps {
                sh 'cd spring-boot-app && mvn clean package'
            }
        }

        stage('Build and Push Docker Image') {
            steps {
                script {
                    sh "docker build -t ${DOCKER_IMAGE} ."
                    def dockerImage = docker.image(DOCKER_IMAGE)
                    docker.withRegistry('https://registry.hub.docker.com', registryCredential) {
                        dockerImage.push()
                    }
                }
            }
        }
    }
    post {
        always {
            script {
                sh "docker rmi ${DOCKER_IMAGE}"
                sh 'docker logout'
                cleanWs()
            }
        }
    }
}
