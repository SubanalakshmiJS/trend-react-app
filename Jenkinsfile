pipeline {
  agent any

  environment {
    IMAGE = "lakshmisrinath/trend-react-app:${BUILD_NUMBER}"
  }

  stages {
    stage('Checkout') {
      steps {
        git 'https://github.com/SubanalakshmiJS/trend-react-app.git'
      }
    }

    stage('Docker Build') {
      steps {
        sh 'docker build -t $IMAGE .'
      }
    }

    stage('Docker Push') {
      steps {
        sh 'docker push $IMAGE'
      }
    }

    stage('Deploy') {
      steps {
        sh 'kubectl set image deployment/trend-react trend-react=$IMAGE'
      }
    }
  }
}
