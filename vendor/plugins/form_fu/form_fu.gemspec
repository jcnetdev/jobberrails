Gem::Specification.new do |s|
  s.name = 'form_fu'
  s.version = '0.7'
  s.date = '2008-11-18'
  
  s.summary = "Build Nice DRY Rails Forms"
  s.description = "FormFu is a Rails plugin that enables you to easily build nice, tableless forms"
   
  s.authors = ['Tyler Crocker']
  s.email = 'neorails@gmail.com'
  s.homepage = 'http://github.com/neorails/form_fu'
  
  s.has_rdoc = true
  s.rdoc_options = ["--main", "README"]
  s.extra_rdoc_files = ["README"]

  s.add_dependency 'rails', ['>= 2.1']

  s.files = ["LICENSE",
             "README",
             "form_fu.gemspec",
             "init.rb",
             "lib/form_fu/form_builder.rb",
             "lib/form_fu/helpers.rb",
             "lib/form_fu.rb",
             "rails/init.rb"]

  s.test_files = ["test/form_fu_test.rb"]

end