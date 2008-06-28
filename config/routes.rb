ActionController::Routing::Routes.draw do |map|

  map.resources :jobs, :member => {
                          :verify => :any, 
                          :apply => :post, 
                          :confirm => :any
                        }

  map.resources :job_requests, :collection => {:success => :get}
  map.resources :categories
  map.resource :search, :controller => "Search"

  # map.namespace :admin do |admin|
  #   # Directs /admin/jobs/* to Admin::JobsController (app/controllers/admin/jobs_controller.rb)
  #   admin.resources :jobs
  # end

  map.root :controller => "jobs"

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'

end
