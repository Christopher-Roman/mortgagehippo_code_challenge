class AdminAlertMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.admin_alert_mailer.coins_low.subject
  #
  def coins_low(coin)
    @coin = coin

    mail to: "tophy912@gmail.com"
  end
end
