require 'sinatra/base'
require 'sprockets'
require 'sass'
require 'sprockets-sass'
require 'compass'

module SprocketsHelpers
  AssetNotFoundError = Class.new(StandardError)
  def asset_path(source, options = {})
    asset = environment.find_asset(source)
    raise AssetNotFoundError.new("#{source.inspect} does not exist within #{environment.paths.inspect}!") unless asset
    "./#{asset.digest_path}"
  end
end

module SprocketsEnvironment
  def self.assets
    return @assets if defined?(@assets)
    puts 'SprocketsEnvironment loaded'
    @assets = Sprockets::Environment.new do |env|
      env.logger = Logger.new(STDOUT)
      env.context_class.class_eval do
        include SprocketsHelpers
      end
    end

    paths = %w{ stylesheets images fonts }
    paths.each do |path|
      @assets.append_path(File.join(File.expand_path('../../', __FILE__), "assets/#{path}"))
    end
    @assets
  end
end

class CustomBootstrap < Sinatra::Base
  configure do
    set :assets, SprocketsEnvironment.assets
    set :views, File.expand_path('views', File.dirname(__FILE__))
  end

  helpers do
    def asset_path(source)
      asset = settings.assets.find_asset(source)
      raise SprocketsHelpers::AssetNotFoundError.new("#{source.inspect} does not exist within #{settings.assets.paths.inspect}!") unless asset
      full_path("/assets/#{asset.digest_path}")
    end

    def path_prefix
      env['SCRIPT_NAME']
    end

    def full_path(path)
      "#{path_prefix}/#{path}".gsub(%r{//}, '/')
    end

    def nav_selected_class(path)
      env['PATH_INFO'] == path ? 'active' : ''
    end
  end

  get '/assets/*' do
    new_env = env.clone
    new_env["PATH_INFO"].gsub!("/assets", "")
    settings.assets.call(new_env)
  end

  get '/favicon.ico' do
    halt 404
  end

  get '/:page' do
    erb params[:page].to_sym
  end
end
