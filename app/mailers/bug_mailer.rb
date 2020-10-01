class BugMailer < ApplicationMailer
  default from: 'noreply@tobiasbohn.com'
  layout 'mailer'

  def android_app_error
    mail(to: 'info@tobiasbohn.com',
            subject: "Domicile Crash Log #{I18n.l(Time.now)}",
            body: "<pre>#{params[:message]}</pre>",
            content_type: 'text/html')
  end
end
