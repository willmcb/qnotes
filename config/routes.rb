Rails.application.routes.draw do
  root :to => 'sessions#new'

  # sign up
  get 'users/new' => 'users#new', as: :new_user
	post 'users' => 'users#create'

  # sessions
	get '/login' => 'sessions#new', as: 'login'
  get '/logout' => 'sessions#destroy', as: 'logout'

	# create (post) action for when log in form is submitted:
  post '/' => 'sessions#create'
	post '/login' => 'sessions#create'

  # notes
  resources :notes

  # collections
  resources :collections

  # tags
  resources :tags, only: [:index, :create, :new, :show, :destroy]
end
