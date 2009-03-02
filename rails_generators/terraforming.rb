module Terraforming

  def exist?(file)
    File.exist?(destination_path(file))
  end

  def exemplar?
    options[:exemplar] || options[:exemplar].nil? && exist?('spec/exemplars')
  end

  def factory?
    options[:factory] || options[:factory].nil? && exist?('spec/factories')
  end

  def attributes
    views
    super
  end

  def full_name
    (class_path + [singular_name]).join("_")
  end

  def views
    return @views if @views
    @views = []
    args.delete_if do |arg|
      @views << case arg
        when /^\w+\.\w+\.\w+$/ then arg
        when /^\w+$/ then "#{arg}.html.haml"
        when /^\w+\.js$/ then "#{arg}.rjs"
        when /^\w+\.(?:html|fbml)$/ then "#{arg}.haml"
        when /^\w+\.(?:xml|rss|atom)$/ then "#{arg}.builder"
        when /^\w+\.\w+$/ then "#{arg}.erb"
        else next
      end
    end
    @views.compact!
    @views
  end

  def actions
    views.map do |arg|
      arg.sub(/\..*$/,'')
    end.uniq.reject do |arg|
      arg =~ /^_/
    end
  end

end
