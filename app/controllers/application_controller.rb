class ApplicationController < ActionController::Base
  include Domicile::CookieHelpers

  def render_cell(page_cell:, header_cell:, cell_object: nil, layout: 'full', status: :ok, **options)
    @html_head = header_cell
    render(html: cell(page_cell, cell_object, options).(), layout: layout, status: status)
  end

  private

  def check_scenario_accessability!(id)
    if id.present?
      result = Scenario::Operation::CheckAccessability.(id: id, current_user: current_user)
      if result.failure?
        flash[:alert] = "Scenario not found... You can see an overview of your created Scenrios below"
        redirect_to scenarios_path
      end
    end
  end

  def check_participation_accessability!(id)
    if id.present?
      result = Participation::Operation::CheckAccessability.(id: id, current_user: current_user)
      if result.failure?
        flash[:alert] = "Participation not found... You can see an overview of your Participations below"
        redirect_to participations_path
      end
    end
  end
end
