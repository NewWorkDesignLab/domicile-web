class Api::ExecutionsController < Api::BaseController
  before_action -> { check_execution_accessability!(params[:id]) }
  wrap_parameters :execution, include: [:participation_id], format: [:json]

  # Create new Execution of Participation.
  # POST /api/executions (participation_id)
  def create
    result = Execution::Operation::Create.(params: params)

    if result.success?
      render json: result[:model]
    else
      render json: {errors:["Ein Fehler ist aufgetreten."]}.to_json, status: :bad_request
    end
  end

  # Upload Images to existing Execution.
  # POST /api/executions/:id/images
  def upload_images
    result = Execution::Operation::UploadImages.(params: params)

    if result.success?
      render json: result[:model]
    else
      render json: {errors:["Ein Fehler ist aufgetreten."]}.to_json, status: :bad_request
    end
  end
end
