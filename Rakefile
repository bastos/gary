# Rakefile
require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('gary', '0.1.0') do |p|
  p.description    = "A Web Presentation Creator with Markaby"
  p.url            = "http://github.com/bastos/gary"
  p.author         = "Tiago Bastos"
  p.email          = "comechao@gmail.com"
  p.ignore_pattern = ["tmp/*", "script/*","*.*'~"]
  p.development_dependencies = ["markaby"]
  p.bin_files = "gary"
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }


