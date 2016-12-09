
Pod::Spec.new do |s|
   s.name         = "ToolProject"
   s.version      = "3.0.0"
   s.summary      = "this is a convenience tool class for my working."
   s.homepage     = "https://github.com/afeng159/ToolClass"
   s.license  = 'MIT'
   s.author   = { "424425549@qq.com" => "424425549@qq.com" }
    s.platform  = :ios, '6.0'
   s.source  = { :git => "https://github.com/afeng159/ToolClass.git", :tag => "3.0.0" }
   s.source_files  = "ToolProject/Class/**/*.{h,m}"
   s.public_header_files = "ToolProject/Class/ToolClass.h"
   s.framework  = "Security","QuartzCore"
   s.requires_arc = true

end
