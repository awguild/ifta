Iftaconferenceapp::Application.routes.draw do
  root :to => 'welcome#index', :as => :root
  #user routes
  get 'users/:id/edit_password' => 'users#edit_password', :as => :edit_user_password
  patch 'users/:id/update_password' => 'users#update_password', :as => :update_user_password
  post 'users/:id/change_role' => 'users#change_role', :as => :change_role_user
  get 'users/edit' => 'users#edit'


  #ifta member routes
  get 'members/edit' => 'ifta_members#mass_new', :as => :mass_new_members
  post 'members/new_list' => 'ifta_members#add_to_members_list', :as => :add_to_members_list
  post 'members/add_to_list' => 'ifta_members#complete_members_list', :as => :complete_members_list
  get 'members/index' => 'ifta_members#index', :as => :members

  #proposal routes
  get 'conference/:id/proposals' => 'proposals#index', :as => :conference_proposals
  get 'conference/:id/unslotted-proposals' => 'proposals#unslotted', :as => :unslotted_proposals

  devise_for :users, :controllers => { :registrations => "users/registrations", :passwords => "devise/passwords" }
  devise_scope :user do
    get 'users/sign_out' => 'devise/sessions#destroy'
    put 'users/password' => 'devise/passwords#update'
    post 'users/password' => 'devise/passwords#create'
    get 'users/password/edit' => 'devise/passwords#edit', :as => :edit_password
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
    collection do
      post 'select_year', as: :select_year
    end

    member do
      get 'schedule', as: :schedule
    end
    resources :discounts
  end
  resources :reviews

  #reports
  get 'conferences/:id/accepted_and_unregistered' => 'reports#accepted_and_unregistered', :as => :accepted_and_unregistered_report
  get 'conferences/:id/registration_breakdown' => 'reports#registration_breakdown', :as => :registration_breakdown_report
  get 'conferences/:id/student_presentations' => 'reports#student_presentations', :as => :student_presentations_report
  get 'conferences/:id/presentations' => 'reports#presentations', :as => :presentations_report

  namespace :api, :defaults => { :format => 'json' } do
    namespace :v1 do
      resources :conferences do
        member do
          get 'schedule' => 'schedules#show'
          post 'slots' => 'schedules#bulk_create'
        end
        patch 'slots/:id' => 'slots#update'
        resources :rooms
      end
    end
  end
end
