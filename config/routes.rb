Iftaconferenceapp::Application.routes.draw do
  root :to => 'welcome#index', :as => :root
  
  post 'users/:id/change_role' => 'users#change_role', :as => :change_role_user
  get 'users/edit' => 'users#edit'
  get 'members/edit' => 'ifta_members#mass_new', :as => :mass_new_members
  post 'members/new_list' => 'ifta_members#add_to_members_list', :as => :add_to_members_list
  post 'members/add_to_list' => 'ifta_members#complete_members_list', :as => :complete_members_list
  get 'conference/:id/proposals' => 'proposals#index', :as => :conference_proposals  
  get 'conference/:id/proposals' => 'proposals#index', :as => :conference_proposals  
  devise_for :users, :controllers => { :registrations => "users/registrations" } do 
    get '/users/sign_out' => 'devise/sessions#destroy'
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
  resources :conferences
  resources :reviews
  
end
