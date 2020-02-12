class ResultsController < ApplicationController
  before_action :authenticate_user!

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