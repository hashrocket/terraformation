require 'rake/rdoctask'
require 'rake/gempackagetask'
require 'fileutils'

spec = eval(File.read(File.join(File.dirname(__FILE__), 'terraformation.gemspec')))

Rake::GemPackageTask.new(spec) do |package|
  package.gem_spec = spec
end

desc "Install terraformation"
task :install => :repackage do
  sh %{sudo gem install pkg/#{spec.name}-#{spec.version}}
end
