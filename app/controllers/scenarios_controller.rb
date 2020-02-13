class ScenariosController < ApplicationController
  before_action :authenticate_user!
  before_action -> { check_scenario_accessability!(params[:id]) }

  def index
    render_cell(
      page_cell: Scenario::Cell::Index,
      header_cell: Scenario::Header::Cell::Index,
      cell_object: current_user.scenarios
    )
  end

  def new
    result = Scenario::Operation::Present.(params: params)

    if result.success?
      render_cell(
        page_cell: Scenario::Cell::New,
        header_cell: Scenario::Header::Cell::New,
        cell_object: result['contract.default']
      )
    else
      flash[:alert] = t('errors.general')
      redirect_to index_path
    end
  end

  def create
    result = Scenario::Operation::Create.(params: params, current_user: current_user)

    if result.success?
      flash[:notice] = t('.flash.create_success')
      redirect_to scenario_path(id: result[:model].id)
    else
      flash[:alert] = t('.flash.create_failure')
      render_cell(
        page_cell: Scenario::Cell::New,
        header_cell: Scenario::Header::Cell::New,
        cell_object: result['contract.default']
      )
    end
  end

  def show
    render_cell(
      page_cell: Scenario::Cell::Show,
      header_cell: Scenario::Header::Cell::Show,
      cell_object: current_user.scenarios.find_by(id: params[:id])
    )
  end

  def edit
    render_cell(
      page_cell: Scenario::Cell::Edit,
      header_cell: Scenario::Header::Cell::Edit
    )
  end

  def update
    render plain: params
  end

  def destroy
    render plain: params
  end
end