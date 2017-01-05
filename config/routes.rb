Rails.application.routes.draw do
  resources :players
  resources :reports
  resources :teams

  get '/photos' => 'photos#all'

  resources :matches do
    resources :live_scores, only: [:index, :create, :destroy]
    resources :goals, only: [:index, :create, :destroy]
    resources :photos
  end

  # For warmup match photos
  post '/warmup_match_photos' => 'photos#create_warmup_match_photo',
    as: :warmup_match_photos

  # For updating match results
  patch '/end_match/:id' => 'matches#end_match'
  get '/end_match/:id' => 'matches#end', as: 'end_match'

  get '/live_score' => 'live_scores#broadcast'
  root 'static_pages#home'
  get '/about' => 'static_pages#about', as: 'about'

  # for admin
  get '/goals' => 'goals#index'
  get '/all_matches' => 'matches#list'
  get '/all_reports' => 'reports#list'
  get '/all_photos' => 'photos#list'

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
