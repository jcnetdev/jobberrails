module BrowserDetect::Helper
  
  # check the current browser (via user agent) for the following:
  # :mozilla
  # :ie6
  # :ie7
  # :ie
  # :safari
  def browser_is? name

    name = name.to_s.strip

    return true if browser_name == name
    return true if name == 'mozilla' && browser_name == 'gecko'
    return true if name == 'ie6' && browser_name.index('ie6')
    return true if name == 'ie7' && browser_name.index('ie7')
    return true if name == 'ie' && browser_name.index('ie')
    return true if name == 'webkit' && browser_name == 'safari'

  end
  
  # find the current browser name
  def browser_name
    @browser_name ||= begin

      ua = request.env['HTTP_USER_AGENT'].to_s.downcase

      if ua.index('msie') && !ua.index('opera') && !ua.index('webtv')
        'ie'+ua[ua.index('msie')+5].chr
      elsif ua.index('gecko/') 
        'gecko'
      elsif ua.index('opera')
        'opera'
      elsif ua.index('konqueror') 
        'konqueror'
      elsif ua.index('applewebkit/')
        'safari'
      elsif ua.index('mozilla/')
        'gecko'
      else
        ""
      end
    end
  end
end