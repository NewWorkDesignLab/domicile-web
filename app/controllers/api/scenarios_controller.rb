class Api::ScenariosController < Api::BaseController
  # Return all Scenarios a User created.
  # GET /api/scenarios
  def index
    render json: current_user.scenarios
  end

  # Create new Scenario for User.
  # POST /api/scenarios (number_rooms, time_timit, number_damages, name, password, password_confirmation)
  def create
    result = Scenario::Operation::Create.(params: params, current_user: current_user)

    if result.success?
      render json: result[:model]
    else
      render json: {errors:["Ein Fehler ist aufgetreten."]}.to_json, status: :bad_request
    end
  end

  # Return single Scenario.
  # GET /api/scenarios/:id
  def show
    if Scenario.exists?(id: params[:id])
      render json: Scenario.find(params[:id])
    else
      render json: {errors:["Scenario nicht gefunden."]}.to_json, status: :not_found
    end
  end

  # Update Scenario.
  # PUT /api/scenarios/:id
  def update
    render json: "not implemented yet"
  end

  # Destroy Scenario.
  # DELETE /api/scenarios/:id
  def destroy
    render json: "not implemented yet"
  end
end
