class ScenariosController < ApplicationController
  def new
    result = Scenario::Operation::Present.(params: params)

    if result.success?
      render_cell(
        page_cell: Scenario::Cell::New,
        header_cell: Scenario::Header::Cell::New,
        cell_object: result['contract.default']
      )
    else
      flash[:alert] = "Something went wrong"
      redirect_to index_path
    end
  end

  def create

  end
end