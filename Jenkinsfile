pipeline {
    agent any
    tools {
        jdk 'jdk17'
        nodejs 'node'
        maven 'maven'
    }
    stages {
        stage('clean workspace') {
            steps {
                cleanWs()
            }
        }
        stage('Checkout from Git') {
            steps {
                git branch: 'main', url: 'https://github.com/srikanth-girimaiahgari/DevOps.git'
            }
        }
        stage('Detect Changes') {
            steps {
                script {
                    def changedFiles = sh(
                        script: 'git diff --name-only HEAD~1 HEAD',
                        returnStdout: true
                    ).trim().split('\n')

                    // Set environment variables for detected changes
                    env.project1_CHANGED = changedFiles.any { it.startsWith('project1/') } ? 'true' : 'false'
                    env.project2_CHANGED = changedFiles.any { it.startsWith('project2/') } ? 'true' : 'false'
                }
            }
        }
        stage('Build Project1') {
            when {
                environment name: 'project1_CHANGED', value: 'true'
            }
            steps {
                sh '''
                cd project1
                npm install
                '''
                script {
                    withDockerRegistry(credentialsId: 'docker', toolName: 'docker') {

                        sh '''
                        pwd
                        chmod +x docker_check.sh
                        ./docker_check.sh
                        docker build -t youtube-clone .
                        docker tag youtube-clone sr79979/youtube-clone:latest
                        docker push sr79979/youtube-clone:latest
                        docker run -d --name youtube-clone -p 3000:3000 sr79979/youtube-clone:latest
                        '''
                    }
                }
            }
        }
        stage('Build Project2') {
            when {
                environment name: 'project2_CHANGED', value: 'true'
            }
            steps {

                sh '''
                pwd
                cd project2
                pwd
                ls -l
                mvn clean package
                podman build -t project2 .
                podman run -d -p 3100:8080 localhost/project2:latest
                '''
                // sh 'mvn clean package'
                // // sh 'podman build -t project2 .'
                //sh 'podman run -d -p 3100:8080 localhost/project2:latest"
            }
        }
    }
}
