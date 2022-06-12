pipeline {
    agent any

    stages {
        stage('Clone repositories') {
            steps {
                echo 'git clone this and that'
            }
        }
        stage('checkout correct commits') {
            steps {
                echo 'checking out correct commits'
            }
        }
        stage('setup build directories') {
            steps {
                echo 'copying *.conf files and creating folder structure'
            }
        }
        stage('Run docker build') {
            steps{
                echo 'pulling docker container if not yet availablke'
                echo 'running build with docker container'
            }
        }
    }
}
