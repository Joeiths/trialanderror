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
        }
       
        stage('Newman Postman') {
            steps {
                sh 'newman run "RestfulBooker.postman_collection.json" --environment "RestfulBooker.postman_environment.json" --reporters cli,junit'
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
            cobertura autoUpdateHealth: false, autoUpdateStability: false, coberturaReportFile: '**/target/site/cobertura/coverage.xml', conditionalCoverageTargets: '70, 0, 0', enableNewApi: true, failUnhealthy: false, failUnstable: false, lineCoverageTargets: '80, 0, 0', maxNumberOfBuilds: 0, methodCoverageTargets: '80, 0, 0', onlyStable: false, sourceEncoding: 'ASCII', zoomCoverageChart: false

        }
    }
}