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
                sh "pwd"
                echo "Print the present working dir"
            }
        }
        stage('ImageBuild') {
            steps {
                echo "This step helps in building the image"
            }
        }
    }
}