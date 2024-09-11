pipeline {
    agent any

    tools {
        maven "M2_HOME"
    }

    stages {
        stage ("Build") {
            steps {
                git 'https://github.com/Gouravkumar717/Bank-Project.git'
                sh "mvn -Dmaven.test.failure.ignore=true clean package"
            }
        }
        
    }
}
