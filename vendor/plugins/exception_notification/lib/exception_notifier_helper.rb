require 'pp'

module ExceptionNotifierHelper
  VIEW_PATH = "views/exception_notifier"
  APP_PATH = "#{RAILS_ROOT}/app/#{VIEW_PATH}"
  PARAM_FILTER_REPLACEMENT = "[FILTERED]"

  def render_section(section)
    RAILS_DEFAULT_LOGGER.info("rendering section #{section.inspect}")
    summary = render_overridable(section).strip
    unless summary.blank?
      title = render_overridable(:title, :locals => { :title => section }).strip
      "#{title}\n\n#{summary.gsub(/^/, "  ")}\n\n"
    end
  end

  def render_overridable(partial, options={})
    if File.exist?(path = "#{APP_PATH}/_#{partial}.rhtml")
      render(options.merge(:file => path, :use_full_path => false))
    elsif File.exist?(path = "#{File.dirname(__FILE__)}/../#{VIEW_PATH}/_#{partial}.rhtml")
      render(options.merge(:file => path, :use_full_path => false))
    else
      ""
    end
  end

  def inspect_model_object(model, locals={})
    render_overridable(:inspect_model,
      :locals => { :inspect_model => model,
                   :show_instance_variables => true,
                   :show_attributes => true }.merge(locals))
  end

  def inspect_value(value)
    len = 512
    result = object_to_yaml(value).gsub(/\n/, "\n  ").strip
    result = result[0,len] + "... (#{result.length-len} bytes more)" if result.length > len+20
    result
  end

  def object_to_yaml(object)
    object.to_yaml.sub(/^---\s*/m, "")
  end

  def exclude_raw_post_parameters?
    @controller && @controller.respond_to?(:filter_parameters)
  end
  
  def filter_sensitive_post_data_parameters(parameters)
    exclude_raw_post_parameters? ? @controller.send!(:filter_parameters, parameters) : parameters
  end
  
  def filter_sensitive_post_data_from_env(env_key, env_value)
    return env_value unless exclude_raw_post_parameters?
    return PARAM_FILTER_REPLACEMENT if (env_key =~ /RAW_POST_DATA/i)
    return @controller.send!(:filter_parameters, {env_key => env_value}).values[0]
  end
end
