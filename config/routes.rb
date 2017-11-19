Rails.application.routes.draw do

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  post ':family_id/join_family', to: 'kinship#create', as: 'join_family'
  post ':family_id/leave_family', to: 'kinship#destroy', as: 'leave_family'

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
