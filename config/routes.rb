Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "pages#home"
  post "/", to: "pages#home"
  get "/:key/visits", to: "visits#index"
  mount RailsUrlShortener::Engine, at: "/"
end
