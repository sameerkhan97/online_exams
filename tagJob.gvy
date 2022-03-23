#!groovy
pipeline {
    agent 'any' 
    parameters {
        string(description: 'Enter tanzu framework release version which you want to tag' , name:'TANZU_FRAMEWORK_RELEASE_VERSION' , defaultValue:'v0.18.0')
        string(description: 'Enter commit sha for the commit which you want to tag ' , name:'COMMIT_SHA' , defaultValue:'')
    }
    stages {
        stage('Build') {
            steps {
                sh '''
                   if [[ -z "$COMMIT_SHA" ]];then
                        echo "COMMIT_SHA not provided"
                        exit 1
                    fi
                    if [[ -z "$TANZU_FRAMEWORK_RELEASE_VERSION" ]];then
                        echo "Tag not provided"
                        exit 1
                    fi
                   ./tagging.sh ${TANZU_FRAMEWORK_RELEASE_VERSION} ${COMMIT_SHA}
                '''
            }
        }
    }
}
