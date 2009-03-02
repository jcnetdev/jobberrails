Gem::Specification.new do |s|
  s.name = 'better_partials'
  s.version = '1.1'
  s.date = '2008-10-11'
  
  s.summary = "Makes calling partials in views look better and more fun."
  s.description = "Wrapper around render :partial that removes the need to use :locals, and allows blocks to be taken easily"
  
  s.authors = ['RailsJedi']
  s.email = 'railsjedi@gmail.com'
  s.homepage = 'http://www.railsjedi.com/posts/22'
  
  s.has_rdoc = true
  s.rdoc_options = ["--main", "README"]
  s.extra_rdoc_files = ["README"]

  s.add_dependency 'rails', ['>= 2.1']
  
  s.files = ["MIT-LICENSE",
             "README",
             "Rakefile",
             "better_partials.gemspec",
             "init.rb",
             "lib/better_partials.rb",
             "rails/init.rb",
             "uninstall.rb"]

end

