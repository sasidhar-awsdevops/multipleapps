pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                echo "checking out the code"
                checkout changelog: false, scm: [$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/sasidhar-awsdevops/multipleapps.git']]]
            }
        }
        stage('folder-name') {
            steps {
                echo "Print the present working dir"
                sh "pwd"
            }
        }
        stage('ImageBuild') {
            steps {
                echo "This step helps in building the image"
                sh "chown jenkins.jenkins /var/run/docker.sock"
                sh "docker build -t angular-test ."
                sh "docker save angular-test > angular-test.tar"
                sh "ls -al"
            }
        }
    }
}