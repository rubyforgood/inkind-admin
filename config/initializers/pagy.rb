# frozen_string_literal: true

# Pagy initializer file (5.1.3)
# Customize only what you really need and notice that Pagy works also without any of the following lines.
# Should you just cherry pick part of this file, please maintain the require-order of the extras

# Check full boilerplate : https://raw.githubusercontent.com/ddnexus/pagy/master/lib/config/pagy.rb
Pagy::DEFAULT[:page] = 1 # default
Pagy::DEFAULT[:items] = 2 # default

Pagy::DEFAULT.freeze
