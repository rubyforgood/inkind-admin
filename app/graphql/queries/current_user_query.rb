module Queries
  module CurrentUserQuery
    extend ActiveSupport::Concern

    included do
      field :current_user, Types::UserType, null: true, description: "Currently logged in user"
    end

    def current_user
      context[:current_user]
    end
  end
end
