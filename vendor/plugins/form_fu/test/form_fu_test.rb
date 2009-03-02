require 'rubygems'
require 'test/unit'
require 'form_fu'

class FormFuTest < Test::Unit::TestCase

  include ActionView::Helpers::TagHelper
  include FormFu::Helpers
  
  def test_truth
    assert true
  end

end
