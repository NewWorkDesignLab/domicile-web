class Api::DeviseTokenAuth::PasswordsController < DeviseTokenAuth::PasswordsController
  # skip_before_action :protect_from_forgery
  protect_from_forgery with: :null_session

  # Change Users Password.
  # PUT /api/auth/password (password, password_confirmation, current_password, uid, client, access-token)
  #
  #  http://localhost:3000/api/auth/password?password=12345678&password_confirmation=12345678&current_password=1234567890&access-token=2e1BILORtIqz0-UgtcYUiQ&uid=tobiasbohn1998@gmail.com&client=A-zC-77G2lGhPqY_T6iO9Q
  #  # => RESPONSE: {"success":true,"data":{"id":4,"provider":"email","allow_password_change":false,"email":"tobiasbohn1998@gmail.com","uid":"tobiasbohn1998@gmail.com","created_at":"2020-05-05T17:16:12.478Z","updated_at":"2020-05-05T17:41:18.802Z"},"message":"Ihr Passwort wurde erfolgreich aktualisiert."}
  #  # => WWW-HEADER: {"access-token":"...","client":"...","expiry":"...","uid":"..."}
  def update
    super
  end

  # Send a password reset confirmation Email.
  # POST /api/auth/password (email, redirect_url)
  #
  #  http://localhost:3000/api/auth/password?email=tobiasbohn1998@gmail.com&redirect_url=http://localhost:3000
  #  # => RESPONSE: {"success":true,"message":"Ein E-Mail mit der Anleitung zum Zurücksetzen Ihres Passwortes wurde an 'tobiasbohn1998@gmail.com' gesendet."}
  def create
    super
  end
end
