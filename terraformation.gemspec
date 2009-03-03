# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{hashrocket-terraformation}
  s.version = "0.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["a team of ravenous rocketeers"]
  s.date = %q{2009-03-04}
  s.default_executable = %q{terrarails}
  s.email = %q{info@hashrocket.com}
  s.executables = ["terrarails"]
  s.extra_rdoc_files = ["README.rdoc", "LICENSE"]
  s.files = ["LICENSE", "README.rdoc", "Rakefile", "bin/terrarails", "rails_generators/terracontroller", "rails_generators/terracontroller/USAGE", "rails_generators/terracontroller/templates", "rails_generators/terracontroller/templates/controller_spec.rb.erb", "rails_generators/terracontroller/templates/view.builder.erb", "rails_generators/terracontroller/templates/view.erb", "rails_generators/terracontroller/templates/view.haml.erb", "rails_generators/terracontroller/templates/view.rjs.erb", "rails_generators/terracontroller/templates/view.rss.builder.erb", "rails_generators/terracontroller/templates/view_spec.rb.erb", "rails_generators/terracontroller/terracontroller_generator.rb", "rails_generators/terraformation", "rails_generators/terraformation/USAGE", "rails_generators/terraformation/templates", "rails_generators/terraformation/templates/application.html.haml.erb", "rails_generators/terraformation/templates/blueprint", "rails_generators/terraformation/templates/blueprint/ie.css", "rails_generators/terraformation/templates/blueprint/print.css", "rails_generators/terraformation/templates/blueprint/screen.css", "rails_generators/terraformation/templates/clear_test_default.rake", "rails_generators/terraformation/templates/cucumber", "rails_generators/terraformation/templates/cucumber.rake", "rails_generators/terraformation/templates/gitignore", "rails_generators/terraformation/templates/jquery.js", "rails_generators/terraformation/templates/null_gitignore", "rails_generators/terraformation/templates/paths.rb", "rails_generators/terraformation/templates/rcov.opts", "rails_generators/terraformation/templates/rspec.rake", "rails_generators/terraformation/templates/spec.opts", "rails_generators/terraformation/templates/spec_helper.rb", "rails_generators/terraformation/terraformation_generator.rb", "rails_generators/terraforming.rb", "rails_generators/terrahelper", "rails_generators/terrahelper/USAGE", "rails_generators/terrahelper/templates", "rails_generators/terrahelper/templates/helper.rb.erb", "rails_generators/terrahelper/templates/helper_spec.rb.erb", "rails_generators/terrahelper/terrahelper_generator.rb", "rails_generators/terramodel", "rails_generators/terramodel/USAGE", "rails_generators/terramodel/templates", "rails_generators/terramodel/templates/model_exemplar.rb.erb", "rails_generators/terramodel/templates/model_factory.rb.erb", "rails_generators/terramodel/templates/model_spec.rb.erb", "rails_generators/terramodel/terramodel_generator.rb", "rails_generators/terraresource", "rails_generators/terraresource/USAGE", "rails_generators/terraresource/templates", "rails_generators/terraresource/terraresource_generator.rb", "rails_generators/terrascaffold", "rails_generators/terrascaffold/USAGE", "rails_generators/terrascaffold/templates", "rails_generators/terrascaffold/templates/controller.rb.erb", "rails_generators/terrascaffold/templates/controller_spec.rb.erb", "rails_generators/terrascaffold/templates/partial_form.html.haml.erb", "rails_generators/terrascaffold/templates/view_edit.html.haml.erb", "rails_generators/terrascaffold/templates/view_edit.html_spec.rb.erb", "rails_generators/terrascaffold/templates/view_index.html.haml.erb", "rails_generators/terrascaffold/templates/view_index.html_spec.rb.erb", "rails_generators/terrascaffold/templates/view_new.html.haml.erb", "rails_generators/terrascaffold/templates/view_new.html_spec.rb.erb", "rails_generators/terrascaffold/templates/view_show.html.haml.erb", "rails_generators/terrascaffold/templates/view_show.html_spec.rb.erb", "rails_generators/terrascaffold/terrascaffold_generator.rb"]
  s.homepage = %q{http://github.com/hashrocket/terraformation}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Terraform your app with style}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
