module Terraforming

  def exist?(file)
    File.exist?(destination_path(file))
  end

  def exemplar?
    options[:exemplar] != false && exist?('spec/exemplars')
  end

  def attributes
    views
    super
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
