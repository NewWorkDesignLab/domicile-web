class Api::ExecutionsController < Api::BaseController
  def index
    render json: Execution.all
  end

  def create
    render json: "create ok"
  end

  def show
    render json: "show ok"
  end

  def update
    render json: "update ok"
  end

  def destroy
    render json: "destroy ok"
  end
end
