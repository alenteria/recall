class Api::UsersController < ApplicationController
  before_action :authenticate_user!

  def update_call_status
    on_call = params[:on_call].present? ? params[:on_call] : false
    current_user.update_column :on_call, on_call
    ticket = Ticket.where(is_new: true, id: params[:ticket_id]).first

    if ticket.present?
      ticket.update_attributes(is_new: false, agent_id: current_user.id, status: 'IN-PROGRESS')
    end
  end

  def check_if_available
    status = current_user.availability == 'online' && !current_user.on_call
    render json: {ok: status}
  end
end