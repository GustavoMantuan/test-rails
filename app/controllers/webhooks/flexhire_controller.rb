class Webhooks::FlexhireController < Webhooks::BaseController
  # A controller for catching new flexhire webhooks
  #
  # To send a sample webhook locally:
  #
  #   curl -X POST http://localhost:3000/webhooks/flexhire
  #     -H 'Content-Type: application/json'
  #     -d '{"eventName":"test", recordIds: 13asdasda1}'
  #
  # If you'd like to override the base controller's behavior, you can do so here
  # def create
  #   head :ok
  # end
  def create
    # Save webhook to database
    record = WebhookEvent.create!(eventName: eventName, recordsIds: recordsIds, payload: payload)
    record.save()

    # Queue database record for processing
    WebhookEventProcessorJob.perform_later(record)
    head :ok
  end

  private

  def eventName
    @eventName ||= request.body.read
  end

  def recordsIds
    @recordsIds ||= request.body.read
  end

  def payload
    @payload ||= request.body.read
  end
end
