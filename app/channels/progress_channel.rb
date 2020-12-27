class ProgressChannel < ApplicationCable::Channel
  def subscribed
    stream_from "progress_#{params[:id]}" if params[:id]
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
