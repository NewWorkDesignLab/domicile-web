class ResultsController < ApplicationController
  before_action :authenticate_user!
  before_action -> { check_participation_accessability!(params[:participation_id]) }

  def show
    render_cell(
      page_cell: Results::Cell::Show,
      header_cell: Results::Header::Cell::Show,
      cell_object: current_user
    )
  end

  def destroy
    render plain: params
  end
end