class ScenariosController < ApplicationController
  before_action :authenticate_user!

  def index
    render_cell(
      page_cell: Scenario::Cell::Index,
      header_cell: Scenario::Header::Cell::Index,
      cell_object: current_user
    )
  end

  def new
    render_cell(
      page_cell: Scenario::Cell::New,
      header_cell: Scenario::Header::Cell::New,
      cell_object: current_user
    )
  end

  def create
    render plain: params
  end

  def show
    render_cell(
      page_cell: Scenario::Cell::Show,
      header_cell: Scenario::Header::Cell::Show,
      cell_object: current_user
    )
  end

  def destroy
    render plain: params
  end










  # before_action :authenticate!, only: :show

  # def new
  #   result = Scenario::Operation::Present.(params: params)

  #   if result.success?
  #     render_cell(
  #       page_cell: Scenario::Cell::New,
  #       header_cell: Scenario::Header::Cell::New,
  #       cell_object: result['contract.default']
  #     )
  #   else
  #     flash[:alert] = "Something went wrong."
  #     redirect_to index_path
  #   end
  # end

  # def create
  #   result = Scenario::Operation::Create.(params: params)

  #   if result.success?
  #     scenario_auth_cookie(result[:model])
  #     flash[:notice] = "Successfully created Scenario."
  #     redirect_to scenario_path(id: result[:model].id)
  #   else
  #     render_cell(
  #       page_cell: Scenario::Cell::New,
  #       header_cell: Scenario::Header::Cell::New,
  #       cell_object: result['contract.default']
  #     )
  #   end
  # end

  # def show
  #   # scenario does exist for shure - proven in authenticate!
  #   render_cell(
  #     page_cell: Scenario::Cell::Show,
  #     header_cell: Scenario::Header::Cell::Show,
  #     cell_object: Scenario.find(params[:id])
  #   )
  # end

  # def auth
  #   scenario = Scenario.find_by(id: params[:id])
  #   if scenario&.authenticate(params[:password][:password])
  #     scenario_auth_cookie(scenario)
  #     flash[:notice] = nil
  #     redirect_to scenario_path(id: scenario.id)
  #   elsif scenario.present?
  #     flash[:alert] = "Wrong Password."
  #     render_cell(
  #       page_cell: Scenario::Cell::Auth,
  #       header_cell: Scenario::Header::Cell::Auth
  #     )
  #   else
  #     flash[:alert] = "Scenario not found."
  #     redirect_to index_path
  #   end
  # end

  # def destroy
  #   flash[:notice] = "Successfully closed scenario."
  #   redirect_to index_path
  # end

  # private 

  # def authenticate!
  #   if authenticated?
  #     true
  #   elsif Scenario.exists?(id: params[:id])
  #     flash[:notice] = "You need to authenticate."
  #     render_cell(
  #       page_cell: Scenario::Cell::Auth,
  #       header_cell: Scenario::Header::Cell::Auth
  #     )
  #   else
  #     flash[:alert] = "Scenario not found."
  #     redirect_to index_path
  #   end
  # end

  # def authenticated?
  #   cookie = scenario_auth_cookie
  #   scenario = Scenario.find_by(id: cookie&.[](:value))
  #   return false if cookie.blank? || scenario.blank?
    
  #   scenario.id.to_s == params[:id] && scenario.created_at.to_time.to_i == cookie[:time].to_time.to_i
  # end
end