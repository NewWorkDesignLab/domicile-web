class Api::DeviseTokenAuth::RegistrationsController < DeviseTokenAuth::RegistrationsController
  protect_from_forgery with: :null_session

  # Account updates. Update an existing account
  # PUT /api/auth (uid, client, access-token, password, password-confirmation, current_password)
  #
  #  http://localhost:3000/api/auth?uid=tobiasbohn1998@gmail.com&client=A-zC-77G2lGhPqY_T6iO9Q&access-token=K4BegC7uTJAKkjacUkvP2w&password=1234567890&password_confirmation=1234567890&current_password=12345678
  #  # => RESPONSE: {"status":"success","data":{"id":4,"email":"tobiasbohn1998@gmail.com","provider":"email","uid":"tobiasbohn1998@gmail.com","created_at":"2020-05-05T17:16:12.478Z","updated_at":"2020-05-05T17:45:56.359Z","allow_password_change":false}}
  #  # => WWW-HEADER: {"access-token":"...","client":"...","expiry":"...","uid":"..."}
  def update
    super
  end

  # Account deletion.
  # DELETE /api/auth (uid, access-token, client)
  #
  #  http://localhost:3000/api/auth?uid=tobiasbohn1998@gmail.com&client=A-zC-77G2lGhPqY_T6iO9Q&access-token=fP71O3PZ6c3fElRygkGDCg
  #  # => RESPONSE: {"status":"success","message":"Account mit der uid 'tobiasbohn1998@gmail.com' wurde gelöscht."}
  def destroy
    super
  end

  # Email registration.
  # POST /api/auth (email, password, password_confirmation, confirm_success_url)
  #
  #  http://localhost:3000/api/auth?email=tobiasbohn1998@gmail.com&password=12345678&password_confirmation=12345678&confirm_success_url=http://localhost:3000
  #  # => RESPONSE: {"status":"success","data":{"id":4,"email":"tobiasbohn1998@gmail.com","created_at":"2020-05-05T17:16:12.478Z","updated_at":"2020-05-05T17:16:12.478Z","provider":"email","uid":"tobiasbohn1998@gmail.com"}}
  def create
    super
  end
end
