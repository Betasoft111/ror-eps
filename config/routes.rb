EPS::Application.routes.draw do

  #################################
  #        Application Root       #
  #################################
  root :to => "welcome#index"

  ##########################
  #      General Routes    #
  ##########################
  get "about_us" => "welcome#about"
  get "contact_us" => "welcome#contact"

  #################################
  #      Authentication Routes    #
  #################################
  get "log_out" => "sessions#destroy", :as => "log_out"
  get "join" => "sessions#register", :as => "register"
  get "sign_in" => "sessions#login", :as => "login"
  get "forgot_password" => "users#forgot_password"
  post "request_password" => "users#request_password"
  get "reset_password/:reset_password_token" => "users#reset_password"
  get "invalid_password_token" => "users#invalid_password_token"
  post "update_password" => "users#update_password"

  #################################
  #         Payment Routes        #
  #################################
  get "membership_plans" => "users#choose_plan"
  post "/charges/payment_method" => "users#payment_method"
  post "/charges/create" => "charges#create"
  post "/add_staff/create" => "companies#create"
  post "/charges/payment_ipn" => "charges#payment_ipn"  
  get "/payment_ipn" => "charges#payment_ipn"  
  post "/payment_ipn_stripe" => "charges#payment_ipn_stripe"  
  post "/upgrade_addstaff_plan" =>  "companies#upgrade_staff_plan"
  get "/charges/add_on/create" => "charges#buy_addon_paypal"  
  get "/charges/epay_addon" => "charges#buy_epay_addon"


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
  get "/favourite_searches/destroy/:id" => "favourite_searches#destroy"


  #################################
  #         Company Routes        #
  #################################
  resources :companies
  get "/add_staff" => "companies#add_staff"
  get "/company_home" => "companies#index"
  post "companies/update/:id" => "companies#update"
  get "/companies/delete/:id" => "companies#destroy"
  get '/addon_plans' => "companies#upgrade_plan"
  get "/hiring_requests" => "company_requests#index"
  get "/hiring_requests/:id/show" => "company_requests#request_details"
  get "/hiring_requests/:id/approve" => "company_requests#approve"
  get "/hiring_requests/:id/reject" => "company_requests#reject"
  get '/my_requests'  => 'company_requests#myrequests'

  get "/not_authorized" => 'companies#no_access'
  get "/payment_history" => 'companies#payment_his'



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
    get "user_activity" => "admin#user_activity"
    get "request_activity" => "admin#request_activity"
    #get "subscription_plans" => "subscription_plans#index"
    post "subscription_plans/create" => "subscription_plans#create"
    post "staff_plans/create" => "staff_plans#create"
    get "log_in" => "admin#login"
    post "post_login" => "admin#do_login"
    get "log_out" => "admin#destroy"
    get "staff_plans/delete/:id" => "staff_plans#destroy"
    post "subscription_plans/update/:id" => "subscription_plans#update"

    get "pages" => "admin#pages"
    get "page/:page_name/edit" => "admin#edit_page"
    post "/page/update" => "admin#update_page"
    get "/add_company" => "admin#add_user"
    post "/companies/create" => "admin#create_company"

    resources :subscription_plans
    resources :staff_plans
    post "subscription_plans/update/:id" => "subscription_plans#update"
    post "staff_plans/update/:id" => "staff_plans#update"

    get "company/:id/edit" => "admin#edit_company"
    post "/companies/update" => 'admin#update'
    get "company/:id/delete" => "admin#delete"


    resources :requests
    resources :help_center
    post "/help_center/add" => "help_center#create"
    post "/help_center/update" => "help_center#update"
    get "/help_center/:id/delete" => "help_center#destroy"

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
