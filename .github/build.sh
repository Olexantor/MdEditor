curl -Ls https://install.tuist.io | bash
tuist install 3.42.2
tuist fetch
tuist generate

$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install swiftlint

xcodebuild clean -quiet
xcodebuild build-for-testing\
    -workspace 'Project/MdEditor.xcworkspace' \
    -scheme 'MdEditor' \
    -destination 'platform=iOS Simulator,name=iPhone 15 Pro'
