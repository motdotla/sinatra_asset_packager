namespace :assets do
  desc "Precompile assets"
  task :precompile do
    SinatraAssetPackager.precompile
  end
end
