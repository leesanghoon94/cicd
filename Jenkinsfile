pipeline {
    agent any

    stages {
        stage('start') {
            steps {
                slackSend (channel: '#cicd-test', message: "start")
            }
        }
        stage('ci') {
            steps {
                sh '''
                python3 -m venv venv
                . venv/bin/activate
                pip install -r requirements.txt
                pylint --ignore-path='tests' $(git ls-files '*.py')
                pytest
                coverage run -m pytest
                coverage report
                coverage html
                '''
            }
        }
        stage('deploy') {
            steps {
                sshagent (credentials: ["cicd-pem"])
                sh '''
                ssh -o "StrictHostKeyChecking no" ec2-user@43.202.57.228 "cd cicd && git pull"
                '''
            }
        }
        stage('end') {
            agent any
            steps {
                slackSend (channel: '#cicd-test', message: "endd")
            }
        }
    }
}
