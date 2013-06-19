module SinatraAssetPackager
  class Routes < ::Sinatra::Base
    get "/assets/*.js" do
      content_type("application/javascript")
      filepath = params[:splat][0]
      SinatraAssetPackager.environment["#{filepath}.js"]
    end

    get "/assets/*.css" do
      content_type "text/css", charset: "utf-8"
      filepath = params[:splat][0]
      SinatraAssetPackager.environment["#{filepath}.css"]
    end

    get "/assets/*.html" do
      content_type "text/html"
      filepath = params[:splat][0]
      SinatraAssetPackager.environment["#{filepath}.html"]
    end

    %w{jpg png gif}.each do |format|
      get "/assets/*.#{format}" do
        content_type("image/#{format}")
        SinatraAssetPackager.environment["#{params[:splat][0]}.#{format}"]
      end
    end

    get "/assets/*.svg" do
      content_type("image/svg+xml")
      filepath = params[:splat][0]
      SinatraAssetPackager.environment["#{filepath}.svg"]
    end
  end
end
