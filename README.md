# Middleman webpack Helper

A simple Middleman extension that provides a URL helper method for [webpack](http://webpack.github.io/) generated assets.

## Installation

Add `middleman-webpack-helper` to your Gemfile and run `bundle install`.

```ruby
# Gemfile
gem 'middleman-webpack-helper', github: 'iamlacroix/middleman-webpack-helper'
```

## Setup

Activate the extension in your Middleman `config.rb`:

```ruby
activate :webpack_helper, stats_path: 'path/to/your/webpack/stats.json'
```

The `stats_path` option should point to the location of a JSON file generated by [webpack's stats object](http://webpack.github.io/docs/long-term-caching.html#get-filenames-from-stats). The full stats file can be quite large, but all the helper really needs is the `publicPath` and `assets` properties. Here is an example of generating a minimal stats file via your webpack plugins:

```javascript
plugins: [
  this.plugin("done", function(stats) {
    var stats = stats.toJson();

    var manifest = {
      publicPath: stats.publicPath,
      assets: stats.assets,
    };

    fs.writeFileSync(
      path.join(__dirname, "stats.json"),
      JSON.stringify(manifest)
    );
  });
]
```

## Usage

A template helper `webpack_url` will now be available. It takes the non-hashed filename of a JS or CSS asset as its only parameter.

```html
<%= webpack_url('main.js') %>
```

Would output something like this, depending on which hash options you are using:

```html
<!-- A hashed public path -->
/public/path/bc885271ab5c088b3e10/main.js
<!-- Or a hashed name -->
/public/path/main-bc885271ab5c088b3e10.js
```

## TODO

- Tests
- Examples
- External host option (CDN)

## License

Copyright &copy; 2015 Michael LaCroix. [MIT License](LICENSE.md).