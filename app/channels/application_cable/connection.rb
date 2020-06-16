module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      params = request.query_parameters()
      access_token = params["access-token"]
      uid = params["uid"]
      client = params["client"]

      self.current_user = find_verified_user(access_token, uid, client)
      logger.add_tags 'ActionCable', current_user.email
    end

    protected

    def find_verified_user(access_token, uid, client)
      # Socket Connection from Browser
      if verified_user = env['warden'].user
        verified_user
      # Socket Connection over API
      elsif User.exists?(email: uid) && User.find_by(email: uid)&.valid_token?(access_token, client)
        User.find_by(email: uid)
      else
        reject_unauthorized_connection
      end
    end
  end
end
