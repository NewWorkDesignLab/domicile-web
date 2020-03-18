class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token

  def user
    if User.exists?(email: params[:email])
      user = User.find_by(email: params[:email])
      render json: {success: true, model: user}.to_json
    else
      render json: {success: false}.to_json
    end
  end

  def image
    if User.exists?(email: params[:email])
      user = User.find_by(email: params[:email])
      execution = user.participations.first.executions.first
      if execution.present? && params[:image].present?
        execution.images.attach(params[:image])
        render json: {success: true}.to_json
        puts "SUCCEESSSSSS"
      else
        render json: {success: false}.to_json
        puts "ERERRRROROROROROORORORORORRO"
      end
    end
  end

  def execution
    if User.exists?(email: params[:email])
      user = User.find_by(email: params[:email])
      participation = user.participations.first
      if participation.present?
        execution = Execution.create(participation: participation)
        render json: {success: true, model: execution}.to_json
      else
        render json: {success: false}.to_json
      end
    end
  end
end
