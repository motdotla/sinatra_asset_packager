require "rake"
require "sprockets"
require "uglifier"
require "yui/compressor"
require "sinatra/base"
require "compass"
require "sinatra_asset_packager/version"
require "sinatra_asset_packager/helpers"
require "sinatra_asset_packager/routes"
require "sinatra_asset_packager/rake"

module SinatraAssetPackager
  extend self

  @@environment
  
  PUBLIC_ASSETS_DIRECTORY   = "public/assets"
  CSS_EXTENSIONS            = [".less", ".scss", ".sass", ".css"]
  JS_EXTENSIONS             = [".js", ".coffee"]

  def environment(compress=false)
    @@environment ||= (Sprockets::Environment.new { |env|
      env.append_path("app/assets/images")
      env.append_path("app/assets/javascripts")
      env.append_path("app/assets/stylesheets")
      env.append_path("app/assets/templates")
      
      if !!compress || ["production", "staging"].include?(ENV["RACK_ENV"])
        env.js_compressor  = Uglifier.new(mangle: true)
        env.css_compressor = YUI::CssCompressor.new
      end
    })
  end

  def precompile
    FileUtils.rm_rf(PUBLIC_ASSETS_DIRECTORY, secure: true)
    FileUtils.mkdir_p(PUBLIC_ASSETS_DIRECTORY)
    
    (CSS_EXTENSIONS + JS_EXTENSIONS).each do |extension|
      files = Dir.glob("app/assets/**/**#{extension}")
      files.each do |full_filepath|
        regex_path            = /app\/assets\/javascripts\/|app\/assets\/stylesheets\//
        input_path            = full_filepath.gsub(regex_path, '')

        write_asset input_path, output_path(input_path, extension)
      end
    end

    FileUtils.cp_r(Dir['app/assets/images/*'], PUBLIC_ASSETS_DIRECTORY) 
    FileUtils.cp_r(Dir['app/assets/templates/*'], PUBLIC_ASSETS_DIRECTORY) 
  end

  def write_asset(input_path, output_path)
    puts output_path
    final_output_path = [PUBLIC_ASSETS_DIRECTORY, output_path].join("/")
    environment(true)[input_path].write_to(final_output_path)
  rescue => e
    puts e
    puts "Asset #{input_path} failed to compile to #{output_path}"
  end

  def output_path(input_path, extension)
    replacement_extension = '.js'
    replacement_extension = '.css' if CSS_EXTENSIONS.include?(extension)
    input_path.gsub(extension,  replacement_extension)
  end
end
