require 'digest/sha1'

class Admin < ActiveRecord::Base
  validates_length_of :login, :within => 3..40
  validates_length_of :password, :within => 5..40
  validates_presence_of :login, :password
  validates_uniqueness_of :login  

  attr_protected :id

  def self.authenticate(login, pass)
    a = find_by_login(login)
    a && Admin.encrypt(pass) == a.password ? a : nil
  end  

  protected
  def self.encrypt(pass)
    Digest::SHA1.hexdigest(pass)
  end
end
