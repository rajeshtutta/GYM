pipeline {
agent any

environment {
    DOCKER_IMAGE = "rajeshtutta123/gym-life"
    AWS_ACCESS_KEY_ID = credentials('aws-creds').username
    AWS_SECRET_ACCESS_KEY = credentials('aws-creds').password
    AWS_DEFAULT_REGION = 'ap-south-1'
}

stages {

    stage('Clone Repository') {
        steps {
            git branch: 'main', url: 'https://github.com/rajeshtutta/GYM.git'
        }
    }

    stage('Build Docker Image') {
        steps {
            sh 'docker build -t $DOCKER_IMAGE:latest .'
        }
    }

    stage('Push Docker Image') {
        steps {
            withCredentials([usernamePassword(credentialsId: 'dockerhub-cred', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                sh 'echo $PASS | docker login -u $USER --password-stdin'
                sh 'docker push $DOCKER_IMAGE:latest'
                sh 'docker logout'
            }
        }
    }

    stage('Deploy to Kubernetes') {
        steps {
            sh 'kubectl apply -f deployment.yml'
            sh 'kubectl apply -f service.yml'
        }
    }
}

}
