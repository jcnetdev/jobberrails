module Rails #:nodoc
    class Configuration #:nodoc
        attr_accessor :app_config
        
        alias :org_default_frameworks :default_frameworks
        # Extends list of known frameworks with app_config.
        # Allows access to config.app_config in environment.rb
        def default_frameworks
            org_default_frameworks + [:app_config]
        end
        
        alias :org_default_load_paths :default_load_paths
        # Modify load path in way that allows access to app_config.rb
        # when AppConfig module is required.
        def default_load_paths
            org_default_load_paths + ["#{root_path}/vendor/plugins/app_config/lib"]
        end
    end
end