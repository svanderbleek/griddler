class Griddler::EmailsController < ActionController::Base
  def create
    # Mandrill posts array of inbound emails
    raw_emails = [normalized_params].flatten

    raw_emails.each do |raw_email|
      puts raw_email.inspect
      Griddler::Email.new(raw_email).process
    end

    head :ok
  end

  # Mandrill pings processing route
  def ping
    head :ok
  end

  private

  def normalized_params
    Griddler.configuration.email_service.normalize_params(params)
  end
end
