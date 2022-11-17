# default configuration
SCHEME_NAME="${PROJECT_NAME}"
FRAMEWORK_NAME="${PROJECT_NAME}"

# set base paths
PUB_DIC="./_Public"
BUILD_PATH="${PUB_DIC}/build"
SOURCES_PATH="${PUB_DIC}/Sources"

# set archives paths
ARCHIVE_PATH="${BUILD_PATH}/${FRAMEWORK_NAME}.xcarchive"
ARCHIVE_PATH_SIMULATOR="${BUILD_PATH}/${FRAMEWORK_NAME}-simulator.xcarchive"
ARCHIVE_PATH_TV="${BUILD_PATH}/${FRAMEWORK_NAME}-tv.xcarchive"

# clean build path
rm -rf "${BUILD_PATH}"
mkdir "${BUILD_PATH}"

# build archive
xcodebuild archive \
  -scheme ${SCHEME_NAME} \
  -destination "generic/platform=iOS" \
  -archivePath "${ARCHIVE_PATH}" \
  SKIP_INSTALL=NO \
  BUILD_LIBRARY_FOR_DISTRIBUTION=YES
  
xcodebuild archive \
  -scheme ${SCHEME_NAME} \
  -destination "generic/platform=iOS Simulator" \
  -archivePath "${ARCHIVE_PATH_SIMULATOR}" \
  SKIP_INSTALL=NO \
  BUILD_LIBRARY_FOR_DISTRIBUTION=YES
  
xcodebuild archive \
  -scheme ${SCHEME_NAME} \
  -destination "generic/platform=tvOS" \
  -archivePath "${ARCHIVE_PATH_TV}" \
  SKIP_INSTALL=NO \
  BUILD_LIBRARY_FOR_DISTRIBUTION=YES

# create xcframework
xcodebuild -create-xcframework \
  -framework "${ARCHIVE_PATH}/Products/Library/Frameworks/${FRAMEWORK_NAME}.framework" \
  -framework "${ARCHIVE_PATH_SIMULATOR}/Products/Library/Frameworks/${FRAMEWORK_NAME}.framework" \
  -framework "${ARCHIVE_PATH_TV}/Products/Library/Frameworks/${FRAMEWORK_NAME}.framework" \
  -output ${BUILD_PATH}/${FRAMEWORK_NAME}.xcframework

# move xcframework into public path as pod
cp -fr  ${BUILD_PATH}/${FRAMEWORK_NAME}.xcframework \
        ${SOURCES_PATH}
        #/${FRAMEWORK_NAME}.xcframework

# clean build path
rm -rf "${BUILD_PATH}"

PODSPEC="${PUB_DIC}/${PRODUCT_NAME:c99extidentifier}TEST.podspec"
echo "
  Pod::Spec.new do |s|
    s.name = '${PRODUCT_NAME:c99extidentifier}'
    s.version = '${CURRENT_PROJECT_VERSION}'
    s.license = { :type => 'MIT', :text => 'MIT License' }
    s.summary = '${FULL_PRODUCT_NAME}'
    s.homepage = 'https://github.com/MEDIASCOPE-JSC/mediatag-sdk-ios-bin'
    s.authors = { 'miromax21' => 'miromax21@gmail.com' }
    s.source = { :git => 'https://github.com/MEDIASCOPE-JSC/mediatag-sdk-ios-bin.git', :tag => s.version.to_s }
    s.swift_version = '4.0'
    s.platform = :ios, '12.0'
    s.vendored_frameworks = '${PRODUCT_NAME}.xcframework'
    s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64, x86_64' }
    s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64, x86_64' }
    s.requires_arc = false
  end
"  > $PODSPEC

if [ "${CONFIGURATION}" = "Release" ]; then
  TAG=$(git describe --tags $(git rev-list --tags --max-count=1))
  if [ $TAG == $CURRENT_PROJECT_VERSION ]; then
    echo "error: the tag ${TAG} already exists"
    exit 1
  fi
  # отправка на сервер (добавлю когда все будет работать как часы)
fi

open ${PUB_DIC}

