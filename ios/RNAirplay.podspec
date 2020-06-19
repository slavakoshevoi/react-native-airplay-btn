
Pod::Spec.new do |s|
  s.name         = "RNAirplay"
  s.version      = "1.0.0"
  s.summary      = "RNAirplay"
  s.description  = <<-DESC
                  RNAirplay
                   DESC
  s.homepage     = "https://github.com/slavakoshevoi/react-native-airplay-btn.git"
  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.author             = { "author" => "author@domain.cn" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/author/RNAirplay.git", :tag => "master" }
  s.source_files  = "RNAirplay/**/*.{h,m}"
  s.requires_arc = true


  s.dependency "React"
  #s.dependency "others"

end

