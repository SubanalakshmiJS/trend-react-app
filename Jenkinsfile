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
          credentialsId: 'dockerhub-creds',
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
	  stage('Configure Kubeconfig') {
    steps {
        withCredentials([[
            $class: 'AmazonWebServicesCredentialsBinding',
            credentialsId: 'aws-jenkins-creds'
        ]]) {
            sh '''
                aws eks update-kubeconfig --region ap-south-1 --name trend-cluster-v2 
				kubectl set image deployment/trend-app trend=$IMAGE
     			kubectl rollout status deployment/trend-app
            '''
        }
    }
}

  }
}
