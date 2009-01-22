require File.dirname(__FILE__) + '/../terraforming'

class TerrascaffoldGenerator < Rails::Generator::NamedBase
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

      m.class_collisions(controller_class_path, "#{controller_class_name}Controller")
      m.class_collisions(class_path, "#{class_name}")

      m.directory(File.join('app/controllers', controller_class_path))
      m.directory(File.join('app/views', controller_class_path, controller_file_name))
      m.directory(File.join('spec/controllers', controller_class_path))
      m.directory File.join('spec/views', controller_class_path, controller_file_name)

      m.template 'controller_spec.rb.erb',
        File.join('spec/controllers', controller_class_path, "#{controller_file_name}_controller_spec.rb")

      m.template 'controller.rb.erb',
        File.join('app/controllers', controller_class_path, "#{controller_file_name}_controller.rb")

      for action in scaffold_views
        m.template "view_#{action}.html_spec.rb.erb",
          File.join('spec/views', controller_class_path, controller_file_name, "#{action}.html_spec.rb")
        m.template(
          "view_#{action}.html.#{@default_template_engine}.erb",
          File.join('app/views', controller_class_path, controller_file_name, "#{action}.html.#{@default_template_engine}")
        )
      end
      m.template(
        "partial_form.html.#{@default_template_engine}.erb",
        File.join('app/views', controller_class_path, controller_file_name, "_form.html.#{@default_template_engine}")
      )

      m.dependency 'terramodel', [name] + args, :collision => 'skip'

      m.route_resources controller_file_name

    end
  end

  protected
    def banner
      "Usage: #{$0} terrascaffold ModelName [field:type field:type]"
    end

    def add_options!(opt)
      opt.separator ''
      opt.separator 'Options:'
      opt.on("--skip-migration",
             "Don't generate a migration file for this model") { |v| options[:skip_migration] = v }
      opt.on("--[no-]exemplar", "Create Exemplar") { |v| options[:exemplar] = v }
    end

    def scaffold_views
      %w[ index show new edit ]
    end

    def model_name
      class_name.demodulize
    end

end
