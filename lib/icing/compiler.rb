require 'icing'

module Icing
  module Compiler
    extend self

    ASSET_NAMES = (%w(
      icing.css
    ) + Dir[File.expand_path(File.join(File.dirname(__FILE__), 'assets', 'fonts', '*'))].map { |path| path.split('/').last }).freeze

    attr_accessor :sprockets_environment, :assets_dir

    def configure_app(options = {})
      return if @app_configured

      Icing.configure(options)

      @app_configured = true
    end

    def configure_sprockets(options = {})
      return if @sprockets_configured

      configure_app

      # Setup Sprockets Environment
      require 'sprockets'
      self.sprockets_environment = ::Sprockets::Environment.new do |env|
        env.logger = Logger.new(options[:logfile] || STDOUT)
        env.context_class.class_eval do
          include Icing::Sprockets::Helpers
        end
      end
      Icing::Sprockets.setup(self.sprockets_environment)

      if options[:compress]
        # Setup asset compression
        require 'sprockets-rainpress'
        sprockets_environment.css_compressor = ::Sprockets::Rainpress
      end

      self.assets_dir ||= options[:assets_dir] || Icing.settings[:public_dir]

      @sprockets_configured = true
    end

    def compile_assets(options = {})
      configure_sprockets(options)

      manifest = ::Sprockets::Manifest.new(
        sprockets_environment,
        assets_dir,
        File.join(assets_dir, "manifest.json")
      )

      manifest.compile(ASSET_NAMES)
    end

    def compress_assets
      compile_assets(:compress => true)
    end

    def gzip_assets(options = {})
      options[:compress] = true unless options.has_key?(:compress)
      compile_assets(options)

      Dir["#{assets_dir}/**/*.*"].reject { |f| f =~ /\.gz\z/ }.each do |f|
        system "gzip -c #{f} > #{f}.gz" unless File.exist?("#{f}.gz")
      end
    end
  end
end

