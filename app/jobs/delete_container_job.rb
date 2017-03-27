require 'docker-api'

class DeleteContainerJob < ApplicationJob
  queue_as :default

  def perform(docker_instance_entity_name)
    # Do something laterActionCable.server.broadcast 'status_channel',
    container = Docker::Container.get(docker_instance_entity_name)
    container.kill
  end
end
