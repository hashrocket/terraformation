require File.dirname(__FILE__) + '/../terraforming'

class TerraformationGenerator < Rails::Generator::Base
  include Terraforming

  def option?(key)
    options.fetch(key, options[:full])
  end

  def manifest
    record do |m|
      m.directory File.join('public/stylesheets/blueprint') if options[:blueprint]
      m.file      'clear_test_default.rake',     'lib/tasks/clear_test_default.rake'
      m.template  'application.html.haml.erb',   'app/views/layouts/application.html.haml'
      m.file      'jquery.js',                   'public/javascripts/jquery.js'
      if option?(:blueprint)
        m.file 'blueprint/ie.css',               'public/stylesheets/blueprint/ie.css'
        m.file 'blueprint/print.css',            'public/stylesheets/blueprint/print.css'
        m.file 'blueprint/screen.css',           'public/stylesheets/blueprint/screen.css'
      end
      if option?(:gitignore)
        m.file 'gitignore',                      '.gitignore'
        m.file 'null_gitignore',                 'tmp/.gitignore'
        m.file 'null_gitignore',                 'log/.gitignore'
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
    opt.on("--[no-]full", "Everything")             { |v| options[:full]      = v }
  end
end
