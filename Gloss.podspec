Pod::Spec.new do |s|
  s.name         = "Gloss"
  s.version      = "0.1.0"
  s.summary      = "A shiny JSON parsing library in Swift"
  s.homepage     = "https://github.com/hkellaway/Gloss"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Harlan Kellaway" => "hello@harlankellaway.com" }
  s.source       = { :git => "https://github.com/hkellaway/Gloss.git", :tag => s.version.to_s }
  
  s.platform     = :ios, "8.0"
  s.requires_arc = true

  s.source_files  = 'Pod/Classes/*.{h,swift}'

  s.subspec 'Extensions' do |ss|

    ss.source_files = 'Pod/Classes/Extensions/*.{swift}'

  end

end
