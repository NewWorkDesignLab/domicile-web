class ApiController < ApplicationController
  def user
    if User.exists?(email: params[:email])
      user = User.find_by(email: params[:email])
      render json: {success: true, model: user}.to_json
    else
      render json: {success: false}.to_json
    end
  end

  def image

  end

  def result
    if User.exists?(email: params[:email])
      user = User.find_by(email: params[:email])
      participation = user.participations.first
      if participation.present?
        result = Result.create(participation: participation)
        render json: {success: true, model: result}.to_json
      else
        render json: {success: false}.to_json
      end
    end
  end
end
