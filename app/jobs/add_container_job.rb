require 'docker-api'

class AddContainerJob < ApplicationJob
  queue_as :default

  def perform(docker_instance_entity)
    # Do something laterActionCable.server.broadcast 'status_channel',
    container_port = find_available_port
    container = Docker::Container.create(
      'Image': 'fitness_crm_ruby',
      'VolumesFrom': ['gems'],
      'LogConfig': {
          'Type': 'fluentd',
          'Config': {}
      },
      "PortBindings": {
          "443/tcp": [
              {
                "HostIp": "",
                "HostPort": container_port.to_s
              }
          ]
      },
      )
    docker_instance_entity.name = container.json['Name'].gsub('/','')
    docker_instance_entity.port = container_port
    container.start
    docker_instance_entity.running!
    docker_instance_entity.save
    docker_instance_entity.reload_row
    # tap(&:start).attach do |stream, chunk|
    #   new_log_string = "#{chunk}"
    #   new_log_string.gsub!(/(?:\n\r?|\r\n?)/, '<br>')
    #   ActionCable.server.broadcast 'status_channel', new_log_string
    # end
  end

  private
  def find_available_port
    ((DockerInstance.all.pluck(:port) - [nil]).sort.try(:last) || 3000) + 1
  end
end
