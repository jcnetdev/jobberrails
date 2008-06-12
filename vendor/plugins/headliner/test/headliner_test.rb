require 'rubygems'
require 'test/unit'
require File.dirname(__FILE__) + '/../lib/headliner'
require 'action_view/helpers/tag_helper'

class HeadlinerTest < Test::Unit::TestCase

  include ActionView::Helpers::TagHelper
  include Headliner

  # Make the blank? method available without loading Rails
  Object.class_eval do   
    def blank?
      if respond_to?(:empty?) && respond_to?(:strip)
        empty? or strip.empty?
      elsif respond_to?(:empty?)
        empty?
      else
        !self
      end
    end 
  end

  def test_title_is_saved
    title "Headliner", ""
    assert_equal "Headliner", @title
  end

  def test_title_is_saved_with_headline
    headline = save_title "Headliner", "Headliner: a plugin for setting page titles"
    assert_equal "Headliner", @title
    assert_equal "Headliner: a plugin for setting page titles", headline
  end
  
  def test_title_is_site_when_empty
    title :site => "the.railsi.st"
    assert_equal nil, @title
  end

  def test_title_removes_all_tags
    title 'Headliner is <strong class="underline">cool</strong>'
    assert_equal "Headliner is cool", @title
  end

  def test_title_removes_all_tags_but_displays_tags_in_views
    original_title = save_title 'Headliner is <strong class="underline">cool</strong>', ''
    assert_equal "Headliner is cool", @title
    assert_equal 'Headliner is <strong class="underline">cool</strong>', original_title
  end

  def test_title_is_lowercase
    @title = "Headliner"
    full_title = display_title :site => "the.railsi.st", :lowercase => true
    assert_equal "<title>the.railsi.st | headliner</title>", full_title
  end
  
  def test_title_is_reversed
    @title = "Headliner"
    full_title = display_title :site => "the.railsi.st", :reverse => true
    assert_equal "<title>Headliner | the.railsi.st</title>", full_title
  end
  
  def test_title_has_custom_separator
    @title = "Headliner"
    full_title = display_title :site => "the.railsi.st", :separator => "&mdash;"
    assert_equal "<title>the.railsi.st &mdash; Headliner</title>", full_title
  end

  def test_title_has_custom_prefix_and_suffix
    @title = "Headliner"
    full_title = display_title :site => "the.railsi.st", :prefix => "  ", :suffix => "  "
    assert_equal "<title>the.railsi.st  |  Headliner</title>", full_title
  end

  def test_title_has_no_prefix_and_has_custom_separator
    @title = "Headliner"
    full_title = display_title :site => "the.railsi.st", :prefix => false, :separator => ":"
    assert_equal "<title>the.railsi.st: Headliner</title>", full_title
  end

  def test_title_has_no_suffix_and_has_custom_separator
    @title = "Headliner"
    full_title = display_title :site => "the.railsi.st", :suffix => false, :separator => "~"
    assert_equal "<title>the.railsi.st ~Headliner</title>", full_title
  end

  def test_title_has_no_prefix_and_suffix_and_has_custom_separator
    @title = "Headliner"
    full_title = display_title :site => "the.railsi.st", 
                               :prefix => false, 
                               :suffix => false, 
                               :separator => "&mdash;"
    assert_equal "<title>the.railsi.st&mdash;Headliner</title>", full_title
  end

  def test_title_has_all_custom_options
    @title = "Headliner"
    full_title = display_title :site => "the.railsi.st", 
                               :prefix => " ", 
                               :suffix => " ", 
                               :separator => ".:.",
                               :lowercase => true,
                               :reverse => true
    assert_equal "<title>headliner .:. the.railsi.st</title>", full_title
  end

end
