module SessionsHelper
  def flash_message
    flash.map do |key, message|
      render partial: 'shared/alert', locals: { text: message, css_class: key }
    end.join.html_safe
  end
end
