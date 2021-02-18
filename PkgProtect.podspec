Pod::Spec.new do |s|
    s.name         = "PkgProtect"
    s.version      = "1.0.1"
    s.summary      = "iOS application package protector"
    s.homepage     = "https://github.com/shotastage/PkgProtect"
    s.license      = "MIT"
    s.author       = { "Shota Shimazu" => "hornet.live.mf@gmail.com" }
   
    s.platform     = :ios, "10.0"
    s.swift_versions = ['5.1', '5.2', '5.3']

    s.source       = { :git => "https://github.com/shotastage/PkgProtect.git", :tag => "#{s.version}" }
    s.source_files = 'PkgProtect/*.{swift, h, m}'
end
