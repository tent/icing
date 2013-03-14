require 'icing/version'

require 'sprockets-sass'
require 'compass'

module Icing
  module Sprockets
    # Append assets path to an existing Sprockets environment
    def self.setup(environment)
      %w[ fonts images stylesheets ].each do |path|
        path = File.expand_path(File.join(File.dirname(__FILE__), 'icing', 'assets', path))
        environment.append_path(path)
      end
    end
  end
end
