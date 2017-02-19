Rails.application.routes.draw do

  root  'static_pages#home'

  get '/about'            =>  'static_pages#about'
  get '/retailer_info'    =>  'static_pages#retailer_info'
  get '/experience'       =>  'static_pages#experience'
  get '/decal'            =>  'static_pages#decal'
  get '/relaunch'         =>  'static_pages#relaunch'
  get '/join_confirmation'=>  'static_pages#join_confirmation'
  get '/confirmation_required'  => 'static_pages#confirmation_required'

  post 'swipe_styles/invite'    => 'swipe_styles#invite'
  get 'swipe_styles/new'        => 'swipe_styles#new'
  get 'swipe_styles/results'    => 'swipe_styles#results'
  post 'swipe_styles/like'      => 'swipe_styles#like'
  post 'swipe_styles/complete'  => 'swipe_styles#complete'
  delete 'swipe_styles/destroy' => 'swipe_styles#destroy'
  post 'swipe_styles/update_matches' => 'swipe_styles#update_matches'

  namespace :webhooks do
    get 'mailchimp/subscribe'  => 'mailchimp_importer#validate'
    post 'mailchimp/subscribe' => 'mailchimp_importer#subscribe'
  end

  namespace :blog do
    resources :articles, path: '', only: [:index, :show]
  end

  devise_for :users, controllers: {
    sessions: "users/sessions",
    passwords: "users/passwords",
    registrations: "users/registrations"
  }

  scope module: 'users' do
    resources :users, only: [] do
      collection do
        get :shoppers
      end
    end
  end

  resources :style_profiles, only: [:edit, :update, :new, :create] do
    collection do
      post :quickstart
    end
  end

  resources :retailers, only: [:show, :index, :new, :create] do
    member do
      get 'scheduled_availabilities'
      get 'enable_available_dates'
      get 'enable_available_times'
      get 'show_drop_in_location'
      get 'press_kit'
    end
  end

  resources :drop_ins, only: [:create, :update, :destroy] do
    member do
      patch :cancel
    end
    collection do
      get :upcoming
    end
  end

  resources :drop_in_availabilities, only: [:create, :update] do
    collection do
      get :personal
    end
  end

  get 'drop_in_availabilities/apply_form' => 'drop_in_availabilities#apply_form'

  resources :reports, only: [:new, :create]

  resources :retailer_referrals, only: [:create]

end
