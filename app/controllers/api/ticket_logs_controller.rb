class Api::TicketLogsController < ApplicationController
  before_action :load_ticket

  def index
    render :index, layout: false
  end

  def create
    @ticket.ticket_logs.create(content: params[:content], agent_id: current_user.id, action: 'Call Logs')
  end
  private
  def load_ticket
    @ticket = Ticket.find params[:ticket_id]
  end
end