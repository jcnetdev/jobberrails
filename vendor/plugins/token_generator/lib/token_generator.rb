module TokenGenerator
  def generate_token(size = 12, &validity)
    constant = "#{self.class.name}#{id}"

    begin
      token = CGI::Session.generate_unique_id(constant).first(size)
    end while !validity.call(token) if block_given?

    token
  end

  def set_token
    self.token = generate_token { |token| self.class.find_by_token(token).nil? }
  end
end
