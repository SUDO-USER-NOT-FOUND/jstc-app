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
        stage('Build and Scan') {
            steps {
                script {
                    // Check if Dockerfile exists in the repository
                    def dockerfileExists = sh(script: "git ls-files | grep -q 'Dockerfile'", returnStatus: true) == 0

                    if (dockerfileExists) {
                        // Task 1: Build the Docker image if Dockerfile exists
                        echo "Dockerfile exists in the repository. Building the Docker image..."
                        sh 'docker build -t assertfinder-scanner:latest .'
                        
                        // Task 2: Scan the built Docker image using Trivy
                        echo "Scanning Docker image using Trivy..."
                        sh 'docker pull aquasec/trivy'
                        sh 'docker run -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy image assertfinder-scanner:latest'
                    } else {
                        // Task 2: Perform action if Dockerfile does not exist
                        echo "Dockerfile does not exist in the repository. Skipping Docker image build and scan..."
                        // Perform any alternative tasks here
                    }
                }
            }
        }
    }
}
