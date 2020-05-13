class Api::ParticipationsController < Api::BaseController
  before_action -> { check_participation_accessability!(params[:id]) }

  # Return all Participations a User have.
  # GET /api/participations
  def index
    render json: current_user.participations
  end

  # Create new Participation for User.
  # POST /api/participations
  def create
    result = Participation::Operation::Create.(params: params, current_user: current_user)

    if result.success?
      render json: result[:model]
    else
      render json: {errors:["Ein Fehler ist aufgetreten."]}.to_json, status: :bad_request
    end
  end

  # Return single Participation.
  # GET /api/participations/:id
  def show
    if Participation.exists?(id: params[:id])
      render json: Participation.find(params[:id])
    else
      render json: {errors:["Teilnahme nicht gefunden."]}.to_json, status: :not_found
    end
  end
end
