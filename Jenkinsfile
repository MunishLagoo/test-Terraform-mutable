pipeline {
    agent {label 'WORKSTATION'}
    options {
        ansiColor('xterm')
        disableConcurrentBuilds()
    }
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
