module ViewFu
  module ControllerExtensions
    # allows us to say "helpers." anywhere in our controllers
    def helpers
      self.class.helpers
    end
    
    # checks to see if app is in production mode
    def production?
      Rails.env == "production"
    end
  end
end