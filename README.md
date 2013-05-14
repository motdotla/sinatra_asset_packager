# SinatraAssetPackager

Opinionated asset packaging for Sinatra done well.

Uses Sprockets, Uglifier, and YUI Compressor under the hood.

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

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
