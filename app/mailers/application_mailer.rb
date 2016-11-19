class ApplicationMailer < ActionMailer::Base
  default from: 'Recall.com <noreply@Recall.com>'
  layout 'mailer'

  ADMIN_EMAILS = ['support@Recall.com', 'dangecrisbejoc@gmail.com']

  def contact_us(params)
    parse_params(params)
    mail(to: @email, subject: 'Thank you for writing us.')
  end

  def subscribe(params)
    parse_params(params)
    mail(to: @email, subject: "Thanks for joining Recall' pre-launch waiting list.")
  end

  def new_visitor_notify_admin
    parse_params(params)
    mail(to: ADMIN_EMAILS, subject: "Recall' visitor")
  end

  private
  def parse_params(arg)
    @name = arg[:name]
    @email = arg[:email]
    @message = arg[:message]
  end
end
