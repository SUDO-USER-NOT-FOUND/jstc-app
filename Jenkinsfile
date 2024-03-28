pipeline {
  agent any
  options {
    buildDiscarder(logRotator(numToKeepStr: '5'))
  }
  stages {
    stage('ls') {
      steps {
        sh 'ls'
      }
    }
    stage('Build') {
      steps {
        sh 'docker build -t assertfinder-scanner:latest .'
        sh 'docker pull aquasec/trivy'
      }
    }
    stage('Scan') {
      steps {
        sh 'docker run aquasec/trivy image assertfinder-scanner:latest'
      }
    }
  }
}
