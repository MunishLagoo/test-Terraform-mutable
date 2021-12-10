pipeline {
    agent {label 'WORKSTATION'}
    environment {
        ACTION = "apply"
        ENV = "dev"
        SSH = credentials('CENTOS_SSH')
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
            when {
                branch 'production'
            }
            steps {
                sh '''
                cd vpc
                make ${ENV}-${ACTION}
                '''
            }
        }
        stage ('DB & ALB') {
            parallel {
                stage('DB') {
                    when {
                        beforeInput true
                        branch 'production'
                    }
                    input {
                        message "should we continue?"
                        ok "Yes, we should"
                        submitter "admin"
                    }
                    steps {
                        sh '''
                        cd db
                        make ${ENV}-${ACTION}
                        '''
                    }
                }
                stage('ALB') {
                    steps {
                        sh '''
                        cd alb
                        make ${ENV}-${ACTION}
                        '''
                    }
                }
            }
        }
    }
}
