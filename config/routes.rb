Rails.application.routes.draw do
  root :to => 'users#new'

  # sign up
  get 'users/new' => 'users#new', as: :new_user
	post 'users' => 'users#create'

  # log in:
	get '/login' => 'sessions#new'

	# create (post) action for when log in form is submitted:
	post '/login' => 'sessions#create'

	# log out:
	delete '/logout' => 'sessions#destroy'


  # notes
  get 'notes/new' => 'notes#new'
  get 'notes/:id' => 'notes#show', as: :show_note
  post 'notes' => 'notes#create'

end
