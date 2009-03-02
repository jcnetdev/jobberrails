require 'rubygems'
require 'test/unit'
require 'styler/helper'

class StylerTest < Test::Unit::TestCase

  include ActionView::Helpers::TagHelper
  include Styler::Helper
  
  def test_truth
    assert true
  end

end
