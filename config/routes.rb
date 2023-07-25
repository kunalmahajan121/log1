Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  resources :users
  post '/auth/login', to: 'authentication#login'
  get '/*a', to: 'application#not_found'
end
