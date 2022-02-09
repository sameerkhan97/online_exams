pipeline {
    agent any 
    stages {
        stage('Config') {
            steps {
                sh '''
                    git config --global user.name "sameerkhan97"
                    git config --global user.email "khansam9730@gmail.com"    
                    echo "Configuration successfull"
                '''
            }
        }
    
        stage('Clone') {
            steps {
                sh '''
                    tmp_dir=$(mktemp -d)
                    echo "Directory created"
                    git clone git@github.com:sameerkhan97/covid19_death.git
                    echo "covid death repository cloned"
                    cd $tmp_dir
                '''
            }
        }
    }
}
