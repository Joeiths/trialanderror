stage name: 'Checkout'
node {
git 'https://github.com/Gnarga/trialanderror'
}

stage name: 'JUnit Build'
node {
    if (isUnix()) {
        echo "unix mode"
	    sh 'mvn compile'
    } else {
        echo "windows mode"
        bat 'mvn compile'
    }
}

stage name: 'JUnit Test'
node {
    if (isUnix()) {
        sh 'mvn test'
	junit '**/TEST*.xml'
    } else {
        bat 'mvn test'
	junit '**/TEST*.xml'
   }	
}

stage name: 'Newman'
node {
    if (isUnix()) {
        sh 'newman run RestfulBooker.postman_collection.json --environment RestfulBooker.postman_environment.json --reporters junit'
	junit '**/TEST*.xml'
    } else {
        bat 'newman run RestfulBooker.postman_collection.json --environment RestfulBooker.postman_environment.json --reporters junit'
	junit '**/TEST*.xml'
   }
}







stage name: 'Post'
node {
junit '**/TEST*.xml'
emailext attachLog: true, attachmentsPattern: '**/TEST*xml',
body: '', recipientProviders: [culprits()], subject:
'$PROJECT_NAME - Build # $BUILD_NUMBER - $BUILD_STATUS!'
}
