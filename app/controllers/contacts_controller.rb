class ContactsController < ApplicationController
	def new
		@contact = Contact.new
	end

	def create
		@contact = Contact.new(contact_params)

		if @contact.save
			name = params[:contact][:name]
			email = params[:contact][:email]
			body = params[:contact][:commments]

			ContactMailer.contact_email(name, email, body).deliver
			flash[:success] = 'Massage sent successfully'
			redirect_to root_path
		else
			flash[:danger] = 'Massage not sent '
			render new_contact_path, notice: 'Massage not sent!!'
		end
	end

	private

	def contact_params
		params.require(:contact).permit(:name, :email, :commments )
	end
end
