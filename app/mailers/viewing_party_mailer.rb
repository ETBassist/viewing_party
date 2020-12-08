class ViewingPartyMailer < ApplicationMailer
  def inform(email_info, recipient)
    @user = email_info[:user]
    @message = email_info[:message]
    @friend = email_info[:friend]
    mail(
      reply_to: @user.email,
      to: recipient,
      subject: "#{@user.name} invited you to a movie night!"
    )
  end
end
