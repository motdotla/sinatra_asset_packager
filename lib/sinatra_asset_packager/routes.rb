module SinatraAssetPackager
  class Routes < ::Sinatra::Base
    get "/assets/*.js" do
      content_type("application/javascript")
      filepath = params[:splat][0]
      SinatraAssetPackager.environment["#{filepath}.js"]
    end

    get "/assets/*.css" do |path|
      content_type "text/css", charset: "utf-8"
      filepath = params[:splat][0]
      SinatraAssetPackager.environment["#{filepath}.css"]
    end

    %w{jpg png gif}.each do |format|
      get "/assets/*.#{format}" do
        content_type("image/#{format}")
        SinatraAssetPackager.environment["#{params[:splat][0]}.#{format}"]
      end
    end
  end
end
