class User < ActiveRecord::Base
  validates_as_email_address :email
end
