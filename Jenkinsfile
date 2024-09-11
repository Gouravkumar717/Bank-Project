pipeline {
    agent any

    tools {
        maven "M2_HOME"
    }

    stages {
        stage ("Clone and Build") {
            steps {
                // Use credentials if the repository is private
                git url: 'https://github.com/Gouravkumar717/Bank-Project.git', credentialsId: 'Git-Cred'
                
                // Build the project with Maven, ignoring test failures
                sh "mvn -Dmaven.test.failure.ignore=true clean package"
            }
        }
    }
}
