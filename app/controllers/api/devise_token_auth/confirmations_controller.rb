class Api::DeviseTokenAuth::ConfirmationsController < DeviseTokenAuth::ConfirmationsController
  protect_from_forgery with: :null_session

  # Re-sends confirmation email
  # POST /api/auth/confirmation (email, redirect_url)
  #
  #  http://localhost:3000/api/auth/confirmation?email=tobiasbohn1998@gmail.com&redirect_url=http://localhost:3000
  #  # => RESPONSE: {"success":true,"message":"translation missing: de.devise_token_auth.confirmations.sended"}
  def create
    super
  end
end
