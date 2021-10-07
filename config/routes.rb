Rails.application.routes.draw do
  root to: 'static#home'

  post '/graphql', to: 'graphql#execute'

  mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: '/graphql' if Rails.env.development?

  devise_scope :user do
    get 'sign_in', to: 'users/sessions#new'
    get 'sign_up', to: 'users/registrations#new'
  end

  devise_for :users, path: 'users'

  namespace :admin do
    get 'dashboard', to: 'dashboard#home'
    resources :students
  end
end
