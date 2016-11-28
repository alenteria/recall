class Api::TicketsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    if params[:customer_phone].present? && params[:customer_name].present?
      ticket = Ticket.create(status: 'OPEN', is_new: true, title: 'Request a call', customer_phone: params[:customer_phone], customer_name: params[:customer_name], category: params[:category])
      # sms_message = 'Thank you for your request. Please expect a call from our support within this day.'
      # `curl --user "application\\#{Recall::SINCH_APPLICATION_KEY}:#{Recall::SINCH_APPLICATION_SECRET}" --data '{"message":"#{sms_message}"}' -H 'Content-Type: application/json' https://messagingapi.sinch.com/v1/sms/#{ticket.customer_phone}`
    end
  end

  def check_for_new
    @new_tickets = Ticket.where(is_new: true)
  end
end