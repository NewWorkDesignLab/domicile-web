class Scenarios::ParticipationsController < ApplicationController
  before_action :authenticate_user!
  before_action -> { check_scenario_accessability!(params[:scenario_id]) }

  def index
    render_cell(
      page_cell: Scenario::Participation::Cell::Index,
      header_cell: Scenario::Participation::Header::Cell::Index,
      cell_object: current_user
    )
  end

  def show
    render_cell(
      page_cell: Scenario::Participation::Cell::Show,
      header_cell: Scenario::Participation::Header::Cell::Show,
      cell_object: current_user
    )
  end
end