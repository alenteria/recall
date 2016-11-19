module ApplicationHelper
  def controller_name
    params[:controller].gsub('/', '_')
  end

  def action_name
    params[:action].gsub('/', '_')
  end

  def has_preloaded_modal?
    controller = params[:controller].gsub('/', '_')
    controller.in?('auth_sessions')
  end

  def body_class
    klass = ''
    if has_preloaded_modal?
      klass << 'modal-open'
    end
    klass
  end

  def format_email_signup_errors(user)
    if 'has already been taken'.in? user.errors[:email]
      reset_link = link_to('here', new_password_path(resource_name), style:'text-decoration:underline;')
      user.errors[:email].unshift "has already been taken, if you forgot the password reset it #{reset_link}".html_safe
    end
  end

  def resend_confirmation_link
    return unless flash[:alert].to_s.include? 'confirm your email'
    resend_link = link_to('Resend', new_confirmation_path(resource_name, email: resource.email), style:'text-decoration:underline;')
    "<p>Didn't receive the confirmation link? #{resend_link}</p><br>".html_safe
  end

  def active_list(path, options)
    options[:active] ||= :exclusive
    attributes = options[:attributes]
    attributes[:class] += " #{active_link_to_class(path, active: options[:active])}"
    content_tag :li, attributes do
      yield path
    end
  end

  def flash_messages
    key = flash.keys.first
    flash[key]
  end

  def flash_type
    key = flash.keys.first.to_s
    case key
    when 'alert', 'error'
      'danger'
    when 'warning', 'notice'
      'warning'
    else
      "#{key}"
    end
  end
end
