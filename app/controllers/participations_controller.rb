class ParticipationsController < ApplicationController
  before_action do
    authenticate_user!()
    check_participation_accessability!(params[:id])
  end

  def index
    render_cell(
      page_cell: Participation::Cell::Index,
      header_cell: Participation::Header::Cell::Index,
      cell_object: current_user.participations
    )
  end

  def new
    result = Participation::Operation::Present.(params: params)

    if result.success?
      render_cell(
        page_cell: Participation::Cell::New,
        header_cell: Participation::Header::Cell::New,
        cell_object: result['contract.default']
      )
    else
      flash[:alert] = t('errors.general')
      redirect_to index_path
    end
  end

  def create
    result = Participation::Operation::Create.(params: params, current_user: current_user)

    if result.success?
      flash[:notice] = t('.flash.create_success')
      redirect_to participation_path(id: result[:model].id)
    else
      flash[:alert] = result['contract.default'].errors.messages[:user]&.first || t('.flash.create_failure')
      render_cell(
        page_cell: Participation::Cell::New,
        header_cell: Participation::Header::Cell::New,
        cell_object: result['contract.default']
      )
    end
  end

  def show
    result = current_user.available_participations.find_by(id: params[:id])

    if result.present?
      render_cell(
        page_cell: Participation::Cell::Show,
        header_cell: Participation::Header::Cell::Show,
        cell_object: result
      )
    else
      flash[:alert] = "Nicht gefunden"
      redirect_to dashboard_path
    end
  end

  def destroy
    render plain: params
  end
end
