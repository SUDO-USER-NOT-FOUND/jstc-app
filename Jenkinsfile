pipeline {
  agent { label 'linux' }
  options {
    buildDiscarder(logRotator(numToKeepStr: '5'))
  }
  stages {
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
