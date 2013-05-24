require "rake"
require "sprockets"
require "uglifier"
require "yui/compressor"
require "sinatra/base"
require "sinatra_asset_packager/version"
require "sinatra_asset_packager/helpers"
require "sinatra_asset_packager/routes"
require "sinatra_asset_packager/rake"

module SinatraAssetPackager
  extend self

  def environment(compress=false)
    environment = (Sprockets::Environment.new { |env|
      env.append_path("app/assets/images")
      env.append_path("app/assets/javascripts")
      env.append_path("app/assets/stylesheets")
      env.append_path("app/assets/templates")
      
      if !!compress || ["production", "staging"].include?(ENV["RACK_ENV"])
        env.js_compressor  = Uglifier.new(mangle: true)
        env.css_compressor = YUI::CssCompressor.new
      end
    })

    return environment
  end
end