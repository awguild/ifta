Iftaconferenceapp::Application.routes.draw do
  root :to => 'welcome#index', :as => :root
  #user routes
  get 'users/:id/edit_password' => 'users#edit_password', :as => :edit_user_password
  match 'users/:id/update_password' => 'users#update_password', :as => :update_user_password
  post 'users/:id/change_role' => 'users#change_role', :as => :change_role_user
  get 'users/edit' => 'users#edit'
  
  
  #ifta member routes
  get 'members/edit' => 'ifta_members#mass_new', :as => :mass_new_members
  post 'members/new_list' => 'ifta_members#add_to_members_list', :as => :add_to_members_list
  post 'members/add_to_list' => 'ifta_members#complete_members_list', :as => :complete_members_list
  get 'members/index' => 'ifta_members#index', :as => :members
  
  #proposal routes
  get 'conference/:id/proposals' => 'proposals#index', :as => :conference_proposals  
  get 'conference/:id/proposals' => 'proposals#index', :as => :conference_proposals  
  
  devise_for :users, :controllers => { :registrations => "users/registrations", :passwords => "devise/passwords" } do 
    get 'users/sign_out' => 'devise/sessions#destroy'
    put 'users/password' => 'devise/passwords#update'
    match 'users/password' => 'devise/passwords#create' #Rails bug with post member routes
    match 'users/password/edit' => 'devise/passwords#edit', :as => :edit_password
  end
  resources :users
  resources :itineraries do 
    resources :proposals do
      collection do
        get 'splash', as: :splash
      end
    end
    resources :line_items
    resources :transactions
  end
  
  resources :payments 
  post 'payments/manual' => 'payments#admin_create', :as => :manual_payment
  resources :conferences do
    resources :discounts
    resource :schedule
  end
  resources :reviews
  
end
