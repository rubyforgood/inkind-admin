module Inputs
  class UpdateUserInput < Types::Base::InputObject
    argument :first_name, String, required: true
    argument :last_name, String, required: true
    argument :email, String, required: false
    argument :phone_number, String, required: false
  end
end
