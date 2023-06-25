# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'

target 'iosdemo' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for iosdemo
    pod 'SnapKit', '~> 5.6.0'

  target 'iosdemoTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'iosdemoUITests' do
    # Pods for testing
  end

end

post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
      config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
    end
end
