<%= app_name.camelize %>::Application.routes.draw do

  resources :users,   only: [:new, :create]
  resource  :session, only: [:new, :create, :destroy]

  get    'register',  to: 'users#new'
  get    'signin',    to: 'sessions#new'
  delete 'signout',   to: 'sessions#destroy'

  root to: 'pages#home'

end