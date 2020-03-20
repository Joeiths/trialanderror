stage('Checkout') {
node {
git 'https://github.com/Gnarga/trialanderror'
	}
}

stage:('JUnit Build') {
node {
    if (isUnix()) {
        echo "unix mode"
	    sh 'mvn compile'
    } else {
        echo "windows mode"
        bat 'mvn compile'
    }
  }
}

stage:('JUnit Test') {
node {
    if (isUnix()) {
        sh 'mvn test'
    } else {
        bat 'mvn test'
   }	
} node {
junit '**/TEST*.xml'
}

stage name: 'Newman'
node {
    if (isUnix()) {
        sh 'newman run RestfulBooker.postman_collection.json --environment RestfulBooker.postman_environment.json --reporters junit'
    } else {
        bat 'newman run RestfulBooker.postman_collection.json --environment RestfulBooker.postman_environment.json --reporters junit'
   }
} node {
junit '**/*xml'
}







stage name: 'Post'
node {
junit '**/TEST*.xml'
emailext attachLog: true, attachmentsPattern: '**/TEST*xml',
body: '', recipientProviders: [culprits()], subject:
'$PROJECT_NAME - Build # $BUILD_NUMBER - $BUILD_STATUS!'
}
