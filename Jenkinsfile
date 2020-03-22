pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
		sh java --version
                git 'https://github.com/Gnarga/trialanderror'
            }
        }
        stage('junit build') {
                steps {
                    sh "mvn -B compile"
                }
        }

        stage('junit test') {
            steps {
                sh "mvn -B test" 
            }
        }

	stage('Cobertura coverage') {
            steps {
                sh "mvn -B cobertura:cobertura"
            }
	     post {
                always {
                    
		    cobertura coberturaReportFile: '**/coverage.xml'
                }
            }
        }

        stage('newman') {
            steps {
                sh 'newman run "RestfulBooker.postman_collection.json" --environment "RestfulBooker.postman_environment.json" --reporters cli,junit'
            }
            post {
                always {
                        junit '**/*xml'
                    }
                }
        }
        stage('robot') {
            steps {
                    sh 'robot -d results --include LOGIN_01 --variable BROWSER:headlesschrome Rental.robot'
            }
            post {
                always {
                    script {
                          step(
                                [
                                  $class              : 'RobotPublisher',
                                  outputPath          : 'results',
                                  outputFileName      : '**/output.xml',
                                  reportFileName      : '**/report.html',
                                  logFileName         : '**/log.html',
                                  disableArchiveOutput: false,
                                  passThreshold       : 50,
                                  unstableThreshold   : 40,
                                  otherFiles          : "**/*.png,**/*.jpg",
                                ]
                           )
                    }
                }
            }
        }
    }
       post {
        always {
		junit '**/TEST*.xml'
                junit '**/*xml'
        	}
    }
}