pipeline {
  agent none
    stages {
      stage ('Checkout') {
        agent any
          steps {
            checkout scm
            git 'https://github.com/Gnarga/trialanderror'
            stash includes: '**/target/*.jar', name: 'app'
          }
        }

stage('Test on Linux') {
  agent {
    label 'linux'
}
steps {
  unstash 'app'
  sh "mvn -B compile"
} post {
    always {
      junit '**/TEST*.xml'
    }
  }
}

stage('Test on Windows') {
  agent {
    label 'windows'
}
steps {
  unstash 'app'
  bat "mvn -B compile"
} post {
    always {
      junit '**/TEST*.xml'
    }
  }
}
