pipeline {
    agent {label 'WORKSTATION'}
    environment {
        ACTION = "apply"
        ENV = "dev"
        SSH = credentials('centos_ssh')
    }
    parameters {
        choice(name:'ENV', choices: ['dev','prod'])
        string(name: 'ACTION', defaultValue:'apply',
        description: 'Give an action to do on terraform')
    }
    options {
        ansiColor('xterm')
        disableConcurrentBuilds()
    }
    stages {
        stage ('VPC') {
            steps {
                sh '''
                cd vpc
                make dev-${ACTION}
                '''
            }
        }
    }
}
