module Admin
  class TicketsController < ApplicationController
    before_action :ticket, only: %i[show resolve]

    def index
      @nav = "Tickets"
      @tickets = SupportTicket.order(:created_at)

      respond_to do |format|
        format.html
        format.csv do
          columns = %w[requestor.name created_at survey_response_id survey_response.student.name
            survey_response.student.active_student_staff_assignment.staff.name category_s status_s ]
          headers = ["Requested By", "Date Created", "Response ID", "Student", "Staff Contact", "Type", "Status"]

          send_data SupportTicket.export_to_csv(@tickets, columns: columns, headers: headers),
            filename: "support-tickets-#{Date.today}.csv"
        end
      end
    end

    def new
      @ticket = SupportTicket.new
    end

    def create
      @ticket = SupportTicket.new(ticket_params)
      @ticket.category = :admin

      if @ticket.valid?
        @ticket.save!
        redirect_to admin_tickets_url, notice: "Support ticket was successfully created."
      else
        flash[:alert] = format_errors(@ticket)
        render :new
      end
    end

    def show
    end

    def resolve
      if ticket.close!(current_user, closer_notes: ticket_update_params[:closer_notes])
        redirect_to admin_tickets_path, notice: "The support ticket was successfully resolved."
      else
        flash[:alert] = "Could not resolve the support ticket. Please try again."
        render :show
      end
    end

    private

    def ticket_params
      params.require(:support_ticket).permit(:requestor_id, :description)
    end

    def ticket_update_params
      params.require(:support_ticket).permit(:closer_notes)
    end

    def ticket
      return @ticket if defined?(@ticket)

      @ticket = SupportTicket.find(params[:id])
    end
  end
end
