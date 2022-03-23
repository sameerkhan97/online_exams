#! /bin/bash

tagName=$1
commitSha=$2

if [[ -z "$commitSha" ]];then
    echo "COMMIT_SHA not provided"
    exit 1
fi
if [[ -z "$tagName" ]];then
    echo "Tag not provided"
    exit 1
fi

k8scommonmirror="git@gitlab.eng.vmware.com:sameerkh/mirrors_github_tanzu-framework.git"
#k8scoremirror="git@gitlab.eng.vmware.com:core-build/mirrors_github_tanzu-framework.git"

#making temperory directory to avoid error
tmp_dir=$(mktemp -d)

git clone git@github.com:sameerkhan97/tanzu-framework.git $tmp_dir
echo "repository cloned"
cd $tmp_dir

#adding allfered bot configs
git config user.name "alfredthenarwhal"
git config user.email "alfredthenarwhal@users.noreply.github.com"

#adding remote
git remote add k8scommonmirror $k8scommonmirror
#git remote add k8scoremirror $k8scoremirror
echo "remotes added"

# release tag
if [[ "$tagName" != *"-dev"* ]];then
    git tag -a $tagName -m "$tagName release of Tanzu Framework" $commitSha
    else
    git tag -a $tagName -m "Dev tag for ${tagName:0:7} release of Tanzu Framework" $commitSha
fi
git push origin $tagName
echo "tag pushed"

#create release branch 
#Creating a release branch if the tag pushed is not a dev tag. 
#If it has the -dev tag then release branch won't be created
if [[ "$tagName" != *"-dev"* ]];then
    #while release branch we only use 0.16 instead of v0.16.0, hence making another string to get trimmed tagName(i.e 0.16 for example)
    updateTag=${tagName:1:4}
    git checkout -b release-$updateTag $commitSha
    git push origin release-$updateTag    
    echo "created release branch for $updateTag"
fi

# Syncing 
git push k8scommonmirror $tagName
#git push k8scoremirror $tagName
echo "syncing completed"

#Listing tags for all remotes 
echo "Tags on tanzu-framework :"
git ls-remote --tags origin
echo "Tags on common core mirror :"
git ls-remote --tags $k8scommonmirror
echo "Tags on core build mirror :"
#git ls-remote --tags $k8scoremirror

#clearing the temp directory
rm -rf $tmp_dir