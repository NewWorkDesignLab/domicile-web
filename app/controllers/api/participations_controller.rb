class Api::ParticipationsController < Api::BaseController
  def index
    render json: current_user.participations
  end

  def create
    render json: "not implemented yet"
  end

  def show
    render json: "not implemented yet"
  end

  def update
    render json: "not implemented yet"
  end

  def destroy
    render json: "not implemented yet"
  end
end
