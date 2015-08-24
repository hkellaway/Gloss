Pod::Spec.new do |s|
  s.name         = "Gloss"
  s.version      = "0.5.1"
  s.summary      = "A shiny JSON parsing library in Swift"
  s.homepage     = "https://github.com/hkellaway/Gloss"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Harlan Kellaway" => "hello@harlankellaway.com" }
  s.source       = { :git => "https://github.com/hkellaway/Gloss.git", :tag => s.version.to_s }
  
  s.platform     = :ios, "8.0"
  s.requires_arc = true

  s.source_files  = 'Source/*.{swift}'

end
