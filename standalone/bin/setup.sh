#!/bin/sh

PROJECT_NAME=$1
PROJECT_VERSION=$2
DEPLOY_PATH=$3

#
# Get the APP_HOME
#
whoami=`basename $0`
whereami=`echo $0 | sed -e "s#^[^/]#\`pwd\`/&#"`
whereami=`dirname $whereami`

# Resolve any symlinks of the now absolute path, $whereami
realpath_listing=`ls -l $whereami/$whoami`
case "$realpath_listing" in
*-\>\ /*)
  realpath=`echo $realpath_listing | sed -e "s#^.*-> ##"`
;;
*-\>*)
  realpath=`echo $realpath_listing | sed -e "s#^.*-> #$whereami/#"`
;;
*)
  realpath=$whereami/$whoami
;;
esac
APP_HOME=`dirname "$realpath"`

if [ ! -d "$DEPLOY_PATH" ]; then
  mkdir -p "$DEPLOY_PATH"
fi

rm -fr $DEPLOY_PATH/$PROJECT_NAME
mv $APP_HOME/../../$PROJECT_NAME-$PROJECT_VERSION $DEPLOY_PATH/$PROJECT_NAME

rm -f $DEPLOY_PATH/$PROJECT_NAME/bin/setup.sh