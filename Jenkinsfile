pipeline {
    agent {label 'WORKSTATION'}
    stages {
        stage ('VPC') {
            steps {
                sh '''
                cd vpc; make dev-apply
                '''
            }
        }
    }
}
