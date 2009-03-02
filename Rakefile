require 'rake/rdoctask'
require 'rake/gempackagetask'
require 'fileutils'

spec = Gem::Specification.new do |s|
  s.name = "hashrocket-terraformation"
  s.version = '0.0.0'
  s.summary = "Terraform your app with style"
  s.email = "info@hashrocket.com"
  s.homepage = "http://github.com/hashrocket/terraformation"
  s.has_rdoc = false
  s.authors = ["a team of ravenous rocketeers"]
  s.files = %w( LICENSE README.rdoc Rakefile ) + Dir["{rails_generators}/**/*"].sort
  s.extra_rdoc_files = ["README.rdoc", "LICENSE"]
end

Rake::GemPackageTask.new(spec) do |package|
  package.gem_spec = spec
end

desc "Generate the static gemspec required for github"
task :gemspec do
  open("terraformation.gemspec", "w").write(spec.to_ruby)
end

desc "Install terraformation"
task :install => :repackage do
  sh %{sudo gem install pkg/#{spec.name}-#{spec.version}}
end