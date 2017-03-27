class CreateDockerLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :docker_logs do |t|
      t.references :docker_instance, foreign_key: true
      t.string :text

      t.timestamps
    end
  end
end
