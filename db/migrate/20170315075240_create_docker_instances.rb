class CreateDockerInstances < ActiveRecord::Migration[5.0]
  def change
    create_table :docker_instances do |t|
      t.string :name
      t.integer :port
      t.integer :status

      t.timestamps
    end
  end
end
