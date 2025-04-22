Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token
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

  namespace :api do
    post '/login', to: 'authentication#create'
    delete '/logout', to: 'authentication#destroy'

    resources :users, only: %i[create update]
    resources :urls, only: %i[index create destroy] do
      resources :visits, only: %i[index show]
    end
  end

  mount OasRails::Engine => '/api/docs'

  mount RailsUrlShortener::Engine, at: '/'
end
