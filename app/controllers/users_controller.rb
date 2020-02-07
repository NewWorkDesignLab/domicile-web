class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    render_cell(
      page_cell: User::Cell::Show,
      header_cell: User::Header::Cell::Show,
      cell_object: current_user
    )
  end
end
