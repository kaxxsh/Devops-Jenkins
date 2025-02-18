pipeline {
    agent any

    environment {
        TF_WORKING_DIR = "./Day2"
    }

    parameters {
        booleanParam(name: 'AUTO_APPROVE', defaultValue: false, description: 'Skip manual approval')
    }

    options {
        skipStagesAfterUnstable()
    }

    stages {
        stage('Checkout Code') {
            steps {
                script {
                    checkout scm
                }
            }
        }

        stage('Print Branch') {
            steps {
                script {
                    echo "Running on branch: ${env.GIT_BRANCH}"
                }
            }
        }

        stage('Terraform Init') {
            steps {
                script {
                    dir("${TF_WORKING_DIR}") {
                        sh 'terraform init'
                    }
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                script {
                    dir("${TF_WORKING_DIR}") {
                        sh 'terraform plan'
                    }
                }
            }
        }

        stage('Approval Before Apply') {
            when {
                expression { env.GIT_BRANCH == 'main' || env.GIT_BRANCH == 'origin/main' }
            }
            steps {
                script {
                    if (!params.AUTO_APPROVE) {
                        input message: "Approve Terraform Apply?", ok: "Proceed"
                    }
                }
            }
        }

        stage('Terraform Apply') {
            when {
                expression { env.GIT_BRANCH == 'main' || env.GIT_BRANCH == 'origin/main' }
            }
            steps {
                script {
                    dir("${TF_WORKING_DIR}") {
                        sh 'terraform apply -auto-approve'
                    }
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline executed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}