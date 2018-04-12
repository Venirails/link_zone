Rails.application.routes.draw do
   get 'home/mark_as_read'
   get 'home/mark_as_seen'
   #get 'users/chat'
	  resources :posts
  resources :comments, only: [:create, :destroy]
  devise_for :users
  resources :users do
    member do
      get :friends
      get :followers
      get :deactivate
      get :mentionable
    end
  end

  resources :events do
    collection do
      get :calendar
    end
  end

  authenticated :user do
    root to: 'home#index', as: 'home'
  end
  unauthenticated :user do
    root 'home#front'
  end
resources :conversations do
    resources :messages
end


  match :follow, to: 'follows#create', as: :follow, via: :post
  match :unfollow, to: 'follows#destroy', as: :unfollow, via: :post
  match :add_friend, to: 'follows#add_friend', as: :add_friend, via: :post
  match :remove_friend, to: 'follows#delete_friend', as: :remove_friend, via: :post
  match :block_friend, to: 'follows#block_friend', as: :block_friend, via: :post
  match :unblock_friend, to: 'follows#unblock_friend', as: :unblock_friend, via: :post
  match :accept_friend, to: 'follows#accept_friend', as: :accept_friend, via: :post
  match :decline_friend, to: 'follows#decline_friend', as: :decline_friend, via: :post

   match :accept_friend_menu, to: 'users#accept_friend_menu', as: :accept_friend_menu, via: :post
   match :decline_friend_menu, to: 'users#decline_friend_menu', as: :decline_friend_menu, via: :post


  match :like, to: 'likes#create', as: :like, via: :post
  match :unlike, to: 'likes#destroy', as: :unlike, via: :post
  match :find_friends, to: 'home#find_friends', as: :find_friends, via: :get
  match :about, to: 'home#about', as: :about, via: :get
  match :chat, to: 'users#chat', as: :chat, via: :get
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