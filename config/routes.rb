Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'pages#main'
  post '/generate', to: 'application#generate'
  get '/home', to: 'pages#home', as: :home
  get '/generate', to: 'pages#generate'
  resources :users, only: %i[new create update]
  scope 'auth' do
    get '/', to: 'authentication#new', as: :login
    post '/login', to: 'authentication#create'
    get '/logout', to: 'authentication#destroy', as: :logout
  end
  get '/:key/visits', to: 'visits#index'
  get '/:key/visits/:id', to: 'visits#show'
  mount RailsUrlShortener::Engine, at: '/'
end
