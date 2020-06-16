class SpectatorChannel < ApplicationCable::Channel
  def subscribed
    stream_from "spectate_participation_#{params[:id]}"
  end

  def receive(data)
    ActionCable.server.broadcast("spectate_participation_#{params[:id]}", data)
  end
end
