class SpectatorChannel < ApplicationCable::Channel
  def subscribed
    reject unless current_user&.available_participations.exists?(id: params[:id])
    stream_from "spectate_participation_#{params[:id]}"
  end

  def update_transform(data)
    ActionCable.server.broadcast("spectate_participation_#{params[:id]}", data)
  end
end
