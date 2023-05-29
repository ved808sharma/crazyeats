pipeline {
    agent: any
    tools {
        ansible 'ansible'
        terraform 'terraform'
    }
    stages {
        stage('Checkout from SCM') {
            step {
                echo "checkout completed"
            }
        }
        stage('build infra') {
            steps {
                sh '''
                    terraform init
                    terraform -chdir=config/terraform/global apply --auto-approve
                '''
            }
        }
    }
}