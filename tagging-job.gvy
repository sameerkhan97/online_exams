#!groovy
pipeline {
    agent 'any'
    parameters {
        string(description: 'Enter tanzu framework release version which you want to tag' , name:'TANZU_FRAMEWORK_RELEASE_VERSION' , defaultValue:'v0.18.0')
        string(description: 'Enter commit SHA for tag and release branch creation' , name:'COMMIT_SHA' , defaultValue:'')
        string(description: 'Enter git user name to be used signing the tag and release branch' , name:'USER_NAME' , defaultValue:'alfredthenarwhal')
        string(description: 'Enter git user email to be used signing the tag and release branch' , name:'USER_EMAIL' , defaultValue:'alfredthenarwhal@users.noreply.github.com')
    }
    stages {
        stage('Push tag and create release branch') {
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
                   ./tagging-script.sh ${TANZU_FRAMEWORK_RELEASE_VERSION} ${COMMIT_SHA}
                '''
            }
        }
    }
}
