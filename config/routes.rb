Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "welcome#index"

  get '/register', to: 'users#new'
  post '/users', to: 'users#create'
  get '/dashboard', to: 'dashboard#index'

  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  get '/discover', to: 'discover#index'

  get '/movies', to: 'movies#index'
  get '/movies/:id', to: 'movies#show'

  post '/friendships', to: 'friendships#create'

  resources :viewing_party, only: [:new, :create, :show, :edit, :update]
  delete '/viewing_party/:id/delete', to: 'viewing_party#delete'
end
