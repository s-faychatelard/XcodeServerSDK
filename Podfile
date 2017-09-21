source 'https://github.com/s-faychatelard/Buildasaur-podspecs.git'
source 'https://github.com/CocoaPods/Specs.git'

use_frameworks!

def utils
    pod 'BuildaUtils', '~> 0.4.1'
end

def tests
    pod 'DVR', '~> 0.3'
    pod 'Nimble', :git => 'https://github.com/Quick/Nimble.git', :commit => 'a63252b16eba6cdebec4e4936388c90552165a68'
end

target 'XcodeServerSDK' do
    utils
end

target 'XcodeServerSDKTests' do
    utils
    tests
end
