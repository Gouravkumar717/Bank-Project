pipeline {
    agent any
    tools {
        maven "M2_HOME"
    }
    stages {
        stage("Clone and Build") {
            steps {
                // Use credentials and specify the correct branch
                git branch: 'main', url: 'https://github.com/Gouravkumar717/Bank-Project.git', credentialsId: 'git-cread'
                
                // Build the project with Maven
                sh "mvn -Dmaven.test.failure.ignore=true clean package"
            }
        }
        stage("Generate Test Reports") {
            steps {
                // Ensure the reportDir is correctly set to the path where test reports are generated
                publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, 
                             reportDir: 'target/surefire-reports', reportFiles: 'index.html', 
                             reportName: 'HTML Report', reportTitles: ''])
            }
        }
        stage("Create Docker Image") {
            steps {
                // Correct Docker build command
                sh "docker build -t gourav787/bank-project:1.0 ."
            }
        }
        stage("Docker-login") {
            steps {
                // Login to Docker using credentials stored in Jenkins
                withCredentials([usernamePassword(credentialsId: 'Docker-cred', passwordVariable: 'dockerpassword', usernameVariable: 'dockerlogin')]) {
                    sh "docker login -u ${dockerlogin} -p ${dockerpassword}"
                }
            }
        }
        stage("Docker-push") {
            steps {
                // Push Docker image to DockerHub
                sh "docker push gourav787/bank-project:1.0"
            }
        }
        stage("Terraform Deployment") {
            steps {
                // Use AWS credentials for Terraform
                withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'AwsAccessKey', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                    dir("terraform-files") {
                        // Ensure keypair path is correct
                        sh 'sudo chmod 600 /path/to/keypair.pem'
                        
                        // Terraform commands
                        sh 'terraform init'
                        sh 'terraform validate'
                        sh 'terraform apply --auto-approve'
                    }
                }
            }
        }
    }
}
