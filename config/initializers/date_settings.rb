# Be sure to restart your server when you modify this file. strftime

ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS.merge!(
  :date => "%m/%d/%Y",
  :us => '%m/%d/%y',
  :us_with_time => '%m/%d/%y, %l:%M %p',
  :short_day => '%e %B %Y',
  :long_day => '%A, %e %B %Y',
  :long_date => "%B %d, %Y",
  :post_listing_date => "%b %d",
  
  # custom
  :job_listing => '%m/%d/%y'
)
