class Api::TicketsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    ticket = Ticket.create(status: 'OPEN', title: 'Request a call', customer_phone: params[:customer_phone], customer_name: params[:customer_name])
  end
end