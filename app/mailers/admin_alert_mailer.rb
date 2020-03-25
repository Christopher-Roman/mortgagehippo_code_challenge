class AdminAlertMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.admin_alert_mailer.coins_low.subject
  #
  def coins_low(coin, value)
  	@coin = coin
    @value = value

    @recipients = Admin.all()
    if @recipients
	    emails = @recipients.collect(&:email)
	    mail to: emails, subject: "Coin Inventory Alert"
	end
  end
end
