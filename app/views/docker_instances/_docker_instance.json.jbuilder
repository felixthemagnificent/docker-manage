json.extract! docker_instance, :id, :name, :port, :status, :created_at, :updated_at
json.url docker_instance_url(docker_instance, format: :json)
