Rails.application.routes.draw do

  root  'static_pages#home'

  get '/about'          =>  'static_pages#about'
  get '/retailer_info'  =>  'static_pages#retailer_info'

  get '/blog'                               =>  'blog#index'
  get '/blog/welcome-to-openstile'          =>  'blog#blog_01'
  get '/blog/retailer-spotlight-tin-lizzy'  =>  'blog#blog_02'
  get '/blog/dressing-mommy-post-baby-phase'=>  'blog#blog_03'

  devise_for :shoppers, :skip => [:passwords, :registrations], path: '/shoppers', controllers: {
    sessions: 'shoppers/sessions'
    }
  devise_scope :shopper do
      get "/shoppers/sign_up", :to => "shoppers/registrations#new",   :as => 'new_shopper_registration'
      post "/shoppers", :to => "shoppers/registrations#create", :as => 'shopper_registration'
  end

  devise_for :retail_users, :skip => [:passwords, :registrations], path: '/retail_users', controllers: {
    sessions: 'retail_users/sessions'
    }
  devise_scope :retail_user do
      get "/retail_users/registrations", :to => "retail_users/registrations#edit",   :as => 'edit_retail_user_registration'
      put "/retail_users", :to => "retail_users/registrations#update", :as => 'retail_user_registration'
  end

  resources :retail_users, :path => '/retail_users', :to => "retail_users/registrations#edit" , only: [:edit]

  resources :style_profiles, only: [:edit, :update]

  resources :retailers, only: [:show] do
    member do
      get 'enable_available_dates'
      get 'enable_available_times'
      get 'show_drop_in_location'
    end
  end

  resources :tops, only: [:show]

  resources :bottoms, only: [:show]

  resources :dresses, only: [:show]

  resources :drop_ins, only: [:create, :update, :destroy] do
    collection do
      get :upcoming
    end
  end

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
