namespace :assets do
  desc "Precompile assets"
  task :precompile do
    assets  = SinatraAssetPackager.environment(true)
    dir     = 'public/assets'
    FileUtils.rm_rf(dir, secure: true)

    CSS_EXTENSIONS  = [".less", ".scss", ".sass", ".css"]
    JS_EXTENSIONS   = [".js", ".coffee"]

    (CSS_EXTENSIONS + JS_EXTENSIONS).each do |extension|
      files = Dir.glob("app/assets/**/**#{extension}")
      files.each do |full_filepath|
        regex_path            = /app\/assets\/javascripts\/|app\/assets\/stylesheets\//
        input_path            = full_filepath.gsub(regex_path, '')

        replacement_extension = '.js'
        replacement_extension = '.css' if CSS_EXTENSIONS.include?(extension)
        output_path           = input_path.gsub(extension,  replacement_extension)

        puts output_path
        assets[input_path].write_to("public/assets/#{output_path}")
      end
    end

    FileUtils.cp_r(Dir['app/assets/images/*'], 'public/assets')
    FileUtils.cp_r(Dir['app/assets/templates/*'], 'public/assets')
  end
end