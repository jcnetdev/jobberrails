Gem::Specification.new do |s|
  s.name = 'view_fu'
  s.version = '0.9.5'
  s.date = '2008-11-15'
  
  s.summary = "Lots of handy Rails View helpers. Includes the functionality of Headliner, Styler, and Javascripter"
  s.description = "ViewFu is a Rails plugin that provides all the miscellaneous View tasks. It's a combination of the functionality of Styler, Javascripter, and Headline (from Patrick Crowley, the.railsi.st) - along with additional tweaks such as providing commonly used View Helpers Methods."
  
  s.authors = ['Tyler Crocker']
  s.email = 'neorails@gmail.com'
  s.homepage = 'http://github.com/neorails/view_fu'
  
  s.has_rdoc = true
  s.rdoc_options = ["--main", "README"]
  s.extra_rdoc_files = ["README"]

  s.add_dependency 'rails', ['>= 2.1']
  
  s.files = ["MIT-LICENSE",
             "README",
             "Rakefile",
             "init.rb",
             "lib/browser_detect/helper.rb",
             "lib/headliner/helper.rb",
             "lib/headliner/README",
             "lib/javascripter/helper.rb",
             "lib/javascripter/README",
             "lib/styler/helper.rb",
             "lib/styler/README",
             "lib/view_fu/meta_helper.rb",
             "lib/view_fu/tag_helper.rb",
             "lib/view_fu/controller_extensions.rb",
             "lib/view_fu.rb",
             "rails/init.rb",
             "view_fu.gemspec"]
  
  s.test_files = ["test/browser_detect_test.rb",
                  "test/headliner_test.rb",
                  "test/styler_test.rb",
                  "test/view_fu_test.rb"]

end