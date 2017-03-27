class AddBranchToDockerInstances < ActiveRecord::Migration[5.0]
  def change
    add_column :docker_instances, :branch, :string
  end
end
