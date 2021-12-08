module PhoneNumberHelper
  def format_phone_number(number_string)
    number_to_phone(number_string&.delete("a-z-().[]#*|"), area_code: true)
  end
end
