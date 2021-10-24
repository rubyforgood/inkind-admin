module Admin
  class TicketsController < ApplicationController
    def index
      @nav = "Tickets"
      @tickets = SupportTicket.order(:created_at)

      respond_to do |format|
        format.html
        format.csv do
          columns = %w[requestor.name survey_response.student.name created_at description status]
          headers = ["Requestor", "Student", "Created At", "Description", "Status"]

          send_data SupportTicket.export_to_csv(@tickets, columns: columns, headers: headers), filename: "support-tickets-#{Date.today}.csv"
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
      @ticket = SupportTicket.find(params[:id])
    end

    def resolve
      @ticket = SupportTicket.find(params[:id])

      if @ticket.close!(current_user)
        redirect_to admin_tickets_path, notice: "The support ticket was successfully resolved."
      else
        flash[:alert] = "Could not resolve the support ticket. Please try again."
        render :show
      end
    end

    def ticket_params
      params.require(:support_ticket).permit(:requestor_id, :description)
    end
  end
end
