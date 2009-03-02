require 'rubygems'
require 'test/unit'
require 'view_fu/meta_helper'
require 'view_fu/tag_helper'

class ViewFuTest < Test::Unit::TestCase

  include ActionView::Helpers::TagHelper
  include ViewFu::TagHelper
  include ViewFu::MetaHelper
  
  def test_truth
    assert true
  end

end
