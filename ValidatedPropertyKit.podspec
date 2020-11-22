Pod::Spec.new do |s|
  s.name                      = "ValidatedPropertyKit"
  s.version                   = "0.0.5"
  s.summary                   = "ValidatedPropertyKit"
  s.homepage                  = "https://github.com/SvenTiigi/ValidatedPropertyKit"
  s.license                   = { :type => "MIT", :file => "LICENSE" }
  s.author                    = { "Sven Tiigi" => "sven.tiigi@gmail.com" }
  s.source                    = { :git => "https://github.com/SvenTiigi/ValidatedPropertyKit.git", :tag => s.version.to_s }
  s.swift_version             = "5.2"
  s.ios.deployment_target     = "13.0"
  s.tvos.deployment_target    = "13.0"
  s.watchos.deployment_target = "6.0"
  s.osx.deployment_target     = "10.15"
  s.source_files              = "Sources/**/*"
  s.frameworks                = "Foundation"
end
