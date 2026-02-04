pipeline {
  agent any

  environment {
    IMAGE = "lakshmisrinath/trend-react-app:${BUILD_NUMBER}"
  }

  stages {

    stage('Checkout') {
      steps {
        git branch: 'main',
            url: 'https://github.com/SubanalakshmiJS/trend-react-app.git'
      }
    }

    stage('Docker Build') {
      steps {
        sh 'docker build -t $IMAGE .'
      }
    }

    stage('Docker Push') {
      steps {
        withCredentials([usernamePassword(
          credentialsId: 'de4476d3-4b15-4774-8283-02be6cfd48ab',
          usernameVariable: 'DOCKER_USER',
          passwordVariable: 'DOCKER_PASS'
        )]) {
          sh '''
            echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
            docker push $IMAGE
            docker logout
          '''
        }
      }
    }

    stage('Deploy to EKS') {
      steps {
        sh 'kubectl set image deployment/trend-react trend-react=$IMAGE'
      }
    }
  }
}
