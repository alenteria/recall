class Api::ContactUsController < ApplicationController
  def create
    if params[:message].present?
      ApplicationMailer.contact_us(params).deliver_now
      flash[:success] = 'We appreciate that you’ve taken the time to write us. We’ll get back to you very soon.'
    else
      flash[:success] = "Thanks for joining Recall' pre-launch waiting list. We'll keep you posted once we're live."
      ApplicationMailer.subscribe(params).deliver_now
    end

    ApplicationMailer.new_visitor_notify_admin(params)

    redirect_to :back and return
  end

  private
end