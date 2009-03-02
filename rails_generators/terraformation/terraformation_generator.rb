class TerraformationGenerator < Rails::Generator::Base

  def manifest
    record do |m|
      m.directory File.join('public/stylesheets/blueprint') if options[:blueprint]
      m.file      'clear_test_default.rake',     'lib/tasks/clear_test_default.rake'
      m.template  'application.html.haml.erb',   'app/views/layouts/application.html.haml'
      m.file      'jquery.js',                   'public/javascripts/jquery.js'
      if options[:blueprint]
        m.file 'blueprint/ie.css',               'public/stylesheets/blueprint/ie.css'
        m.file 'blueprint/print.css',            'public/stylesheets/blueprint/print.css'
        m.file 'blueprint/screen.css',           'public/stylesheets/blueprint/screen.css'
      end
    end
  end

  protected

  def banner
    "Usage: #{$0} terraformation"
  end

  def add_options!(opt)
    super
    opt.on("--[no-]blueprint", "Install Blueprint") { |v| options[:blueprint] = v }
  end
end
