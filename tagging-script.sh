#! /bin/bash

#Provide the parameters in following manner
#1) Tag version, for example v0.19.0.
#2) Commit sha for the commit you want to tag.
#3) Git user name to push tag.
<<<<<<< HEAD
#4) Git user email to push tag.

set -o errexit

tagName=$1
commitSha=$2
USER_NAME=${USER_NAME:-'alfredthenarwhal'}
USER_EMAIL=${USER_EMAIL:-'alfredthenarwhal@users.noreply.github.com'}
=======
#3) Git user email to push tag.
tagName=$1
commitSha=$2
userName=$3
userEmail=$4
>>>>>>> ca8d828 (Rename files)

if [[ -z "$commitSha" ]];then
    echo "COMMIT_SHA not provided"
    exit 1
fi
if [[ -z "$tagName" ]];then
<<<<<<< HEAD
    echo "tag not provided or incorrect tag"
    exit 1
fi

#Adding 'v' if not provided with the tag
if [[ ${tagName:0:1} != "v" ]];then
    tagName="v${tagName}"
fi

=======
    echo "Tag not provided"
    exit 1
fi

>>>>>>> ca8d828 (Rename files)
k8scommonmirror="git@gitlab.eng.vmware.com:sameerkh/mirrors_github_tanzu-framework.git"
#k8scoremirror="git@gitlab.eng.vmware.com:core-build/mirrors_github_tanzu-framework.git"

#making temperory directory to avoid error
tmp_dir=$(mktemp -d)

<<<<<<< HEAD
#force cleanup before exit
cleanup() {
    echo "Cleanup before exit"
    rm -rf $tmp_dir
}
trap cleanup EXIT

git clone git@github.com:sameerkhan97/tanzu-framework.git $tmp_dir
echo "Tanzu Framework upstream repository cloned"
cd $tmp_dir

#adding allfered bot configs
git config user.name ${USER_NAME}
git config user.email ${USER_EMAIL}
=======
git clone git@github.com:sameerkhan97/tanzu-framework.git $tmp_dir
echo "repository cloned"
cd $tmp_dir

#adding allfered bot configs
git config user.name ${userName}
git config user.email ${userEmail}
>>>>>>> ca8d828 (Rename files)

#adding remote
git remote add k8scommonmirror $k8scommonmirror
#git remote add k8scoremirror $k8scoremirror
<<<<<<< HEAD
echo "k8s-common-core & core-build remotes added"
=======
echo "remotes added"
>>>>>>> ca8d828 (Rename files)

# release tag
if [[ "$tagName" != *"-dev"* ]];then
    git tag -a $tagName -m "$tagName release of Tanzu Framework" $commitSha
    else
    git tag -a $tagName -m "Dev tag for ${tagName:0:7} release of Tanzu Framework" $commitSha
fi
git push origin $tagName
<<<<<<< HEAD
echo "Tag $tagName pushed on upstream Tanzu Framework repository"

#Extracting major, minor, patch version from given tag
IFS='.'
read -a strarr <<<"$tagName"  
declare -i X=${strarr[0]:1};
declare -i Y=${strarr[1]};  
declare -i Z=${strarr[2]};  
IFS=' '
=======
echo "tag pushed"
>>>>>>> ca8d828 (Rename files)

#Creating a release branch if the tag pushed is not a dev tag.
#If it has the -dev tag then release branch won't be created
if [[ "$tagName" != *"-dev"* ]];then
    #while release branch we only use 0.16 instead of v0.16.0, hence trimmed tagName(i.e 0.16 for example)
<<<<<<< HEAD
    git checkout -b release-${X}.${Y} $commitSha
    git push origin release-${X}.${Y}
    echo "Created release-${X}.${Y} branch on upstream Tanzu Framework repository"
=======
    git checkout -b release-${tagName:1:4} $commitSha
    git push origin release-${tagName:1:4}
    echo "created release branch for ${tagName:1:4}"
>>>>>>> ca8d828 (Rename files)
fi

# Syncing 
git push k8scommonmirror $tagName
#git push k8scoremirror $tagName
<<<<<<< HEAD
echo "Syncing with downstream mirrors completed"
=======
echo "syncing completed"
>>>>>>> ca8d828 (Rename files)

#Listing and validating tags for all remotes
declare -i tf=0;
declare -i cc=0;
declare -i cb=0;

IFS=$'\n'
<<<<<<< HEAD
echo "Tags on Upstream tanzu-framework : "
=======
echo "In Upstream tanzu-framework"
>>>>>>> ca8d828 (Rename files)
for i in $(git ls-remote --tags origin)
do
	echo "$i"
	if [[ $i == *"${tagName}"* ]];then
<<<<<<< HEAD
		tf=1
	fi
done

echo "Tags on downstream k8s-common-core mirror"
=======
		val=1
	fi
done

echo "In downstream k8s-common-core"
>>>>>>> ca8d828 (Rename files)
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

<<<<<<< HEAD
if [[ $tf == 1 ]];then
	echo "Tag ${tagName} validated successfully on upstream tanzu-framework"
else
	echo "Tag ${tagName} validation failed on upstream tanzu-framework"
	exit 1
=======
if [[ $val == 1 ]];then
	echo "Tag ${tagName} validated successfully on upstream tanzu-framework"
	else
	echo "Tag ${tagName} not pushed on upstream tanzu-framework"
>>>>>>> ca8d828 (Rename files)
fi

if [[ $cc == 1 ]];then
	echo "Tag ${tagName} validated successfully on downstream k8s-common-core mirror"
<<<<<<< HEAD
else
	echo "Tag ${tagName} validation failed on downstream k8s-common-core mirror"
	exit 1
fi

#if [[ $cb == 1 ]];then
#	echo "Tag ${tagName} validated successfully on downstream k8s-core-build mirror"
#	else
#	echo "Tag ${tagName} not pushed on downstream k8s-core-build mirror"
#fi
=======
	else
	echo "Tag ${tagName} not pushed on downstream k8s-common-core mirror"
fi

if [[ $cb == 1 ]];then
	echo "Tag ${tagName} validated successfully on downstream k8s-core-build mirror"
	else
	echo "Tag ${tagName} not pushed on downstream k8s-core-build mirror"
fi

#clearing the temp directory
rm -rf $tmp_dir
>>>>>>> ca8d828 (Rename files)
