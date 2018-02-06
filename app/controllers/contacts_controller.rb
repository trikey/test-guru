class ContactsController < ApplicationController

  def index; end

  def submit
    @model = Contact.new(contact_params)
    if @model.valid?
      ContactsMailer.submited_form(@model).deliver_now
      redirect_to contacts_path, notice: "Thank you, #{@model.name}! We will contact you soon"
    else
      render :index
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :text)
  end

end
