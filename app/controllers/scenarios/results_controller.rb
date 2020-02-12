class Scenarios::ResultsController < ApplicationController
  before_action :authenticate_user!
  before_action -> { check_scenario_accessability!(params[:scenario_id]) }

  def show
    render_cell(
      page_cell: Scenario::Result::Cell::Show,
      header_cell: Scenario::Result::Header::Cell::Show,
      cell_object: current_user
    )
  end
end