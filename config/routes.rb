ActionController::Routing::Routes.draw do |map|

  map.login 'login', :controller => 'sessions', :action => 'new'
  map.logout 'logout', :controller => 'sessions', :action => 'destroy'
  map.resource :session
  
  map.resources :jobs, :member => {
                          :verify => :any, 
                          :apply => :post, 
                          :confirm => :any,
                          :report_spam => :post
                        }

  map.resources :companies
  map.jobs_at 'jobs_at/:company', :controller => 'companies', :action => 'jobs_at'
  
  map.resources :job_requests, :collection => {:success => :get}
  map.resources :categories
  map.resource :search, :controller => "Search"
  
  map.resources :pages

  map.admin 'admin', :controller => 'admin/jobs', :action => 'index'
  map.namespace :admin do |admin|
    # Directs /admin/jobs/* to Admin::JobsController (app/controllers/admin/jobs_controller.rb)
    admin.resources :jobs
    # Directs /admin/categories/* to Admin::CategoriesController (app/controllers/admin/categories_controller.rb)
    admin.resources :categories, :collection => {:saveorder => :put}
    # Directs /admin/pages/* to Admin::PagesController (app/controllers/admin/pages_controller.rb)
    admin.resources :pages
  end

  map.root :controller => "jobs"

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'

end
