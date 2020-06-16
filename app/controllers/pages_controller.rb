class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:dashboard, :spectate]
  before_action -> { check_spectate_accessability!(params[:id]) }

  def index
    if user_signed_in?
      redirect_to dashboard_path
    else
      redirect_to new_user_session_path
    end
  end

  def legal
    render_cell(
      page_cell: Page::Cell::Legal,
      header_cell: Page::Header::Cell::Legal,
      layout: 'application'
    )
  end

  def privacy
    render_cell(
      page_cell: Page::Cell::Privacy,
      header_cell: Page::Header::Cell::Privacy,
      layout: 'application'
    )
  end

  def dashboard
    render_cell(
      page_cell: Page::Cell::Dashboard,
      header_cell: Page::Header::Cell::Dashboard,
      cell_object: current_user
    )
  end

  def spectate
    render_cell(
      page_cell: Page::Cell::Spectate,
      header_cell: Page::Header::Cell::Spectate,
      cell_object: current_user
    )
  end

  private

  def check_spectate_accessability!(id)
    if id.present? && Participation.exists?(id: id)
      scenario = Participation.find_by(id: id).scenario

      if !current_user.scenarios.exists?(id: scenario[:id])
        flash[:alert] = "Connot spectate this Participation"
        redirect_to participations_path
      end
    else
      flash[:alert] = "Participation not found"
      redirect_to participations_path
    end
  end
end
