Rails.application.routes.draw do

  root  'static_pages#home'

  get '/about'          =>  'static_pages#about'
  get '/experience'     =>  'static_pages#experience'
  get '/decal'          =>  'static_pages#decal'
  get '/relaunch'       =>  'static_pages#relaunch'

  namespace :blog do
    resources :articles, path: '', only: [:index, :show]
  end

  devise_for :shoppers, :skip => [:registrations], controllers: {
    sessions: "shoppers/sessions",
    passwords: "shoppers/passwords"
  } 
  devise_scope :shopper do
    get "/shoppers/sign_up",  :to => "shoppers/registrations#new",    :as => 'new_shopper_registration'
    post "/shoppers",         :to => "shoppers/registrations#create", :as => 'shopper_registration'
  end

  devise_for :retail_users, :skip => [:registrations], controllers: {
    sessions: "retail_users/sessions",
    passwords: "retail_users/passwords"
  }
  devise_scope :retail_user do
    get "/retail_users/registrations", :to => "retail_users/registrations#edit",   :as => 'edit_retail_user_registration'
    put "/retail_users/registrations", :to => "retail_users/registrations#update", :as => 'retail_user_registration'
  end

  devise_for :admins, only: [:sessions], controllers: {sessions: "admins/sessions"}

  resources :style_profiles, only: [:edit, :update]

  resources :retailers, only: [:show, :index, :new, :create] do
    member do
      get 'scheduled_availabilities'
      get 'enable_available_dates'
      get 'enable_available_times'
      get 'show_drop_in_location'
      get 'scheduler'
    end
  end

  resources :drop_ins, only: [:create, :update, :destroy] do
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

  resources :retailer_interests, only: [:new, :create]

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
