class PagesController < ApplicationController
  
  # GET /pages/1
  def show
    @page = Page.find_by_url params[:id]
  end
end
