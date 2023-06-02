pipeline {
agent any
stages {
    
stage('Checkout') {
steps {
checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: '540de877-a704-4193-9458-f87cd9ba2fe3', url: 'https://github.com/2277611/cvs_pharma_infra.git']])
}
}

stage ('terraform init') {
steps {
sh ('terraform init')
}
}

stage ('terraform Action') {
steps {
echo 'Terraform action is –> ${action}'
sh ('terraform ${action} –auto-approve')
}
}

}
}