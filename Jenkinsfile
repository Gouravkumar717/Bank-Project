pipeline {
    agent any
    tools {
        maven "M2_HOME"
    }
    stages {
        stage ("Clone and Build") {
            steps {
                // Use credentials and specify the correct branch
                git branch: 'main', url: 'https://github.com/Gouravkumar717/Bank-Project.git', credentialsId: 'git-cread'
                
                // Build the project with Maven
                sh "mvn -Dmaven.test.failure.ignore=true clean package"
            }
        }
        stage ("Generate Test Reports ") {
            steps {
                publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: '/var/lib/jenkins/workspace/Bank-Project/target/surefire-reports', reportFiles: 'index.html', reportName: 'HTML Report', reportTitles: '', useWrapperFileDirectly: true])
            }
        }
        stage ("Create Docker Image") {
            steps {
                sh "docker build - gourav787/bank-project:1.0 ."
            }
        }
    }
}
