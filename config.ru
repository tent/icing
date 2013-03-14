[
  File.expand_path('app', File.dirname( __FILE__)),
  File.expand_path('lib', File.dirname( __FILE__))
].each do |path|
  $LOAD_PATH.unshift(path) unless $LOAD_PATH.include?(path)
end

require 'bundler'
Bundler.require

$stdout.sync = true

require 'app'

map '/' do
  run CustomBootstrap.new
end
