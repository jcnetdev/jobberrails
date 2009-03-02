require 'rubygems'
require 'test/unit'
require 'browser_detect/helper'

class BrowserDetectTest < Test::Unit::TestCase

  include ActionView::Helpers::TagHelper
  include BrowserDetect::Helper
  
  def test_truth
    assert true
  end

end
