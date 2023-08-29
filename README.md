# Spring Boot App CI Pipeline Project

This repository contains the Jenkins pipeline script and configuration for a Spring Boot application's Continuous Integration (CI) pipeline. The pipeline performs various tasks, including unit testing, static code analysis using SonarQube, building the application, and creating/pushing a Docker image.

## Pipeline Overview

The Jenkins pipeline defined in the `Jenkinsfile` carries out the following stages:

1. **Checkout**: Declarative step to checkout the code from the repository.

2. **Unit Test**: This stage runs the unit tests for the Spring Boot application using Maven.

3. **Static Code Analysis: SonarQube**: In this stage, the pipeline performs static code analysis using SonarQube. It uses the provided SonarQube authentication token to authenticate with the SonarQube server. The results of the analysis are displayed in the console and saved as text files in the `spring-boot-app/target/sonar` directory.

4. **Build**: This stage cleans and packages the Spring Boot application using Maven.

5. **Build and Push Docker Image**: In this stage, a Docker image for the Spring Boot application is built and pushed to a Docker registry. The image tag includes the build number for versioning.

6. **Post Pipeline Cleanup**: After completing the pipeline stages, this post-build script cleans up Docker images, logs out from the Docker registry, and cleans the workspace.

## Pipeline Configuration

- **Registry**: The Docker registry where the Docker image is pushed is defined as `registry` in the pipeline's environment. You need to replace `"sanjaydas9027/spring-boot-app1"` with your Docker registry.

- **Docker Registry Credentials**: The credentials for the Docker registry are stored with the ID `"DOCKER_CRED"`. Update it with your Docker credentials ID.

- **SonarQube Configuration**: The SonarQube URL is set as `SONAR_URL`. Update `"<sonarqube_ip>"` with your SonarQube server URL.

- **SonarQube Authentication Token**: The SonarQube authentication token is read from a Jenkins credential with the ID `"sonarqube"`.

![Project Screenshot](https://github.com/sanjaydas9027/project1/raw/master/Screenshot%20(99).png)

## Running the Pipeline

This project uses a declarative pipeline defined in the `Jenkinsfile`. To run the pipeline, follow these steps:

1. Configure Jenkins to use this repository and the `Jenkinsfile` for the pipeline definition.

2. Set up the necessary environment variables:

   - **Registry**: Define the Docker registry where the Docker image will be pushed as `registry`. Replace `"your-registry/your-spring-app"` with your Docker registry and application name.
   
   - **Docker Registry Credentials**: Store the Docker registry credentials in Jenkins with the ID `"DOCKER_CRED"`.

3. **GitHub Webhook Setup**: To trigger the pipeline on code push, set up a GitHub webhook:

   - Navigate to your GitHub repository.
   - Go to "Settings" > "Webhooks" > "Add webhook".
   - Set the Payload URL to your Jenkins server's URL with the path `/github-webhook/`.
   - Choose "Content type" as "application/json".
   - Select "Just the push event".
   - Add a secret for added security (optional).
   - Save the webhook.

   Now, whenever you push code changes to the repository, the Jenkins pipeline will automatically trigger.

## Setting Up SonarQube

```bash
sudo su
apt install unzip
adduser sonarqube
wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.4.0.54424.zip
unzip *
chmod -R 755 /home/sonarqube/sonarqube-9.4.0.54424
chown -R sonarqube:sonarqube /home/sonarqube/sonarqube-9.4.0.54424
cd sonarqube-9.4.0.54424/bin/linux-x86-64/
./sonar.sh start
```

## Install Java
```bash
sudo apt update
sudo apt install openjdk-11-jre
java -version

```


## Install Jenkins
```bash
curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins

```


## Install Docker

```bash
sudo apt update
sudo apt install docker.io

# Grant Jenkins user and Ubuntu user permission to docker daemon
sudo su -
usermod -aG docker jenkins
usermod -aG docker ubuntu
systemctl restart docker

```

