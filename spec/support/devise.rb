RSpec.configure do |config|
  # RSpec/Devise controller test configs: https://rubydoc.info/github/heartcombo/devise/#controller-tests
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::ControllerHelpers, type: :view
  # RSpec/Devise integration test configs: https://rubydoc.info/github/heartcombo/devise/#integration-tests
  config.include Devise::Test::IntegrationHelpers, type: :system
end
