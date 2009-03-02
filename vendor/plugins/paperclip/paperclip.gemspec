Gem::Specification.new do |s|
  s.name = 'paperclip'
  s.version = '1.1'
  s.date = '2008-07-14'
  
  s.summary = "Allows easy file uploading for Rails"
  s.description = "Paperclip is intended as an easy file attachment library for ActiveRecord. The intent behind it was to keep setup as easy as possible and to treat files as much like other attributes as possible. This means they aren't saved to their final locations on disk, nor are they deleted if set to nil, until ActiveRecord::Base#save is called. It manages validations based on size and presence, if required. It can transform its assigned image into thumbnails if needed, and the prerequisites are as simple as installing ImageMagick (which, for most modern Unix-based systems, is as easy as installing the right packages). Attached files are saved to the filesystem and referenced in the browser by an easily understandable specification, which has sensible and useful defaults."
  
  s.authors = ['Jon Yurek']
  s.email = 'info@thoughtbot.com'
  s.homepage = 'http://github.com/thoughtbot/paperclip'
  
  s.has_rdoc = true
  s.rdoc_options = ["--main", "README"]
  s.extra_rdoc_files = ["README"]

  s.add_dependency 'rails', ['>= 2.1']
  
  s.files = ["LICENSE",
             "README",
             "README.rdoc",
             "Rakefile",
             "generators/paperclip/paperclip_generator.rb",
             "generators/paperclip/templates/paperclip_migration.rb",
             "generators/paperclip/USAGE",
             "init.rb",
             "lib/paperclip/attachment.rb",
             "lib/paperclip/geometry.rb",
             "lib/paperclip/iostream.rb",
             "lib/paperclip/storage.rb",
             "lib/paperclip/thumbnail.rb",
             "lib/paperclip/upfile.rb",
             "lib/paperclip.rb",
             "paperclip.gemspec",
             "rails/init.rb",
             "tasks/paperclip_tasks.rake"]
  
  s.test_files = ["test/attachment_test.rb",
                  "test/database.yml",
                  "test/fixtures/12k.png",
                  "test/fixtures/50x50.png",
                  "test/fixtures/5k.png",
                  "test/fixtures/bad.png",
                  "test/fixtures/text.txt",
                  "test/geometry_test.rb",
                  "test/helper.rb",
                  "test/integration_test.rb",
                  "test/iostream_test.rb",
                  "test/paperclip_test.rb",
                  "test/storage_test.rb",
                  "test/thumbnail_test.rb"]
end

