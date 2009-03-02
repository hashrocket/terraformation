require 'rails_generator/generators/components/model/model_generator'
require File.dirname(__FILE__) + '/../terraforming'

class TerramodelGenerator < ModelGenerator
  include Terraforming

  def manifest

    record do |m|
      m.class_collisions class_path, class_name

      m.directory File.join('app/models', class_path)
      m.directory File.join('spec/models', class_path)
      if exemplar?
        m.directory File.join('spec/exemplars', class_path)
      end
      if factory?
        m.directory File.join('spec/factories')
      end

      m.template 'model:model.rb', File.join('app/models', class_path, "#{file_name}.rb")
      m.template 'model_spec.rb.erb', File.join('spec/models', class_path, "#{file_name}_spec.rb")
      if exemplar?
        m.template 'model_exemplar.rb.erb', File.join('spec/exemplars', class_path, "#{file_name}_exemplar.rb")
      end
      if factory?
        m.template 'model_factory.rb.erb', File.join('spec/factories', "#{full_name}_factory.rb")
      end
      if exist?('spec/fixtures')
        m.template 'model:fixtures.yml',  File.join('spec/fixtures', "#{table_name}.yml")
      end

      unless options[:skip_migration]
        m.migration_template 'model:migration.rb', 'db/migrate', :assigns => {
          :migration_name => "Create#{class_name.pluralize.gsub(/::/, '')}"
        }, :migration_file_name => "create_#{file_path.gsub(/\//, '_').pluralize}"
      end

    end
  end

  protected

  def banner
    "Usage: #{$0} terramodel ModelName [field:type field:type]"
  end

  def add_options!(opt)
    super
    opt.on("--[no-]exemplar", "Create Object Daddy Exemplar") { |v| options[:exemplar] = v }
    opt.on("--[no-]factory",  "Create Factory Girl Factory")  { |v| options[:factory]  = v }
  end

end
