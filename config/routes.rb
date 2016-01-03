Rails.application.routes.draw do

  root  'static_pages#home'

  get '/about'          =>  'static_pages#about'
  get '/retailer_info'  =>  'static_pages#retailer_info'
  get '/experience'     =>  'static_pages#experience'
  get '/decal'          =>  'static_pages#decal'
  get '/relaunch'       =>  'static_pages#relaunch'

  namespace :blog do
    resources :articles, path: '', only: [:index, :show]
  end

  devise_for :users, controllers: {
    sessions: "users/sessions",
    passwords: "users/passwords",
    registrations: "users/registrations"
  }

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
