#!groovy
pipeline {
    agent 'any'
    parameters {
        string(description: 'Enter tanzu framework release version which you want to tag' , name:'TANZU_FRAMEWORK_RELEASE_VERSION' , defaultValue:'v0.18.0')
<<<<<<< HEAD
        string(description: 'Enter commit SHA for tag and release branch creation' , name:'COMMIT_SHA' , defaultValue:'')
        string(description: 'Enter git user name to be used signing the tag and release branch' , name:'USER_NAME' , defaultValue:'alfredthenarwhal')
        string(description: 'Enter git user email to be used signing the tag and release branch' , name:'USER_EMAIL' , defaultValue:'alfredthenarwhal@users.noreply.github.com')
    }
    stages {
        stage('Tagging') {
=======
        string(description: 'Enter commit sha for the commit which you want to tag ' , name:'COMMIT_SHA' , defaultValue:'')
        string(description: 'Enter git user name to push tag ' , name:'USER_NAME' , defaultValue:'alfredthenarwhal')
        string(description: 'Enter git user email to push tag ' , name:'USER_EMAIL' , defaultValue:'alfredthenarwhal@users.noreply.github.com')
    }
    stages {
        stage('Build') {
>>>>>>> ca8d828 (Rename files)
            steps {
                sh '''
                   if [[ -z "$COMMIT_SHA" ]];then
                        echo "COMMIT_SHA not provided"
                        exit 1
                    fi
<<<<<<< HEAD
                    if [[ -z "$TANZU_FRAMEWORK_RELEASE_VERSION" ]];then
                        echo "Tag not provided"
                        exit 1
                    fi
                   ./tagging-script.sh ${TANZU_FRAMEWORK_RELEASE_VERSION} ${COMMIT_SHA}
=======
                    if [[ -z "$TANZU_FRAMEWORK_RELEASE_VERSION" || "$TANZU_FRAMEWORK_RELEASE_VERSION" == "v0.18.0" ]];then
                        echo "Correct tag not provided"
                        exit 1
                    fi
                   ./tagging-script.sh ${TANZU_FRAMEWORK_RELEASE_VERSION} ${COMMIT_SHA} ${USER_NAME} ${USER_EMAIL}
>>>>>>> ca8d828 (Rename files)
                '''
            }
        }
    }
}
