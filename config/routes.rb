Rails.application.routes.draw do

  root 'users#index'
  get '/auth/:provider/callback', to: 'users#create'

  get 'sign-out', to: 'users#sign_out', as: :sign_out

  get 'github-api', to: 'users#github_api'
  get 'lang-chart', to: 'users#language_chart'
  get 'activity', to: 'users#activity'
end
