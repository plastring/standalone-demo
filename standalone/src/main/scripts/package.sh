#!/bin/sh

if [ ! $PROJECT_HOME ]; then
    echo "PROJECT_HOME must be set"
    exit 0;
fi

if [ ! $PROJECT_NAME ]; then
    echo "PROJECT_NAME must be set"
    exit 0;
fi

if [ ! $PROJECT_VERSION ]; then
    echo "PROJECT_VERSION must be set"
    exit 0;
fi

if [ ! $DEPLOY_PATH ]; then
    echo "DEPLOY_PATH must be set"
    exit 0;
fi

cd $PROJECT_HOME

echo "Create an install without jre..."

cd $PROJECT_HOME/standalone/target
echo `pwd`
tar xf $PROJECT_NAME-$PROJECT_VERSION-bin.tar.gz
makeself.sh --notemp --nomd5 $PROJECT_NAME-$PROJECT_VERSION $PROJECT_NAME-installer-$PROJECT_VERSION "$PROJECT_NAME $PROJECT_VERSION" ./bin/setup.sh $PROJECT_NAME $PROJECT_VERSION $DEPLOY_PATH

echo "Installer without jre created."

if [ -d "$JRE_HOME" ]; then
    echo "Create an install with jre..."
    mkdir $PROJECT_NAME-$PROJECT_VERSION/jre
    cp -fr $JRE_HOME/* $PROJECT_NAME-$PROJECT_VERSION/jre/
    tar zcf $PROJECT_NAME-with-jre-$PROJECT_VERSION-bin.tar.gz $PROJECT_NAME-$PROJECT_VERSION
    makeself.sh --notemp --nomd5 $PROJECT_NAME-$PROJECT_VERSION $PROJECT_NAME-installer-with-jre-$PROJECT_VERSION "$PROJECT_NAME $PROJECT_VERSION" ./bin/setup.sh $PROJECT_NAME $PROJECT_VERSION $DEPLOY_PATH
    echo "Installer with jre created."
fi

rm -fr $PROJECT_NAME-$PROJECT_VERSION
