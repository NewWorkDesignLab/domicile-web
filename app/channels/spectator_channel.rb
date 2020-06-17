class SpectatorChannel < ApplicationCable::Channel
  def subscribed
    check_participation_accessibility
    stream_from "spectate_participation_#{params[:id]}"
  end

  def update_transform(data)
    ActionCable.server.broadcast("spectate_participation_#{params[:id]}", data)
  end

  private

  def check_participation_accessibility
    unless current_user&.available_participations.exists?(id: params[:id])
      reject_unauthorized_connection
    end
  end
end
