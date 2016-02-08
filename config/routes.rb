Rails.application.routes.draw do

  root 'users#index'
  get '/auth/:provider/callback', to: 'users#create'

  get 'sign-out', to: 'users#sign_out', as: :sign_out

end
