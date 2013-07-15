Customized Bootstrap CSS.

## Usage

### Basic

```ruby
require 'sprockets'
require 'icing'

environment = Sprockets::Environment.new
Icing::Sprockets.setup(environment)
```

```css
//= require icing
```

### Compiling

```ruby
require 'icing/compiler'

# Compile assets
Icing::Compiler.compile_assets(
  :compress => true, # optional, defaults to false
  :logfile => '/dev/null', # optional, defaults to STDOUT
  :assets_dir => "./public/assets" # optional, defaults to {icing_gem_root}/public/assets
)

# Compile and gzip assets
Icing::Compiler.gzip_assets(
  :compress => true, # optional, defaults to true
  :logfile => '/dev/null', # optional, defaults to STDOUT
  :assets_dir => "./public/assets" # optional, defaults to {icing_gem_root}/public/assets
)
```

OR

```ruby
# Rakefile

namespace :icing do
  require 'icing/tasks/assets'
end

namespace :assets do
  task :precompile => ['icing:assets:precompile'] do
  end
end
```

## Development

### Setup

```
git clone git://github.com/tent/icing.git
cd custom-bootstrap
bundle
bundle exec puma
```

### Editing

- HTML:`lib/views/*.erb`
- CSS: `assets/stylesheets/*`
- Images: `assets/images/*`

Assets are processed though sprockets.
