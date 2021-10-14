Rails.application.routes.draw do
  # App Paths
  root to: "dashboard#index"

  # GraphQL
  post "/graphql", to: "graphql#execute"
  mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql" if Rails.env.development?

  # Devise Setup
  devise_scope :user do
    get "users/sign_out" => "devise/sessions#destroy"
  end

  devise_for :users, path: "users"

  namespace :admin do
    resources :organizations, only: [:show, :edit, :update]
    resources :admin_users, except: :destroy do
      member do
        patch 'activate'
        patch 'deactivate'
      end
    end

    resources :volunteers, except: :destroy do
      member do
        patch 'activate'
        patch 'deactivate'
      end
    end

    resources :students, except: :destroy do
      member do
        get :activate
        get :deactivate
      end
    end

    match "imports/volunteers", to: "imports#volunteers", via: :post
    match "imports/students", to: "imports#students", via: :post
  end
end
