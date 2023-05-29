pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }

    tools {
        ansible 'ansible'
        terraform 'terraform144'
    }

    stages {
        stage('Checkout from SCM') {
            steps {
                echo "checkout completed"
            }
        }
        stage('build infra') {
            steps {
                sh '''
                    terraform -chdir=config/terraform/global init
                    terraform -chdir=config/terraform/global apply --auto-approve
                '''
            }
        }
    }
}