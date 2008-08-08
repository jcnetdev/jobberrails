class Admin::PagesController < ApplicationController
  before_filter :login_required
  before_filter :form_message_style, :only => [:new, :edit]
  layout 'admin'
  
  uses_tiny_mce(:options => { :theme => 'advanced',
                  :mode => "textareas",
                  :theme_advanced_toolbar_location => "top",
                  :theme_advanced_toolbar_align => "left",
                  :theme_advanced_statusbar_location => "bottom",
                  :theme_advanced_buttons1 => %w{ bold italic underline strikethrough | justifyleft 
                   justifycenter justifyright justifyfull | styleselect formatselect fontselect fontsizeselect },
                  :theme_advanced_buttons2 => %w{ cut copy paste pastetext pasteword | search
                   replace | bullist numlist | outdent indent blockquote | undo redo | link 
                   unlink anchor image cleanup help code | forecolor backcolor },
                  :theme_advanced_buttons3 => %w{ tablecontrols | hr removeformat visualaid | 
                   sub sup | charmap media advhr | ltr rtl },
                  :theme_advanced_buttons4 => %w{ insertlayer moveforward movebackward absolute |
                   styleprops | cite abbr acronym del ins attribs },
                  :editor_selector => 'mceEditor',
                  :plugins => %w{ style layer table save advhr advimage advlink media searchreplace 
                   contextmenu paste directionality nonbreaking xhtmlxtras } },
                  :only => [:new, :create, :edit, :update])
  
  # GET /admin/pages
  def index
    @pages = Page.all(:order => 'title')
  end
  
  # GET /admin/pages/new
  def new
    @page = Page.new
  end
  
  # POST /admin/pages
  def create
    @page = Page.new(params[:page])
    
    respond_to do |format|
      if @page.save
        flash[:notice] = 'Page was successfully created.'
        format.html { redirect_to admin_pages_url }        
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  # GET /admin/pages/1/edit
  def edit
    @page = Page.find_by_url(params[:id])
    
    @form_style = '' if @page.has_form
  end
  
  # PUT /admin/pages/1
  def update
    @page = Page.find_by_url(params[:id])
    url = @page.url
    
    respond_to do |format|
      if @page.update_attributes(params[:page])
        flash[:notice] = 'Page was successfully updated.'
        format.html { redirect_to admin_pages_url }
      else
        @page.url = url
        format.html { render :action => "edit" }
      end
    end
  end
  
  # DELETE /admin/pages/1
  def destroy
    @page = Page.find_by_url(params[:id])
    @page.destroy
    flash.now[:notice] = "Page has been deleted"
    
    respond_to do |format|
      format.html { redirect_to(admin_pages_url) }
      format.js # admin/pages/destroy.js.rjs
    end
  end
  
  private
  def form_message_style
    @form_style = 'display:none'
  end
end
