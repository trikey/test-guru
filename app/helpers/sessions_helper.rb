module SessionsHelper
  def flash_message
    flashes = flash.map do |key, message|
      render partial: 'shared/alert', locals: { text: message, css_class: key }
    end
    safe_join flashes
  end
end
