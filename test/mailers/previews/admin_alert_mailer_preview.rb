# Preview all emails at http://localhost:3000/rails/mailers/admin_alert_mailer
class AdminAlertMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/admin_alert_mailer/coins_low
  def coins_low
    AdminAlertMailer.coins_low
  end

end
