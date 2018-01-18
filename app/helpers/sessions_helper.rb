module SessionsHelper
  def flash_message
    flash.map do |key, message|
      content_tag :p, message, class: "flash #{key}"
    end.join.html_safe
  end
end
