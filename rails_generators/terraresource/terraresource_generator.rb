require File.dirname(__FILE__) + '/../terraforming'

class TerraresourceGenerator < Rails::Generator::NamedBase
  include Terraforming

  default_options :skip_migration => false

  attr_reader   :controller_class_path,
                :controller_class_name,
                :controller_file_name

  def initialize(runtime_args, runtime_options = {})
    super

    @controller_name = @name.pluralize

    base_name, @controller_class_path, @controller_file_path, @controller_class_nesting, @controller_class_nesting_depth = extract_modules(@controller_name)
    @controller_class_name_without_nesting, @controller_file_name = inflect_names(base_name)

    if @controller_class_nesting.empty?
      @controller_class_name = @controller_class_name_without_nesting
    else
      @controller_class_name = "#{@controller_class_nesting}::#{@controller_class_name_without_nesting}"
    end

    @resource_generator = "scaffold"
    @default_template_engine = "haml"
  end

  def manifest
    record do |m|
      views

      m.class_collisions(controller_class_path, "#{controller_class_name}Controller")
      m.class_collisions(class_path, "#{class_name}")

      m.directory(File.join('app/models', class_path))
      m.directory(File.join('app/controllers', controller_class_path))
      m.directory(File.join('app/views', controller_class_path, controller_file_name))
      m.directory(File.join('spec/controllers', controller_class_path))
      m.directory(File.join('spec/models', class_path))
      m.directory File.join('spec/views', controller_class_path, controller_file_name)

      m.template 'terracontroller:controller_spec.rb.erb',
        File.join('spec/controllers', controller_class_path, "#{controller_file_name}_controller_spec.rb"),
        :assigns => {:class_name => @controller_class_name}

      m.template 'resource:controller.rb',
        File.join('app/controllers', controller_class_path, "#{controller_file_name}_controller.rb")

      views.each do |view|
        name, format, engine = view.split('.')
        m.template 'terracontroller:view_spec.rb.erb',
          File.join('spec/views', controller_class_path, controller_file_name, "#{name}.#{format}_spec.rb"),
          :assigns => { :name => name, :format => format, :engine => engine, :class_name => controller_class_name, :class_nesting_depth => @controller_class_nesting_depth }
        path = File.join('app/views', controller_class_path, controller_file_name, view)
        template = ["terracontroller:view.#{format}.#{engine}.erb", "terracontroller:view.#{engine}.erb", "terracontroller:view.erb"].detect {|f| File.exist?(source_path(f))}
        m.template template,
          path,
          :assigns => { :action => "#{name}.#{format}", :path => path }
      end
      m.route_resources controller_file_name

      m.dependency 'terramodel', [name] + args, :collision => 'skip'
    end
  end

  protected
    def banner
      "Usage: #{$0} terraresource ModelName [field:type action.format.engine]"
    end

    def add_options!(opt)
      opt.separator ''
      opt.separator 'Options:'
      opt.on("--skip-timestamps",
              "Don't add timestamps to the migration file for this model") { |v| options[:skip_timestamps] = true }
      opt.on("--skip-migration",
             "Don't generate a migration file for this model") { |v| options[:skip_migration] = v }
      opt.on("--skip-fixture",
             "Don't generation a fixture file for this model") { |v| options[:skip_fixture] = v }
      opt.on("--[no-]exemplar", "Create Object Daddy Exemplar") { |v| options[:exemplar] = v }
      opt.on("--[no-]factory",  "Create Factory Girl Factory")  { |v| options[:factory]  = v }
    end

    def scaffold_views
      %w[ index show new edit ]
    end

    def model_name
      class_name.demodulize
    end

end
