class ScenariosController < ApplicationController
  before_action :authenticate_user!, except: [:app]
  before_action only: [:show, :edit, :update, :destroy, :online] do
    check_scenario_accessability!(params[:id])
  end

  def index
    render_cell(
      page_cell: Scenario::Cell::Index,
      header_cell: Scenario::Header::Cell::Index
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
      redirect_to scenarios_path
    end
  end

  def create
    result = Scenario::Operation::Create.(params: params, current_user: current_user)

    if result.success?
      create_params = {participation: {scenario_id: result[:model].id}}
      result = Participation::Operation::Create.(params: create_params, current_user: current_user)
      if result.success?
        flash[:notice] = t('.flash.success')
        redirect_to scenario_path(id: result[:model].scenario_id) and return
      end
    end

    flash[:alert] = t('.flash.failure')
    render_cell(
      page_cell: Scenario::Cell::New,
      header_cell: Scenario::Header::Cell::New,
      cell_object: result['contract.default']
    )
  end

  def show
    scenario = current_user.hosted_and_joined_scenarios.find_by(id: params[:id])
    if scenario.present?
      render_cell(
        page_cell: Scenario::Cell::Show,
        header_cell: Scenario::Header::Cell::Show,
        cell_object: scenario
      )
    else
      flash[:alert] = "Scenario nicht gefunden"
      redirect_to scenarios_path
    end
  end

  def edit
    result = Scenario::Operation::Edit.(params: params, current_user: current_user)

    if result.success?
      render_cell(
        page_cell: Scenario::Cell::Edit,
        header_cell: Scenario::Header::Cell::Edit,
        cell_object: result['contract.default']
      )
    else
      flash[:alert] = t('errors.general')
      redirect_to scenarios_path
    end
  end

  def update
    result = Scenario::Operation::Update.(params: params, current_user: current_user)

    if result.success?
      flash[:notice] = t('.flash.success')
      render_cell(
        page_cell: Scenario::Cell::Show,
        header_cell: Scenario::Header::Cell::Show,
        cell_object: result[:model]
      )
    else
      flash[:alert] = t('.flash.failure')
      render_cell(
        page_cell: Scenario::Cell::Edit,
        header_cell: Scenario::Header::Cell::Edit,
        cell_object: result['contract.default']
      )
    end
  end

  def destroy
    render plain: params
  end

  # GET /szenarios/:id/online
  # User MUST be logged in
  # User MUST have access to scenario
  def online
    tokens = current_user.create_new_auth_token
    render_cell(
      page_cell: Scenario::Cell::Spectate,
      header_cell: Scenario::Header::Cell::Spectate,
      cell_object: tokens
    )
  end

  # GET /szenarios/:id/app
  # User MUST NOT be logged in
  # User MUST NOT have access to scenario
  def app
    # render plain: "open app with deep link for sceanrio ##{params[:id]}"
    redirect_to "domicile://open?s=#{params[:id]}"
  end

  # GET /szenarios/:id/join
  # User MUST be logged in
  # User MUST NOT have access to scenario
  def join
    scenario = Scenario.find_by(id: params[:id])

    unless scenario.present?
      flash[:alert] = "Sie wurden zu einem Szenario eingeladen, welches nicht mehr existiert."
      redirect_to index_path and return
    end

    if current_user.hosted_and_joined_scenarios.exists?(id: scenario.id)
      flash[:notice] = "Sie wurden zu einem Szenario eingeladen, zu welchem Sie bereits Zugriff haben."
      redirect_to scenario and return
    end

    if scenario.is_password_secured?
      render_cell(
        page_cell: Scenario::Cell::Password,
        header_cell: Scenario::Header::Cell::Password,
        cell_object: scenario
      )
    else
      render_cell(
        page_cell: Scenario::Cell::Join,
        header_cell: Scenario::Header::Cell::Join,
        cell_object: scenario
      )
    end
  end
end
