Customized Bootstrap CSS.

## Usage

```ruby
require 'sprockets'
require 'icing'

environment = Sprockets::Environment.new
Icing::Sprockets.setup(environment)
```

```css
//= require icing
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
