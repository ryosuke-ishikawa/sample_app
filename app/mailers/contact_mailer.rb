class ContactMailer < ActionMailer::Base
  default from: "ryosuke630617@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.contact_mailer.sent.subject
  #
  def sent(contact)
    @contact = contact
    mail(to: @contact.email, subject: "Thank you for your contact!")
    
  end
  
  def received(contact)
    @contact = contact
    mail(to: "ryosuke630617@gmail.com", subject: "お問い合わせがありました。")
  end
end
