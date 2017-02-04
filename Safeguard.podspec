
Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.name         = "Safeguard"
  s.version      = "1.0.0"
  s.summary      = "A lightweight, flexible tool to help identify and log issues lost in Swift's guard statements."

  s.description  = <<-DESC
  Safeguard is a lightweight tool that extends Swift's Optional and provides simple logging configuration to help you identify areas in your code where you may have silent failures occurring more often than you'd think.
                   DESC

  s.homepage     = "http://www.instacart.com"
  s.license      = "MIT"
  s.author             = { "Dan" => "daniel.h.loman@gmail.com" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => 'https://github.com/namolnad/Safeguard.git', :tag => "v" + s.version.to_s }
  s.source_files  = "Safeguard", "Safeguard/**/*.{h,m,swift}"

end
