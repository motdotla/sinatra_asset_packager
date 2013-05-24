module SinatraAssetPackager
  module Helpers
    def javascript_include_tag(source, options={})
      if !!options[:compress] || ["production", "staging"].include?(ENV["RACK_ENV"])
        "<script src='/assets/#{source}.js' type='text/javascript'></script>"
      else
        javascript = SinatraAssetPackager.environment["#{source}.js"]
        javascript.dependencies.map do |script|
          leading_replace   = [Dir.pwd, "app", "assets", "javascripts/"].join("/")
          ending_replace    = /\.js|\.coffee$/
          relative_path     = script.pathname.to_s.gsub(leading_replace, "").gsub(ending_replace, "")
          
          "<script src='/assets/#{relative_path}.js' type='text/javascript'></script>"
        end.flatten.uniq.join("\n")
      end
    end
  end
end