Rails.application.routes.draw do
  root to: "static#home"

  post "/graphql", to: "graphql#execute"

  mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql" if Rails.env.development?

  devise_scope :user do
    get "users/sign_out" => "devise/sessions#destroy"
  end

  devise_for :users, path: "users"

  namespace :admin do
    get "dashboard", to: "dashboard#home"
  end
end
