Rails.application.routes.draw do

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

	resources :posts do
    resources :comments
    member do
      get 'like'
      get 'unlike'
    end
  end

  resources :users

	root 'posts#index'

end
