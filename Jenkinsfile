pipeline {
    agent any

    parameters {
        choice(name: 'ACTION', choices: ['apply', 'destroy'], description: 'Choose the action to perform')
        string(name: 'ENVIRONMENT', defaultValue: 'dev', description: 'Specify the environment (e.g., dev, staging, prod)')
    }

    environment {
        TERRAFORM_DIR = 'eks-infra-code'
    }

    stages {
        stage('code checkout') {
            steps {
                checkout scm
            }
        }
    }

    post { 
        success {
            echo "Succeeded"
        }

        failure {
            echo "Failed"
        }

        unstable { 
            echo "Unstable"
        }
        always { 
            cleanWs()
        }
    }
}