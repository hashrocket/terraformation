require 'rake/rdoctask'
require 'rake/gempackagetask'
require 'fileutils'

spec = Gem::Specification.new do |s|
  s.name = "terraformation"
  s.version = "0.1.2"
  s.summary = "Generators with a Hashrocket twist"
  s.email = "info@hashrocket.com"
  s.homepage = "http://github.com/hashrocket/terraformation"
  s.has_rdoc = false
  s.authors = ["Hashrocket"]
  s.files = %w( LICENSE README.rdoc Rakefile ) + Dir["{bin,rails_generators}/**/*"].sort
  s.extra_rdoc_files = ["README.rdoc", "LICENSE"]
  s.executables = ["terrarails"]
  s.add_dependency("haml", "2.2.14")
  s.add_dependency("rspec-rails", "1.2.9")
  s.add_dependency("cucumber", "0.4.4")
  s.add_dependency("webrat", "0.5.3")
end

Rake::GemPackageTask.new(spec) do |package|
  package.gem_spec = spec
end

desc "Install terraformation"
task :install => :repackage do
  sh %{sudo gem install pkg/#{spec.name}-#{spec.version}}
end
