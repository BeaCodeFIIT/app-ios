# Uncomment this line to define a global platform for your project
platform :ios, '10.0'
use_frameworks!

target 'BeaCodeApp' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for BeaCodeApp
  pod 'Alamofire', '~> 4.0'
  pod 'DLRadioButton', '~> 1.4'
  pod 'TagListView', '~> 1.0'
  pod 'ObjectMapper', '~> 2.2'
  pod 'Fabric'
  pod 'Crashlytics'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
