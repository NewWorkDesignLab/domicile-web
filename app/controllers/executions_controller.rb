class ExecutionsController < ApplicationController
  before_action do
    authenticate_user!()
    check_execution_accessability!(params[:id])
  end

  def show
    render_cell(
      page_cell: Execution::Cell::Show,
      header_cell: Execution::Header::Cell::Show,
      cell_object: current_user
    )
  end

  def destroy
    render plain: params
  end
end
