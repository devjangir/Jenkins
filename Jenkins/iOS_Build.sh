#!/bin/sh
PROJECT_BUILDDIR="${WORKSPACE}/Jenkins/build/Release-iphoneos"
APPLICATION_NAME="Jenkins"
BUILD_HISTORY_DIR="/Users/devdutt/Provisioning/builds"
DEVELOPER_NAME="iPhone Distribution: My Personal Health Record Express, Inc. (2Y23VVMDSG)"
PROVISIONING_PROFILE="/Users/devdutt/Downloads/MphRxAdHocDev.mobileprovision"
HOST_LOCATION="/Library/WebServer/Documents/apps"

#Sign The .app file and create .ipa file
/usr/bin/xcrun -sdk iphoneos PackageApplication -v  "${PROJECT_BUILDDIR}/${APPLICATION_NAME}.app" -o  "${BUILD_HISTORY_DIR}/${APPLICATION_NAME}.ipa" --sign ${DEVELOPER_NAME} --embed ${PROVISIONING_PROFILE}

#Get the version from the Info.plist file
APP_PATH="${PROJECT_BUILDDIR}/${APPLICATION_NAME}.app"
VERSION=`defaults read ${APP_PATH}/Info CFBundleShortVersionString`
BUNDLE_ID=`defaults read ${APP_PATH}/Info CFBundleIdentifier`

# Create plist
cat ${HOST_LOCATION}/template.plist | sed -e "s/\${APP_NAME}/$APPLICATION_NAME/" -e "s/\${BUNDLE_ID}/$BUNDLE_ID/" -e "s/\${BUNDLE_VERSION}/$VERSION/" > ${HOST_LOCATION}/${APPLICATION_NAME}.plist