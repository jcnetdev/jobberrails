require 'active_support'

module Rails
  class Configuration
    
    # Adds a single Gem dependency from GitHub
    #   
    #   # declare a github gem plugin
    #   config.github_gem 'jcnetdev-better_partials'
    #
    #   # equivalent to:
    #   config.gem 'jcnetdev-better_partials', :lib => 'better_partials', :source => 'http://gems.github.com'
    def github_gem(name, options = {})
      
      # set lib name
      name_parts = name.split("-")
      if name_parts.size > 1
        lib = name.gsub("#{name_parts.first}-", "")
      else
        lib = name
      end
      
      # set defaults
      options.reverse_merge!(:lib => lib, :source => 'http://gems.github.com')
      
      # add rails dependency
      @gems << Rails::GemDependency.new(name, options)
    end

  end
end