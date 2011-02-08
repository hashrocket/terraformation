Gem::Specification.new do |s|
  s.name = "terraformation"
  s.version = "0.2.2"
  s.summary = "Generators with a Hashrocket twist"
  s.email = "info@hashrocket.com"
  s.homepage = "http://github.com/hashrocket/terraformation"
  s.has_rdoc = false
  s.authors = ["Hashrocket"]
  s.files = %w( LICENSE README.rdoc Rakefile ) + Dir["{bin,rails_generators}/**/*"].sort
  s.extra_rdoc_files = ["README.rdoc", "LICENSE"]
  s.executables = ["terrarails"]
end

