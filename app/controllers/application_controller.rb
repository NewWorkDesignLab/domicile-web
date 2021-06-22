class ApplicationController < ActionController::Base
  include Domicile::CookieHelpers
  protect_from_forgery with: :exception

  def render_cell(page_cell:, header_cell:, cell_object: nil, layout: 'full', status: :ok, **options)
    @html_head = header_cell
    cell_object_with_user = {current_user: current_user, object: cell_object}
    render(html: cell(page_cell, cell_object_with_user, options).(), layout: layout, status: status)
  end

  private

  def check_scenario_accessability!(id)
    if id.present?
      if !current_user.hosted_and_joined_scenarios.exists?(id: id)
        flash[:alert] = "Scenario not found... You can see an overview of your Scenrios below"
        redirect_to scenarios_path
      end
    end
  end

  def check_participation_accessability!(id)
    if id.present?
      if !current_user.available_participations.exists?(id: id)
        flash[:alert] = "Participation not found... You can see an overview of your Participations below"
        redirect_to scenarios_path
      end
    end
  end

  def check_execution_accessability!(id)
    if id.present?
      if !current_user.executions.exists?(id: id) && !current_user.executions_through_scenarios.exists?(id: id)
        flash[:alert] = "Execution not found..."
        redirect_to participations_path
      end
    end
  end
end
