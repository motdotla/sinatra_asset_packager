# SinatraAssetPackager

Opinionated asset packaging for Sinatra done well.

Uses Sprockets, Uglifier, and YUI Compressor under the hood.

Make all your (css|scss|sass|less) and (js|coffee) files only end with a single extension. I.E. .coffee instead of .js.coffee. And .sass, instead of .css.sass. This is for a reason. I find Rails' approach of .js.coffee redundant and less readable.

## Installation

Add this line to your application's Gemfile:

    gem 'sinatra_asset_packager'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sinatra_asset_packager

Then in your Sinatra app's config.ru place the following:

    use SinatraAssetPackager::Routes

Recommendation: Go a step further and only run the live asset packager on development. To do so, do the following:

    use SinatraAssetPackager::Routes if ENV['RACK_ENV'] == "development"
    use Rack::Static, :urls => ['/favicon.ico', '/assets'], :root => 'public'

Now Rack::Static will pick the static files up at /assets in production mode.

You also get the following task with it.

    $ rake assets:precompile

If you are using heroku this will precompile your assets on deploy.

## Other Options

Use the javascript_include_tag helper if you want to run multiple js files in development vs compiling all to one js file.

First, add the helpers to your application:

    class Application < Sinatra::Base
      helpers SinatraAssetPackager::Helpers

      get "/" do
        erb :index
      end
    end

Second, in your index.erb file place the following:

    <!DOCTYPE html>
    <html>
    <head>
      <title>YourApp</title>
      <link href="/assets/application.css" media="all" rel="stylesheet" type="text/css" />
      <%= javascript_include_tag :application %>
    </head>
    <body>
      ...
    </body>
    </html>

Now the output will be multiple js files (similar to Rails Asset Pipeline setup) in development, but will be compiled to one in production and staging environments. Furthermore, if you want to use the helper and still compile do the following:

    <%= javascript_include_tag :application, compile: true %>

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
