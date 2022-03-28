#! /bin/bash

#Provide the parameters in following manner
#1) Tag version, for example v0.19.0.
#2) Commit sha for the commit you want to tag.
#3) Git user name to push tag.
#3) Git user email to push tag.
tagName=$1
commitSha=$2
userName=$3
userEmail=$4

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
git config user.name ${userName}
git config user.email ${userEmail}

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

#Creating a release branch if the tag pushed is not a dev tag.
#If it has the -dev tag then release branch won't be created
if [[ "$tagName" != *"-dev"* ]];then
    #while release branch we only use 0.16 instead of v0.16.0, hence trimmed tagName(i.e 0.16 for example)
    git checkout -b release-${tagName:1:4} $commitSha
    git push origin release-${tagName:1:4}
    echo "created release branch for ${tagName:1:4}"
fi

# Syncing 
git push k8scommonmirror $tagName
#git push k8scoremirror $tagName
echo "syncing completed"

#Listing and validating tags for all remotes
declare -i tf=0;
declare -i cc=0;
declare -i cb=0;

IFS=$'\n'
echo "In Upstream tanzu-framework"
for i in $(git ls-remote --tags origin)
do
	echo "$i"
	if [[ $i == *"${tagName}"* ]];then
		val=1
	fi
done

echo "In downstream k8s-common-core"
for i in $(git ls-remote --tags k8scommonmirror)
do
	echo "$i"
	if [[ $i == *"${tagName}"* ]];then
		cc=1
	fi
done

#echo "In downstream k8s-core-build"
#for i in $(git ls-remote --tags k8scoremirror)
#do
#	echo "$i"
#	if [[ $i == *"${tagName}"* ]];then
#		cb=1
#	fi
#done

if [[ $val == 1 ]];then
	echo "Tag ${tagName} validated successfully on upstream tanzu-framework"
	else
	echo "Tag ${tagName} not pushed on upstream tanzu-framework"
fi

if [[ $cc == 1 ]];then
	echo "Tag ${tagName} validated successfully on downstream k8s-common-core mirror"
	else
	echo "Tag ${tagName} not pushed on downstream k8s-common-core mirror"
fi

#if [[ $cb == 1 ]];then
#	echo "Tag ${tagName} validated successfully on downstream k8s-core-build mirror"
#	else
#	echo "Tag ${tagName} not pushed on downstream k8s-core-build mirror"
#fi

#clearing the temp directory
rm -rf $tmp_dir
