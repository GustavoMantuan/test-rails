class WebhooksChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'WebhooksChannel'
  end

  def unsubscribed
    # Any cleanup needed when the channel is unsubscribed
  end
end