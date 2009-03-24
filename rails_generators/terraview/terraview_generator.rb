require File.dirname(__FILE__) + '/../terraforming'

class TerraviewGenerator < Rails::Generator::Base
  include Terraforming

  def manifest
    record do |m|
      views
      usage unless args.empty?
      usage unless views.all? {|view| view.include?("/") ? true : p(view)}

      views.map {|view| File.dirname(view)}.each do |dir|
        m.directory File.join('app/views', dir)
        m.directory File.join('spec/views', dir)
      end

      views.each do |view|
        full_name, format, engine = view.split('.')
        class_name, name = File.dirname(full_name).camelize, File.basename(full_name)
        m.template 'terracontroller:view_spec.rb.erb',
          File.join('spec/views', "#{full_name}.#{format}_spec.rb"),
          :assigns => { :class_name => class_name, :name => name, :format => format, :engine => engine }
        path = File.join('app/views', view)
        template = ["terracontroller:view.#{format}.#{engine}.erb", "terracontroller:view.#{engine}.erb", "terracontroller:view.erb"].detect {|f| File.exist?(source_path(f))}
        m.template template,
          path,
          :assigns => { :class_name => class_name, :action => "#{name}.#{format}", :path => path }
      end
    end
  end

  protected

  def banner
    "Usage: #{$0} terraview [controller/action[.format[.engine]]] ..."
  end

end
