require 'icing/compiler'

namespace :assets do
  task :compile do
    Icing::Compiler.compile_assets
  end

  task :gzip do
    Icing::Compiler.gzip_assets
  end

  task :precompile => :gzip
end
