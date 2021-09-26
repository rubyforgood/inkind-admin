module JsonHelpers
  def see(json)
    location = caller(1..1).first
    location = location.gsub(Rails.root.to_s, "").split(":")[0..1].join(":")
    location = "\033[36m.#{location}\033[0m"

    puts "#{location} #{json}"
  end
end

RSpec.configure { |config| config.include JsonHelpers }
