pipeline {
    agent {label 'WORKSTATION'}
    environment {
        //ACTION = "apply"
        //ENV = "dev"
        SSH = credentials('CENTOS_SSH')
    }
    parameters {
        choice(name:'ENV', choices: ['dev','prod'])
        //string(name: 'ACTION', defaultValue:'apply',
        //description: 'Give an action to do on terraform')
        choice(name: 'ACTION', choices: ['apply','destroy'])
    }
    options {
        ansiColor('xterm')
      //  disableConcurrentBuilds()
    }
    stages {
        stage ('VPC-Create') {
            when {    
            //     beforeInput true
            //       branch 'production' 
              expression {
                  return ACTION ==~  'apply';
              }
            }
              
            steps {
                sh '''
                cd vpc
                make ${ENV}-${ACTION}
                '''
            }
        }
        stage ('DB & ALB Create') {
            when {
                expression {
                  return ACTION ==~  'apply';
              }
            } 
            parallel {
                stage('DB-Create') {
                //  when {
                //    beforeInput true
                //    branch 'production'
                //  }
                // input {
                //     message "should we continue?"
                //     ok "Yes, we should"
                //     submitter "admin"
                // }
                    steps {
                        sh '''
                        cd db
                        make ${ENV}-${ACTION}
                        '''
                    }
                }
                stage('ALB-Create') {
                   steps {
                        sh '''
                        cd alb
                        make ${ENV}-${ACTION}
                        '''
                    }
                }
            }
       }

            
        stage ('DB & ALB Destroy') {
            when {
                expression {
                  return ACTION ==~  'destroy';
              }
            } 
            parallel {
                stage('DB-Destroy') {
                  steps {
                        sh '''
                        cd db
                        make ${ENV}-${ACTION}
                        '''
                    }
                }
                stage('ALB-Destroy') {
                   steps {
                        sh '''
                        cd alb
                        make ${ENV}-${ACTION}
                        '''
                    }
                }
            }
       }

       stage ('VPC-Destroy') {
            when {    
            //     beforeInput true
                   branch 'production' 
                   expression {
                     return ACTION ==~  'destroy';
                     }
            }
              
            steps {
                sh '''
                cd vpc
                make ${ENV}-${ACTION}
                '''
            }
        }
//Stages
 } 
//Pipeline 
}
