require 'test_helper'

class DockerInstancesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @docker_instance = docker_instances(:one)
  end

  test "should get index" do
    get docker_instances_url
    assert_response :success
  end

  test "should get new" do
    get new_docker_instance_url
    assert_response :success
  end

  test "should create docker_instance" do
    assert_difference('DockerInstance.count') do
      post docker_instances_url, params: { docker_instance: { name: @docker_instance.name, port: @docker_instance.port, status: @docker_instance.status } }
    end

    assert_redirected_to docker_instance_url(DockerInstance.last)
  end

  test "should show docker_instance" do
    get docker_instance_url(@docker_instance)
    assert_response :success
  end

  test "should get edit" do
    get edit_docker_instance_url(@docker_instance)
    assert_response :success
  end

  test "should update docker_instance" do
    patch docker_instance_url(@docker_instance), params: { docker_instance: { name: @docker_instance.name, port: @docker_instance.port, status: @docker_instance.status } }
    assert_redirected_to docker_instance_url(@docker_instance)
  end

  test "should destroy docker_instance" do
    assert_difference('DockerInstance.count', -1) do
      delete docker_instance_url(@docker_instance)
    end

    assert_redirected_to docker_instances_url
  end
end
