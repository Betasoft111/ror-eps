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





  #################################
  #         search Routes        #
  #################################
  get "/search" => "search#search"





  #################################
  #         Company Routes        #
  #################################
  resources :companies
  get "/add_staff" => "companies#add_staff"
  get "/company_home" => "companies#index"
  post "companies/update/:id" => "companies#update"
  get "/companies/delete/:id" => "companies#destroy"



  resources :users
  resources :sessions
  resources :charges

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

  end

  # #url's we are using in web

  # match 'admin/manage_company_user' => 'admin/admin#manage_company_user',  :via => :get

  # match 'create_user' => 'users#create_user',  :via => :post

  # match 'get-notes' => 'alert_details#get_notes', :via => :get, :defaults => { :format => 'json' }

end
