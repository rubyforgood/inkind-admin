module Mutations
  class CreateSupportTicket < Base::Mutation
    null true

    argument :survey_response_id, ID, required: true
    argument :description, String, required: false

    field :support_ticket, Types::SupportTicketType, null: false

    def resolve(survey_response_id:, description:)
      support_ticket = SupportTicket.create!(
        category: :survey_response,
        description: description,
        survey_response_id: survey_response_id,
        requestor: context[:current_user]
      )

      {support_ticket: support_ticket}
    end
  end
end
