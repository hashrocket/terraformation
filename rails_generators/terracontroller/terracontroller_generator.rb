require 'rails_generator/generators/components/controller/controller_generator'
require File.dirname(__FILE__) + '/../terraforming'

class TerracontrollerGenerator < ControllerGenerator
  include Terraforming

  def manifest
    record do |m|
      views
      usage unless args.empty?

      m.class_collisions class_path, "#{class_name}Controller"

      m.directory File.join('app/controllers', class_path)
      m.directory File.join('app/views', class_path, file_name)
      m.directory File.join('spec/controllers', class_path)
      m.directory File.join('spec/views', class_path, file_name)

      m.template 'controller_spec.rb.erb',
        File.join('spec/controllers', class_path, "#{file_name}_controller_spec.rb")
      m.template 'controller:controller.rb',
        File.join('app/controllers', class_path, "#{file_name}_controller.rb")

      views.each do |view|
        name, format, engine = view.split('.')
        m.template 'view_spec.rb.erb',
          File.join('spec/views', class_path, file_name, "#{name}.#{format}_spec.rb"),
          :assigns => { :name => name, :format => format, :engine => engine }
        path = File.join('app/views', class_path, file_name, view)
        template = ["view.#{format}.#{engine}.erb", "view.#{engine}.erb", "view.erb"].detect {|f| File.exist?(source_path(f))}
        m.template template,
          path,
          :assigns => { :action => "#{name}.#{format}", :path => path }
      end
    end
  end

  protected

  def banner
    "Usage: #{$0} terracontroller ControllerName [action]"
  end

end
