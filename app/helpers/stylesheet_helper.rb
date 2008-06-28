module StylesheetHelper
  # include stylesheets
  def stylesheets(options = {})
    stylesheet "styles", "util", "application"
  end
end