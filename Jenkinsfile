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
        
        stage('Tag') {
            steps {
                sh '''
                    tagName="v0.14.0"
                    commitSha="4cd5c9830f4e21ff90feb40e9834024a981667d4"
                    git tag -a $tagName -m "$tagName release of Covid Deaths" $commitSha
                    echo "tag pushing"
                '''
            }
        }
    }
}
