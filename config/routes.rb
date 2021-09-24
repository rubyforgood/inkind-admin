Rails
  .application
  .routes
  .draw do
    root to: 'static#home'

    post '/graphql', to: 'graphql#execute'

    if Rails.env.development?
      mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: '/graphql'
    end

    devise_scope :user do
      get 'sign_in', to: 'users/sessions#new'
      get 'sign_up', to: 'users/registrations#new'
    end

    devise_for :users, path: 'users'

    namespace :admin do
      get 'dashboard', to: 'dashboard#home'
    end
  end
