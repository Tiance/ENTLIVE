project 'ENT-LIVE.xcodeproj'

use_frameworks!
# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

target 'Api' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks

  # Pods for Api
  pod 'Moya'
  pod 'Moya/RxSwift'
  target 'ApiTests' do
    inherit! :search_paths
    # Pods for testing
  end

end

target 'ENTLIVE' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  # Pods for ENT-LIVE
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'IGListKit'
  pod 'Kickstarter-Prelude'
  pod 'XLPagerTabStrip'
  pod 'SwiftProtobuf'
  pod 'TXLiteAVSDK_Professional', :podspec => 'http://pod-1252463788.cosgz.myqcloud.com/liteavsdkspec/TXLiteAVSDK_Professional.podspec'
  target 'ENTLIVETests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'ENTLIVEUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      if config.name == 'Debug'
        config.build_settings['OTHER_SWIFT_FLAGS'] = ['$(inherited)', '-Onone']
        config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Owholemodule'
      end
    end
  end
end
