class TerraformationGenerator < Rails::Generator::Base

  def manifest
    record do |m|
      m.template  'application.html.haml.erb',   'app/views/layouts/application.html.haml'
      m.file      'clear_test_default.rake',     'lib/tasks/clear_test_default.rake'
      m.file      'jquery.js',                   'public/javascripts/jquery.js'
    end
  end

protected

  def banner
    "Usage: #{$0} terraformation"
  end

end
