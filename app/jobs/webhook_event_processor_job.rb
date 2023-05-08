class WebhookEventProcessorJob < ApplicationJob
  queue_as :default

  def perform(webhook)
    process_webhook(webhook.payload)
  end

  private

  def process_webhook(payload)
    # Implement your business logic to process the webhook payload
    puts "Received webhook payload: #{payload}"
    ActionCable.server.broadcast "WebhooksChannel", payload
  end
end
