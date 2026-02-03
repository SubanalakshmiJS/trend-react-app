pipeline {
  agent any
  stages {
    stage('Clone') {
      steps {
        git 'https://github.com/Vennilavan12/Trend.git'
      }
    }
    stage('Build Image') {
      steps {
        sh 'docker build -t lakshmisrinath/trend-react-app .'
      }
    }
    stage('Push Image') {
      steps {
        sh 'docker push lakshmisrinath/trend-react-app'
      }
    }
    stage('Deploy to EKS') {
      steps {
        sh 'kubectl apply -f deployment.yaml'
        sh 'kubectl apply -f service.yaml'
      }
    }
  }
}
