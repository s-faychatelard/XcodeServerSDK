source 'https://github.com/s-faychatelard/Buildasaur-podspecs.git'
source 'https://github.com/CocoaPods/Specs.git'

use_frameworks!

def utils
    pod 'BuildaUtils', '~> 0.4.1'
end

def tests
    pod 'DVR', '~> 1.1.0'
    pod 'Nimble', '~> 7.0.2'
end

target 'XcodeServerSDK' do
    utils
end

target 'XcodeServerSDKTests' do
    utils
    tests
end
