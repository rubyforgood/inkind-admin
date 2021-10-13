class SurveyTextQuestion < SurveyQuestion

  # FIXME: this is just so that GraphQL don't break for this type
  def options
    []
  end
end
