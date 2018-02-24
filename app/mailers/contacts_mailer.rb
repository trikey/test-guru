class ContactsMailer < ApplicationMailer
  def submited_form(contact)
    @name = contact.name
    @text = contact.text
    @email = contact.email

    mail to: Admin.first.email, subject: 'Contact form filled!'
  end
end
