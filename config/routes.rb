Rails.application.routes.draw do
  root :to => 'sessions#new'

  # sign up
  get 'users/new' => 'users#new', as: :new_user
	post 'users' => 'users#create'

  # sessions
	get '/login' => 'sessions#new', as: 'login'
	delete '/logout' => 'sessions#destroy'

	# create (post) action for when log in form is submitted:
  post '/' => 'sessions#create'
	post '/login' => 'sessions#create'

	# log out:
	delete '/logout' => 'sessions#destroy'

  # notes
  resources :notes

  # collections
  resources :collections

  resources :tags, only: [:index, :create, :new, :show]

  # tags
  # get 'tags/:tag', to: 'notes#index', as: :tag
end
