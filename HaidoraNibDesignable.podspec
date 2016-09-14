Pod::Spec.new do |s|
  s.name             = 'HaidoraNibDesignable'
  s.version          = '0.1.0'
  s.summary          = 'IBDesignable on your nib-based views.'
  s.description      = <<-DESC
                        IBDesignable on your nib-based views.
                       DESC

  s.homepage         = 'https://github.com/mbogh/NibDesignable'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'mrdaios' => 'mrdaios@gmail.com' }
  s.source           = { :git => 'https://github.com/mbogh/NibDesignable.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files = 'HaidoraNibDesignable/Classes/**/*'
end
