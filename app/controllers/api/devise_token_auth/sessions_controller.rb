class Api::DeviseTokenAuth::SessionsController < DeviseTokenAuth::SessionsController
  # skip_before_action :protect_from_forgery
  protect_from_forgery with: :null_session

  # Email authentication.
  # POST /api/auth/sign_in (email, password)
  #
  #  http://localhost:3000/api/auth/sign_in?email=info@tobiasbohn.com&password=[FILTERED]
  #  # => RESPONSE: {"data":{"id":1,"email":"info@tobiasbohn.com","provider":"email","uid":"info@tobiasbohn.com"}}
  #  # => WWW-HEADER: {"access-token":"...","client":"...","expiry":"...","uid":"..."}
  def create
    super
  end

  # End Users current Session. Will invalidate Users authentication Token.
  # DELETE /api/auth/sign_out (uid, client, access-token)
  #
  #  http://localhost:3000/api/auth/sign_out?uid=tobiasbohn1998@gmail.com&client=ezaH1TVmTLhMNWvTg8PULw&access-token=eyahIuwcC_itSeu0sVoanQ
  #  # => RESPONSE: {"success":true}
  def destroy
    super
  end
end
