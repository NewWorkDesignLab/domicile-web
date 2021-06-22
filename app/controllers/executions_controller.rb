class ExecutionsController < ApplicationController
  before_action do
    authenticate_user!()
    check_execution_accessability!(params[:id])
  end

  def show
    execution = current_user.executions.find_by(id: params[:id])
    execution ||= current_user.executions_through_scenarios.find_by(id: params[:id])
    if execution.present?
      render_cell(
        page_cell: Execution::Cell::Show,
        header_cell: Execution::Header::Cell::Show,
        cell_object: execution
      )
    else
      flash[:alert] = "Execution nicht gefunden"
      redirect_to index_path
    end
  end

  def destroy
    render plain: params
  end
end
