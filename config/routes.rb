Rails.application.routes.draw do
  # App Paths
  root to: "admin/dashboard#home"

  # GraphQL
  post "/graphql", to: "graphql#execute"
  mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql" if Rails.env.development?

  # Devise Setup
  devise_scope :user do
    get "users/sign_out" => "devise/sessions#destroy"
  end
  devise_for :users, path: "users"

  namespace :admin do
    resources :volunteers, except: :destroy
  end
end
