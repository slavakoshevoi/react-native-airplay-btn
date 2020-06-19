
require 'json'
package = JSON.parse(File.read(File.join(__dir__, '', 'package.json')))

Pod::Spec.new do |s|
  s.name         = "RNAirplay"
  s.version      = package['version']
  s.summary      = package['description']
  s.description  = <<-DESC
                  RNAirplay
                   DESC
  s.homepage     = "https://github.com/slavakoshevoi/react-native-airplay-btn"
  s.license      = package['license']
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.authors      = package['author']
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/slavakoshevoi/react-native-airplay-btn.git", :tag => "master" }
  s.source_files  = "ios/**/*.{h,m}"
  s.requires_arc = true

  s.dependency "React"
  #s.dependency "others"

end

