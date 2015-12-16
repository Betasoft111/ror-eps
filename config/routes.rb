EPS::Application.routes.draw do

  #################################
  #        Application Root       #
  #################################
  root :to => "welcome#index"

  #################################
  #      Authentication Routes    #
  #################################
  get "log_out" => "sessions#destroy", :as => "log_out"
  get "join" => "sessions#new", :as => "log_in"
  get "forgot_password" => "users#forgot_password"
  post "request_password" => "users#request_password"
  get "reset_password/:reset_password_token" => "users#reset_password"
  get "invalid_password_token" => "users#invalid_password_token"
  post "update_password" => "users#update_password"

  #################################
  #         Payment Routes        #
  #################################
  get "choose_plan" => "users#choose_plan"
  post "/charges/payment_method" => "users#payment_method"
  post "/charges/create" => "charges#create"
  post "/add_staff/create" => "companies#create"
  post "/charges/payment_ipn" => "charges#payment_ipn"  
  get "/payment_ipn" => "charges#payment_ipn"  
  post "/payment_ipn_stripe" => "charges#payment_ipn_stripe"  
  post "/upgrade_addstaff_plan" =>  "companies#upgrade_staff_plan"





  #################################
  #         search Routes        #
  #################################
  get "/search" => "search#search"
  get "/staff_details/:id" => "search#show_details"
  get "/search_json" => "search#search_json"


   #################################
  #         fav search routes     #
  #################################
   resources :favourite_searches



  #################################
  #         Company Routes        #
  #################################
  resources :companies
  get "/add_staff" => "companies#add_staff"
  get "/company_home" => "companies#index"
  post "companies/update/:id" => "companies#update"
  get "/companies/delete/:id" => "companies#destroy"
  get '/upgrade_plan' => "companies#upgrade_plan"
  get "/hiring_requests" => "company_requests#index"
  get "/hiring_requests/:id/show" => "company_requests#request_details"
  get "/hiring_requests/:id/approve" => "company_requests#approve"
  get "/hiring_requests/:id/reject" => "company_requests#reject"
  get '/my_requests'  => 'company_requests#myrequests'

  get "/not_authorized" => 'companies#no_access'



  resources :users
  resources :sessions
  resources :charges
  resources :company_requests

  #################################
  #          Admin Routes         #
  #################################
  namespace :admin do
    root to: "admin#index"
    get "create" => "admin#create"
    post "subscription_plans/create" => "subscription_plans#create"
    post "staff_plans/create" => "staff_plans#create"
    get "log_in" => "admin#login"
    post "post_login" => "admin#do_login"
    get "log_out" => "admin#destroy"
    get "staff_plans/delete/:id" => "staff_plans#destroy"
    post "subscription_plans/update/:id" => "subscription_plans#update"

    resources :subscription_plans
    resources :staff_plans
    post "subscription_plans/update/:id" => "subscription_plans#update"
    post "staff_plans/update/:id" => "staff_plans#update"

    get "company/:id/edit" => "admin#edit_company"
    post "/companies/update" => 'admin#update'
    get "company/:id/delete" => "admin#delete"


    #route for add skills and qualificartion from admin 

    #skills section
     resources :skills
      post "/skills/add" => 'skills#add'
      post "/skills/update" => 'skills#update'
      get "/skills/:id/delete" => "skills#delete"


      #qualifications section
       resources :qualifications
       post "/qualifications/add" => 'qualifications#add'
       post "/qualifications/update" => 'qualifications#update'
       get "/qualifications/:id/delete" => "qualifications#delete"
  end

  # #url's we are using in web

  # match 'admin/manage_company_user' => 'admin/admin#manage_company_user',  :via => :get

  # match 'create_user' => 'users#create_user',  :via => :post

  # match 'get-notes' => 'alert_details#get_notes', :via => :get, :defaults => { :format => 'json' }

end
