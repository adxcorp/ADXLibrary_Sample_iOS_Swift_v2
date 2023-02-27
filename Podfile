source 'https://github.com/adxcorp/AdxLibrary_iOS_Release.git'
source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '10.0'

target 'ADXSampleSwift' do
  use_frameworks!

  # 라이브러리 전체를 포함할 경우 
  pod 'ADXLibrary', '2.3.1'

  # 네이티브만 포함할 경우
  # pod 'ADXLibrary/Native', '2.3.1'

  # 전면/배너만 포함할 경우
  # pod 'ADXLibrary/Standard', '2.3.1'

  # 리워드만 포함할 경우 
  # pod 'ADXLibrary/Rewarded', '2.3.1'

end

post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
    config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
  end
end