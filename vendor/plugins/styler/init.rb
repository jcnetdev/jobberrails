require 'browser_detect_helper'
ActionView::Base.send(:include, BrowserDetectHelper)

ActionView::Base.send :include, Styler
