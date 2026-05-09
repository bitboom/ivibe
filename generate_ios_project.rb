require 'xcodeproj'

project_path = 'ios/ivibe.xcodeproj'
project = Xcodeproj::Project.new(project_path)
project.instance_variable_set(:@object_version, 77)

app_target = project.new_target(:application, 'ivibe', :ios, '26.0')
app_target.product_name = 'ivibe'
app_target.product_reference.path = 'ivibe.app'

files_group = project.main_group.new_group('ivibe', 'ivibe')
Dir['ios/ivibe/**/*.swift'].sort.each do |path|
  file = files_group.new_file(File.basename(path))
  app_target.source_build_phase.add_file_reference(file)
end

app_target.build_configurations.each do |config|
  config.build_settings['PRODUCT_BUNDLE_IDENTIFIER'] = 'com.bitboom.ivibe'
  config.build_settings['PRODUCT_NAME'] = 'ivibe'
  config.build_settings['INFOPLIST_KEY_CFBundleDisplayName'] = 'ivibe'
  config.build_settings['INFOPLIST_KEY_UILaunchScreen_Generation'] = 'YES'
  config.build_settings['GENERATE_INFOPLIST_FILE'] = 'YES'
  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '26.0'
  config.build_settings['SWIFT_VERSION'] = '5.0'
  config.build_settings['TARGETED_DEVICE_FAMILY'] = '1'
  config.build_settings['SUPPORTED_PLATFORMS'] = 'iphoneos iphonesimulator'
  config.build_settings['CODE_SIGNING_ALLOWED'] = 'NO'
  config.build_settings['ASSETCATALOG_COMPILER_GLOBAL_ACCENT_COLOR_NAME'] = 'AccentColor'
  config.build_settings['ENABLE_PREVIEWS'] = 'YES'
end

scheme = Xcodeproj::XCScheme.new
scheme.add_build_target(app_target)
scheme.set_launch_target(app_target)
scheme.save_as(project_path, 'ivibe', true)

project.save
