pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/Gnarga/trialanderror.git'
            }
        }
        stage('JUnit Build') {
             steps {
                sh "mvn -B compile"
             }
        }

        stage('JUnit Test') {
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
		archiveArtifacts artifacts: '**/*.jar', fingerprint: true
                    junit '**/TEST*.xml'
                }
            }
        }
       
        stage('Newman Postman') {
            steps {
                sh 'newman run "RestfulBooker.postman_collection.json" --environment "RestfulBooker.postman_environment.json" --reporters cli,junit'
             }
            post {
                    always {
				archive "target/site/cobertura"
                       junit 'target/site/cobertura/coverage.xml'
                            
                    }
             }
         }

        stage('Robot Selenium') {
             steps {
        	sh 'robot -d results --include LOGIN_01 --variable BROWSER:headlesschrome Rental.robot'}
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
            step([$class: 'CoberturaPublisher', autoUpdateHealth: false, autoUpdateStability: false, coberturaReportFile: '**/coverage.xml', failUnhealthy: false, failUnstable: false, maxNumberOfBuilds: 0, onlyStable: false, sourceEncoding: 'ASCII', zoomCoverageChart: false])
   
            junit '**/*.xml'

        }
    }
}