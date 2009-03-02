Gem::Specification.new do |s|
  s.name = "validates_as_email_address"
  s.version = "1.3"
  s.date = "2008-10-1"
  s.summary = "Gemified validates_as_email_address plugin"
  s.email = "avanie@gmail.com"
  s.homepage = "http://github.com/pager/validates_as_email_address"
  s.has_rdoc = true
  s.authors = ['Aaron Pfeifer']
  s.files = [  
    "CHANGELOG",
    "lib/validates_as_email_address/rfc_822.rb",
    "lib/validates_as_email_address.rb",
    "LICENSE",
    "rails/init.rb",
    "Rakefile",
    "README",
    "test/app_root/app/models/user.rb",
    "test/app_root/db/migrate/001_create_users.rb",
    "test/app_root/log/in_memory.log",
    "test/test_helper.rb",
    "test/unit/validates_as_email_address_test.rb"
  ]
  s.test_files = [
    "test/app_root/app/models/user.rb",
    "test/app_root/db/migrate/001_create_users.rb",
    "test/app_root/log/in_memory.log",
    "test/test_helper.rb",
    "test/unit/validates_as_email_address_test.rb"
  ]
  s.rdoc_options = ["--main", "README"]
  s.extra_rdoc_files = ["README", "CHANGELOG", "LICENSE"]
end
