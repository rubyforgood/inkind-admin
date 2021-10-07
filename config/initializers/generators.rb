# Disable a few of the generators I often just delete after they're created and set RSpec to generate as the test framework.
Rails.application.config.generators do |g|
  g.assets false
  g.helper false
  g.test_framework :rspec
end