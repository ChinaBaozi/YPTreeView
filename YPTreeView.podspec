Pod::Spec.new do |s|

  s.name         = "YPTreeView"
  s.version      = "0.0.6"
  s.summary      = "easy-to-use interface of the tree structure"
  s.description  = <<-DESC
                   easy-to-use interface of the tree structure,thank for you use it.
                   DESC
  s.homepage     = "http://www.jianshu.com/p/fe67139f8716"
  # s.screenshots = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

  s.license      = "MIT"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "ChinaBaozi" => "chinabaozi@yeah.net" }
  s.platform     = :ios

  s.source       = { :git => "https://github.com/ChinaBaozi/YPTreeView.git", :tag => "0.0.6" }
  s.source_files   = "Classes", "YPTreeView/Classes/*.{h,m}"
  #s.exclude_files = "Classes/Exclude"
  s.public_header_files = "Classes/YPTreeView.h","Classes/YPTreeNode.h"

  s.resource     = "Classes/Resources/YPTreeView.bundle"
  s.requires_arc = true


end
