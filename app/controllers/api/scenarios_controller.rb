class Api::ScenariosController < ApplicationController

  def create
    scenario = {scenario: request.query_parameters}
    result = Scenario::Api::Operation::Create.(params: scenario)
    render json: {success: result.success?, error: result[:api_error], model: result[:api_model]}
  end

  def destroy
    render json: {success: true}
  end

  def info
    result = Scenario::Api::Operation::Info.(params: params)
    render json: {success: result.success?, error: result[:api_error], model: result[:api_model]}
  end

  def exists
    result = Scenario.exists?(id: params[:id])
    render json: {success: result}
  end

  def auth
    result = Scenario.exists?(id: params[:id]) && Scenario.find(params[:id]).authenticate(params[:password]).present?
    render json: {success: result}
  end
end