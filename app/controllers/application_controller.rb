class ApplicationController < ActionController::Base
  # This overwrites a Devise helper method
  # https://www.rubydoc.info/github/plataformatec/devise/Devise%2FControllers%2FHelpers:after_sign_in_path_for
  def after_sign_in_path_for(_resource)
    :root
  end

  def format_errors(model)
    model.errors.map(&:full_message).join(", ")
  end
end
