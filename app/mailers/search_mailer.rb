class SearchMailer < ApplicationMailer

  def search_email(search, quotes, email)
    @search = search
    @quotes = quotes
    @email  = email
    mail(to: email, subject: t('email_form.subject'))
  end

end
