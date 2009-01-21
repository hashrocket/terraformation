require 'rails_generator/generators/components/controller/controller_generator'

class TerrahelperGenerator < ControllerGenerator

  def manifest
    record do |m|
      m.class_collisions class_path, "#{class_name}Helper"

      m.directory File.join('app/helpers', class_path)
      m.directory File.join('spec/helpers', class_path)

      m.template 'helper_spec.rb.erb',
        File.join('spec/helpers', class_path, "#{file_name}_helper_spec.rb")

      m.template 'helper.rb.erb',
        File.join('app/helpers', class_path, "#{file_name}_helper.rb")

    end
  end
end
