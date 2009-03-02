module NavigationHelpers
  def path_to(page_name)
    case page_name

    when 'the homepage'
      root_path

    when /^the ([\w ]+) page$/
      send("#{page_name.gsub(/\W+/, '_')}_path")

    else
      raise "Can't find mapping from \"#{page_name}\" to a path."
    end
  end
end

World do |world|
  world.extend NavigationHelpers
  world
end
