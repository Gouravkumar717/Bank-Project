pipeline {
    agent any

    tools {
        maven "M2_HOME"
    }

    stages {
        stage ("Build") {
            steps {
                git url: 'https://github.com/Gouravkumar717/pro1.git', branch: 'main', credentialsId: 'git-creds'
                sh "mvn -Dmaven.test.failure.ignore=true clean package"
            }
        }
        
    }
}
