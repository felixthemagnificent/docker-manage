class DockerInstance < ApplicationRecord
  has_many :docker_logs, dependent: :destroy
  validates :branch, presence: true
  enum status: [:creating, :running, :stopped]
  after_create do
    AddContainerJob.perform_later self
  end

  before_destroy do
    self.delete_row
    DeleteContainerJob.perform_later self.name
  end

  def reload_row
    html = ApplicationController.renderer.render(
      partial: 'docker_instances/table_row',
      locals: { docker_instance: self }
    )
    ActionCable.server.broadcast 'status_channel', { command: 'reload_row', id: self.id, html: html }
  end

  def delete_row
    ActionCable.server.broadcast 'status_channel', { command: 'delete_row', id: self.id }
  end

  def get_logs
    docker_logs.pluck(:text).join("\n").gsub("\n",'<br>').html_safe
  end

  def log text
    DockerLog.create docker_instance: self, text: text
    ActionCable.server.broadcast 'status_channel', { command: 'send_logs', id: self.id, text: text }
  end
end
