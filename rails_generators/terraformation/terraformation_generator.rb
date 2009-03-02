require File.dirname(__FILE__) + '/../terraforming'

class TerraformationGenerator < Rails::Generator::Base
  DEFAULT_SHEBANG = File.join(Config::CONFIG['bindir'],
                              Config::CONFIG['ruby_install_name'])
  include Terraforming

  def option?(key)
    options.fetch(key, options[:full])
  end

  def manifest
    record do |m|
      m.template  'application.html.haml.erb',   'app/views/layouts/application.html.haml'
      m.file      'jquery.js',                   'public/javascripts/jquery.js'

      if option?(:blueprint)
        m.directory 'public/stylesheets/blueprint'
        m.file      'blueprint/ie.css',          'public/stylesheets/blueprint/ie.css'
        m.file      'blueprint/print.css',       'public/stylesheets/blueprint/print.css'
        m.file      'blueprint/screen.css',      'public/stylesheets/blueprint/screen.css'
      end

      if option?(:gitignore)
        m.file 'gitignore',                      '.gitignore'
        m.file 'null_gitignore',                 'tmp/.gitignore'
        m.file 'null_gitignore',                 'log/.gitignore'
      end

      script_options = { :chmod => 0755, :shebang => options[:shebang] == DEFAULT_SHEBANG ? nil : options[:shebang] }
      if option?(:rspec) || option?(:cucumber)
        m.directory 'lib/tasks'
        m.file      'clear_test_default.rake',     'lib/tasks/clear_test_default.rake'
      end

      if option?(:rspec)
        m.file      'rspec.rake',                    'lib/tasks/rspec.rake'

        m.file      'rspec:script/autospec',         'script/autospec',    script_options
        m.file      'rspec:script/spec',             'script/spec',        script_options
        m.file      'rspec:script/spec_server',      'script/spec_server', script_options

        m.directory 'spec'
        m.file      'rcov.opts',                     'spec/rcov.opts'
        m.file      'spec.opts',                     'spec/spec.opts'
        m.file      'spec_helper.rb',                'spec/spec_helper.rb'
      end

      if option?(:cucumber)
        m.file      'cucumber.rake',                 'lib/tasks/cucumber.rake'
        m.file      'cucumber',                      'script/cucumber',    script_options

        m.directory 'features'
        m.directory 'features/support'
        m.directory 'features/step_definitions'

        m.file      'cucumber:env.rb',               'features/support/env.rb'
        m.file      'paths.rb',                      'features/support/paths.rb'
        m.file      'cucumber:webrat_steps.rb',      'features/step_definitions/webrat_steps.rb'
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
    opt.on("--[no-]gitignore", "Default gitignore") { |v| options[:gitignore] = v }
    opt.on("--[no-]rspec", "Set up RSpec")          { |v| options[:rspec]     = v }
    opt.on("--[no-]cucumber", "Set up Cucumber")    { |v| options[:cucumber]  = v }
    opt.on("--[no-]full", "Everything")             { |v| options[:full]      = v }
  end
end
