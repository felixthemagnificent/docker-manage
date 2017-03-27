class DockerInstancesController < ApplicationController
  skip_before_filter :authenticate_user!, only: :process_log
  before_action :set_docker_instance, only: [:show, :update, :destroy, :log]

  # GET /docker_instances
  # GET /docker_instances.json
  def index
    @docker_instances = DockerInstance.all
    @docker_instance = DockerInstance.new
  end

  # GET /docker_instances/1
  # GET /docker_instances/1.json
  def show
  end

  # GET /docker_instances/log
  def process_log
    container_name = params['container_name'].gsub('/','')
    log_text = params['log']
    instance = DockerInstance.where(name: container_name).try(:first)
    if instance
      instance.log log_text
    end
    render json: nil
  end

  # GET /docker_instances/:id/log
  def log

  end

  # POST /docker_instances
  # POST /docker_instances.json
  def create
    @docker_instance = DockerInstance.new(docker_instance_params)
    @docker_instance.creating!
    respond_to do |format|
      if @docker_instance.save
        format.js
      else
        format.html { render :new }
        format.json { render json: @docker_instance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /docker_instances/1
  # PATCH/PUT /docker_instances/1.json
  def update
    respond_to do |format|
      if @docker_instance.update(docker_instance_params)
        format.html { redirect_to @docker_instance, notice: 'Docker instance was successfully updated.' }
        format.json { render :show, status: :ok, location: @docker_instance }
      else
        format.html { render :edit }
        format.json { render json: @docker_instance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /docker_instances/1
  # DELETE /docker_instances/1.json
  def destroy
    @docker_instance.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_docker_instance
      @docker_instance = DockerInstance.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def docker_instance_params
      params.require(:docker_instance).permit(:name, :branch)
    end
end
