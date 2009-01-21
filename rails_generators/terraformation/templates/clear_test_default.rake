unless File.directory?(File.join(Rails.root,'test'))
  Rake::Task[:default].clear
end
