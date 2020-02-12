class ParticipationsController < ApplicationController
  before_action :authenticate_user!

  def index
    render_cell(
      page_cell: Participation::Cell::Index,
      header_cell: Participation::Header::Cell::Index,
      cell_object: current_user
    )
  end

  def new
    render_cell(
      page_cell: Participation::Cell::New,
      header_cell: Participation::Header::Cell::New,
      cell_object: current_user
    )
  end

  def create
    render plain: params
  end

  def show
    render_cell(
      page_cell: Participation::Cell::Show,
      header_cell: Participation::Header::Cell::Show,
      cell_object: current_user
    )
  end

  def destroy
    render plain: params
  end
end