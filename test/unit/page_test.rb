require 'test_helper'

class PageTest < ActiveSupport::TestCase
  
  def test_valid
    page = Page.new
    page.title = 'Temporary page title'
    page.url = 'page_url'
    
    assert_valid page
  end
  
  def test_create
    page = Page.new(:title => 'Some new title', :url => 'myurl')
    page.save
    
    assert_equal page, Page.find(page.id) 
  end
  
  def test_have_title
    page = Page.new(:url => "url")
    
    assert !page.save
  end
  
  def test_have_title_error    
    page = Page.new(:url => "new_url")
    page.save
    
    assert_equal "Please fill in the Title.", page.errors[:title]
  end
  
  def test_have_url
    page = Page.new(:title => "My title")
    
    assert !page.save
  end
  
  def test_have_url_error    
    page = Page.new(:title => "Hello there")
    page.save
    
    assert_equal ["Please fill in the URL.",
      "The URL must contain only alphanumerical characters, dashed and underscores."], 
      page.errors[:url]
  end
  
  def test_have_unique_url
    page = Page.new(:title => 'Foo', :url => 'unique_url')
    page.save
    
    page1 = Page.new(:title => 'Foo foo', :url => 'unique_url')
    assert !page1.save
  end
  
  def test_have_unique_url_error
    page = Page.new(:title => 'Foo', :url => 'unique_url')
    page.save
    
    page1 = Page.new(:title => 'Foo foo', :url => 'unique_url')
    page1.save
    assert_equal "The URL is already in use. Please select another URL.", page1.errors[:url]
  end
end
