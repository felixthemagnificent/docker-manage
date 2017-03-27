class StatusUpdateJob < ApplicationJob
  queue_as :default

  def perform(*args)
    ActionCable.server.broadcast 'room_channel', message: 'asdf'
  end
end
