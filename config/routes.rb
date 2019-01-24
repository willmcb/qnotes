Rails.application.routes.draw do
  root :to => 'sessions#new'

  # sign up
  get 'users/new' => 'users#new', as: :new_user
	post 'users' => 'users#create'

  # log in:
	get '/login' => 'sessions#new', as: 'login'

	# create (post) action for when log in form is submitted:
  post '/' => 'sessions#create'
	post '/login' => 'sessions#create'

	# log out:
	delete '/logout' => 'sessions#destroy'


  # notes
  get 'notes/new' => 'notes#new'
  get 'notes/:id' => 'notes#show', as: :show_note
  post 'notes' => 'notes#create'

  # collections
  get 'collections' => 'collections#index', as: 'collections'
  get 'collections/new' => 'collections#new', as: 'new_collection'
  post 'collections/create' => 'collections#create', as: 'create_collection'

end
