lib = File.expand_path('lib', File.dirname( __FILE__))
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'bundler'
Bundler.require

$stdout.sync = true

require 'app'

map '/' do
  run CustomBootstrap.new
end
