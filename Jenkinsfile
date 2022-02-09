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
                    git clone git@github.com:sameerkhan97/covid19_death.git $tmp_dir
                    echo "covid death repository cloned"
                    cd $tmp_dir
                '''
            }
        }
        
        stage('Tag') {
            steps {
                sh '''
                    git tag -a v0.14.0 -m "v0.14.0 release of Covid-19" c74e1bcea607b92e53937a60268efb2cc0460c21
                    echo "tag pushing"
                '''
            }
        }
        
        stage('Cleaning') {
            steps {
                sh '''
                   rm -f $tmp_dir
                   echo "temp directory deleted"
                '''
            }
        }
    }
}
