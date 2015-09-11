class InvitesController < ApplicationController

  def create
    invite_counter = 0
    i = 0
    emails = params[:invite][:email]
    emails.each do |email|
      name = params[:invite][:name][i]
      phone = params[:invite][:phone][i]
      invite = Invite.new(email: email, name: name, phone: phone)
      invite.sender_id = current_user.id

      if invite.save
        if invite.recipient.nil?
          InviteMailer.delay.new_user_invite(current_user, invite)
          invite_counter += 1
        else
          # the user already exists
        end
      end
      i += 1
    end

    if invite_counter > 0
      render json: {success: true,
        invites: InvitesPresenter.index(Invite.where(sender_id: current_user.id)),
        message: "#{invite_counter} person was successfully invited to Mortgage Club!"}
    else
      render json: {success: false, message: "Error, the email is already invited or not valid!"}
    end
  end

end