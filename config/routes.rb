# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :webhooks do
    # /webhooks/flexhire routed to our Webhooks::FlexhireController
    resource :flexhire, controller: :flexhire, only: [:create]

    #ws so the next app can listen to updates
    mount ActionCable.server => '/cable'
  end
end
